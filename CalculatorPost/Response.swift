//
//  Response.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 19.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import Foundation

class Response<A> {
    var msg: Message
    var data: A?

    init?() {
        self.msg = Message(type: "ok", text: "ok")
        self.data = nil
    }
}
