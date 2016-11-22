//
//  CalculationInfo.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 20.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import Foundation

struct CalculationInfo {
    let fromIndex: String
    let toIndex: String
    let fromCity: String
    let toCity: String

    init?(json: JSONDictionary) {
        guard
            let fromIndex = json["from_index"] as? String,
            let toIndex = json["to_index"] as? String,
            let fromCity = json["from_city"] as? String,
            let toCity = json["to_city"] as? String

        else {return nil}

        self.fromIndex = fromIndex
        self.toIndex = toIndex
        self.fromCity = fromCity
        self.toCity = toCity
    }
}
