//
//  OrderProductIntentHandler.swift
//  AssistMeIntent
//
//  Created by Radyslav Krechet on 4/15/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation
import AssisMeCore

class OrderProductIntentHandler: NSObject, OrderProductIntentHandling {

    // MARK: - OrderProductIntentHandling

    func confirm(intent: OrderProductIntent, completion: @escaping (OrderProductIntentResponse) -> Void) {
        let result = OrderProductIntentResponse(code: .ready, userActivity: nil)
        completion(result)
    }

    func handle(intent: OrderProductIntent, completion: @escaping (OrderProductIntentResponse) -> Void) {
        let product = ProductService.product(withId: intent.product!.identifier!)!
        let count = intent.count?.doubleValue ?? 1
        OrderService.addOrder(with: product, count: count)

        let result = OrderProductIntentResponse(code: .success, userActivity: nil)
        completion(result)
    }
}
