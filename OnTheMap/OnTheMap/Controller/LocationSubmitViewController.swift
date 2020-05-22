//
//  LocationSubmitViewController.swift
//  OnTheMap
//
//  Created by Fazakas Loránd on 2020. 04. 18..
//  Copyright © 2020. Lorand Fazakas. All rights reserved.
//

import UIKit
import MapKit

class LocationSubmitViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var studentLocation: StudentLocation?
    var annotations = [MKPointAnnotation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        pinLocation()
        
    }
    
    @IBAction func finalizeLocationTapped(_ sender: Any) {
        
//      This is a dummy call, since the endpoint for this works intermitently
        let name = ParseClient.getStudentName()
        studentLocation?.firstName = name.0
        studentLocation?.lastName = name.1
        ParseClient.postStudentLocation(studentLocation: studentLocation!) { (success, error) in
            if success {
                self.dismiss(animated: true, completion: {
                    self.presentingViewController?.dismiss(animated: true, completion: nil)
                })
            } else {
                self.showFailure(title: "Pinning the location failed", message: "Please try again later")
            }
        }
    }
    
    func pinLocation() {
        guard let studentLocation = studentLocation else { return }
        let lat = CLLocationDegrees(studentLocation.latitude!)
        let long = CLLocationDegrees(studentLocation.longitude!)
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = studentLocation.mapString
        annotation.subtitle = studentLocation.mediaURL
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
        mapView.regionThatFits(region)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
            }
        }
    }

}
