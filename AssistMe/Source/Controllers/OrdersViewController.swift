//
//  OrdersViewController.swift
//  AssistMe
//
//  Created by Radyslav Krechet on 4/15/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import UIKit
import AssisMeCore

private let orderIdentifier = "order"

class OrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private(set) weak var tableView: UITableView!

    private let orders = OrderService.all

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = orders[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: orderIdentifier, for: indexPath)
        cell.imageView?.image = UIImage(named: order.product.imageName)
        cell.textLabel?.text = order.product.name
        cell.detailTextLabel?.text = PriceFormatter.format(order.product.price, with: order.count)
        return cell
    }
}
