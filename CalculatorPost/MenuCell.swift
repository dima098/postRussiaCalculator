//
//  MenuCell.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 20.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {

    let menuItem: UIImageView = {
        let view = UIImageView()
        view.tintColor = UIColor.black.withAlphaComponent(0.65)
        view.layer.cornerRadius = 50
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        addSubview(menuItem)

        addConstraintWithFormat(format: "H:|-24-[v0]-24-|", views: menuItem)
        addConstraintWithFormat(format: "V:|-24-[v0]-24-|", views: menuItem)
    }
}
