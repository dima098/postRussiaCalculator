//
//  MenuLauncher.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 20.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import UIKit

struct MenuSettings {
    let images: [String]
    let colors: [UIColor]
    let type: MenuType

    static let fromSettings = MenuSettings(
        images: ["current", "pin", "find"],
        colors: [.blue, .yellow, .green],
        type: .from
    )

    static let toSettings = MenuSettings(
        images: ["current", "pin", "find"],
        colors: [.blue, .yellow, .green],
        type: .to
    )

    static let moneySettings = MenuSettings(
        images: ["dollar", "ruble", "euro"],
        colors: [.red, .green, .orange],
        type: .money
    )

    static let weightSettings = MenuSettings(
        images: ["g", "kg"],
        colors: [.blue, .cyan],
        type: .weight
    )
}

enum MenuType {
    case money
    case from
    case to
    case weight
}

class MenuLauncher: NSObject {

    weak var delegate: MenuLauncherDelegate?

    let cellId = "cellId"

    var settings: MenuSettings?
    let cellHeight: CGFloat = 75
    let cellSpace: CGFloat = 10

    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override init() {
        super.init()
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
    }

    func showSettings(settings: MenuSettings) {
        self.settings = settings

        collectionView.reloadData()

        let count = self.settings!.images.count
        let menuWidth = CGFloat(count) * self.cellHeight + CGFloat(count - 1) * cellSpace

        if let window = UIApplication.shared.keyWindow {

            blackView.addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self,
                    action: #selector(handleDismiss)
                )
            )

            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            window.addSubview(collectionView)

            let height: CGFloat = CGFloat(cellHeight) * 3
            let y = window.frame.height - height

            collectionView.frame = CGRect(
                x: window.center.x - menuWidth.half,
                y: window.frame.height,
                width: menuWidth,
                height: cellHeight
            )

            blackView.frame = window.frame
            blackView.alpha = 0

            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: .curveEaseOut, animations: {
                    self.blackView.alpha = 1
                    self.collectionView.center.y = y

                }, completion: nil
            )
        }
    }

    func handleDismiss() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: {
                self.blackView.alpha = 0

                if let window = UIApplication.shared.keyWindow {
                    self.collectionView.center.y =
                        window.frame.height + self.cellHeight
                }
            }
        ) { result in self.blackView.removeFromSuperview()
        }
    }
}

extension MenuLauncher: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleDismiss()
        if let settings = settings {
            delegate?.itemChoosen(menuSettings: settings, index: indexPath.item)
        }
    }
}

extension MenuLauncher: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings?.images.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        if let settings = settings {
            cell.backgroundColor = settings.colors[indexPath.item].withAlphaComponent(0.75)
            cell.menuItem.image = UIImage(named: settings.images[indexPath.item])?.withRenderingMode(.alwaysTemplate)
            cell.layer.cornerRadius = cellHeight.half
        }
        return cell
    }
}

extension MenuLauncher: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellHeight, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpace
    }
}
