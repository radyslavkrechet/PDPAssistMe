//
//  ProductViewController.swift
//  AssistMe
//
//  Created by Radyslav Krechet on 4/15/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import UIKit
import AssisMeCore

class ProductViewController: UIViewController {
    @IBOutlet private(set) weak var imageView: UIImageView!
    @IBOutlet private(set) weak var textLabel: UILabel!
    @IBOutlet private(set) weak var detailTextLabel: UILabel!
    @IBOutlet private(set) weak var valueLabel: UILabel!
    @IBOutlet private(set) weak var valueStepper: UIStepper!
    @IBOutlet private(set) weak var orderButton: UIButton!
    
    var productId: String!

    private var product: Product!
    private var count = 1.0

    // MARK: - View controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupProduct()
        setupUI()
    }

    // MARK: - Setup

    private func setupProduct() {
        product = ProductService.product(withId: productId)
    }

    private func setupUI() {
        setupProductViews()
        setupValueLabel()
    }

    private func setupProductViews() {
        imageView.image = UIImage(named: product.imageName)
        textLabel.text = product.name
        detailTextLabel.text = PriceFormatter.format(product.price)
    }

    private func setupValueLabel() {
        valueLabel.text = PriceFormatter.format(product.price, with: count)
    }

    // MARK: - Actions

    @IBAction private func valueStepperDidChangeValue(_ sender: UIStepper) {
        count = sender.value
        setupValueLabel()
    }

    @IBAction private func orderButtonDidTap(_ sender: UIButton) {
        OrderService.addOrder(with: product, count: count)
        navigationController?.popViewController(animated: true)
    }
}
