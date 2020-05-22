//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Fazakas Loránd on 2020. 04. 17..
//  Copyright © 2020. Lorand Fazakas. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRecentStudentLocations()
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        getRecentStudentLocations()
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
            if let toOpen = view.annotation?.subtitle! {
                if let url = URL(string: toOpen) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        showFailure(title: "Opening the URL failed", message: "URL is invalid")
                    }
                }
            }
        }
    }
    
    func getRecentStudentLocations() {
        ParseClient.getStudentLocations(limit: 100) { (studentLocations, error) in
            if error != nil {
                self.showFailure(title: "Refresh Failed", message: "Please try again.")
            } else {
                self.appDelegate.studentLocations = studentLocations
                for location in studentLocations {
                    let lat = CLLocationDegrees(location.latitude!)
                    let long = CLLocationDegrees(location.longitude!)
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotation.title = "\(location.firstName ?? "") \(location.lastName ?? "")"
                    annotation.subtitle = location.mediaURL
                    self.annotations.append(annotation)
                }
                self.mapView.addAnnotations(self.annotations)
            }
        }
    }
}
