//
//  Protocols.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 21.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import UIKit

protocol LocationManagerDelegate: class {
    func setLocationIndex(postalCode: String, textField: UITextField?)
}

protocol MenuLauncherDelegate: class {
    func itemChoosen(menuSettings: MenuSettings, index: Int)
}

protocol FindIndexProtocol: class {
    func setIndex(index: String, to: UITextField)
}
