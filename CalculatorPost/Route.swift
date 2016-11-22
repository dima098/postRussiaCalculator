//
//  File.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 19.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import Foundation

struct Route {
    let indexes: [String]
    let street: String
    let city: String
}

extension Route {
    func toAdressList() -> [Address] {
        return indexes.map{index in Address(index: index, city: city, street: street)}
    }
}

extension Route {
    init?(json: JSONDictionary) {
        guard
            let indexes = json["indexes"] as? [String],
            let streetShortName = json["shortname"] as? String,
            let streetFormalname = json["formalname"] as? String,
            let route = json["route"] as? JSONDictionary,
            let region = route["region"] as? JSONDictionary,
            let cityShortName = region["shortname"] as? String,
            let cityFormalName = region["formalname"] as? String
        else {return nil}

        self.indexes = indexes
        self.street = [streetShortName, streetFormalname].joined(separator: " ")
        self.city = [cityShortName, cityFormalName].joined(separator: " ")
    }
}
