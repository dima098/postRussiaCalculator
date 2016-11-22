//
//  CalculationService.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 19.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import Foundation

protocol CalculationServiceProtocol: class {
    func calculate(
        from: Int,
        to: Int,
        mailBox: MailBox,
        completion: @escaping (ResponseCalculation?) -> (),
        error: ((Error) -> ())?
    )
}

class CalculationService: CalculationServiceProtocol {
    static let shared = CalculationService()

    func calculate(
        from: Int,
        to: Int,
        mailBox: MailBox,
        completion: @escaping (ResponseCalculation?) -> (),
        error: ((Error) -> ())?
        ) {
        let request = API.requestCalculation(from: from, to: to, mailBox: mailBox)
        ApiService.shared.load(request: request, completionHandler: completion, errorHandler: error)
    }
}
