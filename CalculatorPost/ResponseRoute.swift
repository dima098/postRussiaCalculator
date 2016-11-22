//
//  ResponseAddress.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 19.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import Foundation

class ResponseRoute: Response<[Route]> {

    let success = "ok"

    init?(json: JSONDictionary) {
        super.init()
        guard
            let textMessage = json["access"] as? String,
            let typeMessage = json["access_status"] as? String
        else { return nil }

        self.msg = Message(type: typeMessage, text: textMessage)

        if self.msg.type == success {

            if let content = json["content"] as? [JSONDictionary] {
                self.data = content.flatMap(Route.init)
            } else {
                self.msg = Message(type: "error", text: "Ошибка обработки данных")
            }
        }
    }
}
