//
//  StoreViewController.swift
//  AssistMe
//
//  Created by Radyslav Krechet on 4/8/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import UIKit
import AssisMeCore

private let productIdentifier = "product"

class StoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private(set) weak var tableView: UITableView!

    // MARK: - View controller lifecycle

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productViewController = segue.destination as? ProductViewController {
            let product = ProductService.all[tableView.indexPathForSelectedRow!.row]
            productViewController.productId = product.id
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductService.all.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = ProductService.all[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: productIdentifier, for: indexPath)
        cell.imageView?.image = UIImage(named: product.imageName)
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = PriceFormatter.format(product.price)
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
