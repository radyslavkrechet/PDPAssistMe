//
//  OrderService.swift
//  AssisMeCore
//
//  Created by Radyslav Krechet on 4/15/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation
import Intents

private let ordersKey = "orders"

public struct OrderService {
    public static var all: [Order] {
        guard let data = Storage.defaults.data(forKey: ordersKey) else {
            return []
        }

        return try! JSONDecoder().decode([Order].self, from: data)
    }

    public static func addOrder(with product: Product, count: Double) {
        let order = Order(id: UUID(), product: product, count: count)
        var orders = all
        orders.insert(order, at: 0)

        let data = try! JSONEncoder().encode(orders)
        Storage.defaults.set(data, forKey: ordersKey)

        donate(order)
    }

    private static func donate(_ order: Order) {
        let intent = OrderProductIntent()
        intent.product = INObject(identifier: order.product.id, display: order.product.name)
        intent.price = NSNumber(value: order.product.price * order.count)

        if (order.count > 1) {
            intent.count = NSNumber(value: order.count)
        }

        let image = INImage(named: order.product.imageName)
        intent.setImage(image, forParameterNamed: \.product)

        let interaction = INInteraction(intent: intent, response: nil)
        interaction.donate(completion: nil)
    }
}
