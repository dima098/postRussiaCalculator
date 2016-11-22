//
//  Units.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 21.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import Foundation

enum Weight: String {
    case gramm = "гр", kilogramm = "кг"

    func convertToGram(value: Double) -> Double {
        switch self {
            case .gramm:
                return value
            case .kilogramm:
                return value * 1000
        }
    }

    func convertToKilogram(value: Double) -> Double {
        switch self {
            case .gramm:
                return value / 1000
            case .kilogramm:
                return value
        }
    }
}
