//
//  Address.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 19.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import Foundation

struct Address {
    let index: String
    let city: String
    let street: String
}

extension Address {
    init?(json: JSONDictionary) {
        guard
            let index = json["index"] as? String,
            let city = json["city"] as? String,
            let street = json["street"] as? String
            else { return nil }

        self.index = index
        self.city = city
        self.street = street
    }
}
