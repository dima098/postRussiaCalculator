//
//  API.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 19.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

//http://russianpostcalc.ru/api-devel.php#calc
//http://post-api.ru/w/IBC_(метод)#.D0.92.D1.8B.D0.B7.D0.BE.D0.B2

import Foundation

typealias JSONDictionary = [String:Any]

struct API {
    static let urlForAddress = URL(string: "http://post-api.ru/api/v2/ibc.php")!
    static let urlForCalculation = URL(string: "http://russianpostcalc.ru/api_v1.php")!
    static let password = "89289883468test"

    private static let apiKeyCalculation = "a9cb4a45d620d4ebf8979bb71c871cf4"
    private static let apiKeyAddress = "givvofh096fh0unt"

    static func requestAddress(cityNameStart: String, streetNameStart: String) -> Request<ResponseRoute> {
        return Request<ResponseRoute>(
            url: urlForAddress,
            params: [
                "apikey":   apiKeyAddress,
                "c":        cityNameStart,
                "s":        streetNameStart
            ]
        ) { json in
            return (json as? JSONDictionary).flatMap(ResponseRoute.init)
        }
    }

    static func requestCalculation(from: Int, to: Int, mailBox: MailBox) -> Request<ResponseCalculation> {
        let hash = [apiKeyCalculation, "calc", from.str, to.str, mailBox.weight.str, mailBox.price.str, password].joined(separator: "|").MD5()
        return Request<ResponseCalculation>(
            url: urlForCalculation,
            params: [
                "apikey":           apiKeyCalculation,
                "method":           "calc",
                "from_index":       from.str,
                "to_index":         to.str,
                "weight":           mailBox.weight.str,
                "ob_cennost_rub":   mailBox.price.str            ]
        ) {
            json in (json as? JSONDictionary).flatMap(ResponseCalculation.init)
        }
    }
}
