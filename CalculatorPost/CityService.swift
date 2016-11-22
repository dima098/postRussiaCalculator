//
//  CityService.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 19.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import Foundation

protocol CityServiceProtocol: class {
    func findAddressByCityAndStreet(
        cityNameStart: String,
        streetNameStart: String,
        completion: @escaping (ResponseRoute?) -> (),
        error: ((Error) -> ())?
    )
}

class CityService: CityServiceProtocol {

    static let shared = CityService()

    func findAddressByCityAndStreet(
        cityNameStart: String,
        streetNameStart: String,
        completion: @escaping (ResponseRoute?) -> (),
        error: ((Error) -> ())?
    ) {
        let request = API.requestAddress(cityNameStart: cityNameStart, streetNameStart: streetNameStart)
        ApiService.shared.load(request: request, completionHandler: completion, errorHandler: error)
    }
}
