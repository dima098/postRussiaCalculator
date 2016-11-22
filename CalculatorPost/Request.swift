//
//  Request.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 19.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import Foundation

struct Request<A> {
    let url: URL
    let parse: (Data) -> A?
}

extension Request {
    init(url: URL, params: [String:String], jsonParse: @escaping (Any) -> A? ) {
        let urlQuery = url.addQueryParams(params: params)!
        self.url = urlQuery
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            return json.flatMap(jsonParse)
        }

    }
}
