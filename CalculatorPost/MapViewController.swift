//
//  MapViewController.swift
//  CalculatorPost
//
//  Created by Дмитрий Селютин on 20.11.16.
//  Copyright © 2016 Дмитрий Селютин. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    weak var delegate: FindIndexProtocol?

    let pinIdentifier = "pinIdentifier"

    var textField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleTap(_:))
        )

        mapView.delegate = self

        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
    }

    func handleTap(_ recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .began {
            let point = recognizer.location(in: mapView)
            addAnnotation(to: mapView, withPoint: point)
        }
    }

    func addAnnotation(to mapView: MKMapView, withPoint point: CGPoint) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        annotation.title = "Test"
        annotation.subtitle = "SubTest"
        mapView.addAnnotation(annotation)
    }
}

extension MapViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let pin = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdentifier) as? MKPinAnnotationView {
            pin.annotation = annotation
            return pin
        } else {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinIdentifier)
            pinView.isDraggable = true
            pinView.animatesDrop = true
            pinView.canShowCallout = true

            let button = UIButton(type: .contactAdd)
            pinView.rightCalloutAccessoryView = button
            
            button.addTarget(self, action: #selector(rightCalloutAction(_:)), for: .allEvents)

            return pinView
        }
    }

    func rightCalloutAction(_ sender: UIButton) {
        if let textField = textField {
            delegate?.setIndex(index: "123456", to: textField)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
