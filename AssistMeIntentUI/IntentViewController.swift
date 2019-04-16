//
//  IntentViewController.swift
//  AssistMeIntentUI
//
//  Created by Radyslav Krechet on 4/15/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Intents
import IntentsUI
import AssisMeCore

private let height: CGFloat = 300.0

class IntentViewController: UIViewController, INUIHostedViewControlling {
    @IBOutlet private(set) weak var imageView: UIImageView!
    @IBOutlet private(set) weak var textLabel: UILabel!
    @IBOutlet private(set) weak var detailTextLabel: UILabel!

    // MARK: - INUIHostedViewControlling

    func configureView(for parameters: Set<INParameter>,
                       of interaction: INInteraction,
                       interactiveBehavior: INUIInteractiveBehavior,
                       context: INUIHostedViewContext,
                       completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {

        let intent = interaction.intent as! OrderProductIntent
        let product = ProductService.product(withId: intent.product!.identifier!)!
        let count = intent.count?.doubleValue ?? 1

        imageView.image = UIImage(named: product.imageName)
        textLabel.text = product.name
        detailTextLabel.text = PriceFormatter.format(product.price, with: count)

        let width = extensionContext!.hostedViewMaximumAllowedSize.width
        let size = CGSize(width: width, height: height)

        completion(true, parameters, size)
    }
}
