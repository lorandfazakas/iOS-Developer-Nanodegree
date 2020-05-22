//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Fazakas Loránd on 2020. 04. 18..
//  Copyright © 2020. Lorand Fazakas. All rights reserved.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController {
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func findLocationTapped(_ sender: Any) {
        guard let location = locationTextField.text, let url = urlTextField.text, location != "", url != "" else {
            showFailure(title: "Adding the location failed", message: "Please provide location and URL as well")
            return
        }
        setGeocodingAnimator(true)
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            guard let firstLocation = placemarks?.first?.location else {
                self.showFailure(title: "Location not found", message: "We couldn't find the specified location. Please try again.")
                self.setGeocodingAnimator(false)
                return
            }
            var studentLocation = StudentLocation(mapString: location, mediaURL: url)
            studentLocation.latitude = firstLocation.coordinate.latitude
            studentLocation.longitude = firstLocation.coordinate.longitude
                
            self.setGeocodingAnimator(false)
            let locationSubmitVc = self.storyboard?.instantiateViewController(identifier: "LocationSubmitViewController") as! LocationSubmitViewController
            locationSubmitVc.studentLocation = studentLocation
            self.navigationController?.pushViewController(locationSubmitVc, animated: true)
        }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setGeocodingAnimator(_ geocoding: Bool) {
        if geocoding {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        locationTextField.isEnabled = !geocoding
        urlTextField.isEnabled = !geocoding
    }
}
