//
//  ApiService.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 19.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import Foundation

class ApiService {

    static let shared = ApiService()

    func load<A>(
        request: Request<A>, completionHandler: @escaping (A?) -> (), errorHandler: ( (Error) -> () )?
    ) {
        DispatchQueue.global(qos: .userInitiated).async {
            URLSession.shared.dataTask(with: request.url) { data, response, error in
                print("================================================")
                if error != nil {
                    print("+++++++++++++++++++++++++++++++++++")
                    if let handler = errorHandler {
                        handler(error!)
                    }
                    return
                }
                let result = data.flatMap(request.parse)
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            }.resume()
        }
    }
}
