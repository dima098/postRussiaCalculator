//
//  FindViewController.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 21.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import UIKit

class FindViewController: UIViewController {

    weak var delegate: FindIndexProtocol?
    var textField: UITextField?

    let activityIndicator: UIActivityIndicatorView = {
        let aiv              = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.color            = .red
        aiv.hidesWhenStopped = true
        return aiv
    }()

    var addressArray = [Address]()

    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    var city: String {
        return cityTextField.text ?? ""
    }

    var street: String {
        return streetTextField.text ?? ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func findAction(_ sender: UIButton) {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        CityService.shared.findAddressByCityAndStreet(
            cityNameStart: city,
            streetNameStart: street,
            completion: { response in
                print("=====================================")
                print(response?.msg)
                if let data = response?.data {
                    self.addressArray = data.flatMap{$0.toAdressList()}
                    self.tableView.reloadData()
                }

                self.activityIndicator.stopAnimating()
            }
        ) { error in
            print("=====================================")
            print(error.localizedDescription)
            self.activityIndicator.stopAnimating()
        }
    }
}

extension FindViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("======================----------------")
        if let textField = textField {
            print("..........................................")
            delegate?.setIndex(index: addressArray[indexPath.row].index, to: textField)
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension FindViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCellIdentifier", for: indexPath) as! AddressCell
        cell.cityLabel.text   = addressArray[indexPath.row].city
        cell.streetLabel.text = addressArray[indexPath.row].street
        cell.indexLabel.text  = addressArray[indexPath.row].index
        return cell
    }
}
