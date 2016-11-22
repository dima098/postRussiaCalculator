//
//  ResponseCalculation.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 19.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import Foundation

class ResponseCalculation: Response<[Calculation]> {

    let success = "done"

    init?(json: JSONDictionary) {
        super.init()
        guard
            let messageObject = json["msg"] as? JSONDictionary,
            let textMessage = messageObject["text"] as? String,
            let typeMessage = messageObject["type"] as? String
        else { return nil }

        self.msg = Message(type: typeMessage, text: textMessage)

        if self.msg.type == success {
            if let calculationDictionary = json["calc"] as? [JSONDictionary]{

                self.data = calculationDictionary.flatMap(Calculation.init)

            } else {
                self.msg = Message(type: "error", text: "Ошибка обработки данных")
            }

        }
    }
}
