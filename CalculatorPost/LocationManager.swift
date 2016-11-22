//
//  LocationManager.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 20.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import Foundation
import MapKit

class LocationManager: NSObject, CLLocationManagerDelegate {

    weak var delegate: LocationManagerDelegate?

    var textField: UITextField?

    let activityIndicator: UIActivityIndicatorView = {
        let aiv              = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.color            = .red
        aiv.hidesWhenStopped = true
        return aiv
    }()

    let locationManager = CLLocationManager()

    func fireLocationUpdate(textField: UITextField) {
        if CLLocationManager.locationServicesEnabled() {
            self.textField                  = textField
            locationManager.delegate        = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestAlwaysAuthorization()
            self.locationManager.requestLocation()

            if let window = UIApplication.shared.keyWindow {
                activityIndicator.center = window.center
                window.addSubview(activityIndicator)
                activityIndicator.startAnimating()
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let geocoder = CLGeocoder()

            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if error == nil {
                    if let placeMark = placemarks?.first {
                        if let postalCode = placeMark.postalCode {
                            self.delegate?.setLocationIndex(postalCode: postalCode, textField: self.textField)
                        }
                    }
                }

                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()
            }
        }
    }
}
