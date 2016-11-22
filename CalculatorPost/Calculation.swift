//
//  Calculation.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 19.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import Foundation

struct Calculation {
    let type: String
    let price: Int
    let days: Int

    init?(json: JSONDictionary) {
        guard
            let type = json["type"] as? String,
            let eType = Constants.DeliveryTypes[type],
            let price = json["cost"] as? Int,
            let days = json["days"] as? Int

        else {return nil}

        self.type = eType
        self.price = price
        self.days = days
    }
}
