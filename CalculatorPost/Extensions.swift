//
//  Helpers.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 19.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import UIKit

extension URL {
    func addQueryParams(params: [String:String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)
        components?.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components?.url
    }
}

extension Comparable {
    var str: String {
        return "\(self)"
    }
}

extension CGFloat {
    var half: CGFloat {
        return self / 2
    }
}

extension String {
    func MD5() -> String {
        guard let messageData = self.data(using:String.Encoding.utf8) else { return "" }
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))

        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }

        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
}

extension UIView {
    func addConstraintWithFormat(format: String, views: UIView...) {
        var viewsDictionary: [String:UIView] = [:]

        for (index,view) in views.enumerated() {
            viewsDictionary["v\(index)"] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: format,
                options: NSLayoutFormatOptions(),
                metrics: nil,
                views: viewsDictionary
            )
        )
    }
}
