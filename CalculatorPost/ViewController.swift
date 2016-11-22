//
//  ViewController.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 19.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fromIndexTextField: UITextField!
    @IBOutlet weak var toIndexTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField!
    
    @IBOutlet weak var fromIndexButton: UIButton!
    @IBOutlet weak var toIndexButtton: UIButton!
    @IBOutlet weak var costButton: UIButton!
    @IBOutlet weak var weightButton: UIButton!

    var indexFrom: Int? {
        return Int(fromIndexTextField.text ?? "")
    }

    var indexTo: Int? {
        return Int(toIndexTextField.text ?? "")
    }

    var weight: Double? {
        get {
            return Double(weightTextField.text ?? "")
        }
        set {
            weightTextField.text = "\(newValue!)"
        }
    }

    var price: Int? {
        return Int(costTextField.text ?? "")
    }

    var currentMoneyType: Int?
    var currentWeightType: Weight = .kilogramm {
        didSet {
            weightButton.titleLabel?.text = currentWeightType.rawValue
        }
    }

    @IBOutlet weak var calculateButton: ShakedButton!
    lazy var menuLauncher: MenuLauncher = {
        let menuLauncher = MenuLauncher()
        menuLauncher.delegate = self
        return menuLauncher
    }()

    lazy var locationManager: LocationManager = {
        let manager = LocationManager()
        manager.delegate = self
        return manager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        roundViews()
    }

    private func roundViews() {
        [fromIndexButton, toIndexButtton, weightButton, costButton]
            .forEach { $0!.layer.cornerRadius = $0!.bounds.width.half }

        calculateButton.layer.cornerRadius = 10
        calculateButton.layer.borderWidth = 0.4
        calculateButton.layer.borderColor = calculateButton.titleLabel?.textColor.cgColor
    }

    @IBAction func calculateAction(_ sender: ShakedButton) {
        if [fromIndexTextField, toIndexTextField, weightTextField, costTextField].filter({$0?.text?.isEmpty ?? true}).isEmpty {

            if  let price = price,
                let weight = weight,
                let indexFrom = indexFrom,
                let indexTo = indexTo
            {
                let mailBox = MailBox(weight: weight, price: price)

                CalculationService.shared.calculate(
                    from:    indexFrom,
                    to:      indexTo,
                    mailBox: mailBox,
                    completion: { response in
                        print("-------------------------------------------")
                        print(response?.msg)
                        print(response?.data)
                    },
                    error: { error in
                        
                    }
                )
            }
        } else {
            sender.shake()
        }
    }


    @IBAction func fromSettingAction(_ sender: UIButton) {
        menuLauncher.showSettings(settings: MenuSettings.fromSettings)
    }
    @IBAction func toSettingsAction(_ sender: UIButton) {
        menuLauncher.showSettings(settings: MenuSettings.toSettings)
    }

    @IBAction func weightSettingsAction(_ sender: AnyObject) {
        menuLauncher.showSettings(settings: MenuSettings.weightSettings)
    }
    @IBAction func moneySettingsAction(_ sender: UIButton) {
        menuLauncher.showSettings(settings: MenuSettings.moneySettings)
    }
}

extension ViewController: LocationManagerDelegate {
    func setLocationIndex(postalCode: String, textField: UITextField?) {
        if let textField = textField {
            textField.text = postalCode
        }
    }
}

extension ViewController: MenuLauncherDelegate {
    func itemChoosen(menuSettings: MenuSettings, index: Int) {
        switch menuSettings.type {
        case .from:
            if index == 0 {
                locationManager.fireLocationUpdate(textField: self.fromIndexTextField)
            } else if index == 1 {
                if let controller = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
                    controller.textField = fromIndexTextField
                    controller.delegate = self
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            } else if index == 2 {
                if let controller = storyboard?.instantiateViewController(withIdentifier: "FindViewController") as? FindViewController {
                    controller.textField = fromIndexTextField
                    controller.delegate = self
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
        case .to:
            if index == 0 {
                locationManager.fireLocationUpdate(textField: self.toIndexTextField)
            } else if index == 1 {
                if let controller = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
                    controller.textField = toIndexTextField
                    controller.delegate = self
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            } else if index == 2 {
                if let controller = storyboard?.instantiateViewController(withIdentifier: "FindViewController") as? FindViewController {
                    controller.textField = toIndexTextField
                    controller.delegate = self
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
        case .money: break
        case .weight:
            if let weight = weight {
                if index == 0 {
                    self.weight = currentWeightType.convertToGram(value: weight)
                    currentWeightType = .gramm
                } else if index == 1 {
                    self.weight = currentWeightType.convertToKilogram(value: weight)
                    currentWeightType = .kilogramm
                }
            }
        }
    }
}

extension ViewController: FindIndexProtocol {
    func setIndex(index: String, to: UITextField) {
        to.text = index
    }
}
