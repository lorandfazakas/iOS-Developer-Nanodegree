//
//  LocationsTableViewController.swift
//  OnTheMap
//
//  Created by Fazakas Loránd on 2020. 04. 18..
//  Copyright © 2020. Lorand Fazakas. All rights reserved.
//

import UIKit

class LocationsTableViewController: UITableViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRecentStudentLocations()
        tableView.reloadData()
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        getRecentStudentLocations()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.studentLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell") as! LocationTableViewCell
        let studentLocation = appDelegate.studentLocations[indexPath.row]
        cell.pinImageView!.image = UIImage(named: "icon_pin")
        cell.nameLabel!.text = "\(studentLocation.firstName ?? "") \(studentLocation.lastName ?? "")"
        cell.urlLabel.text = studentLocation.mediaURL
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentLocation = appDelegate.studentLocations[indexPath.row]
        if let url = URL(string: studentLocation.mediaURL!) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                showFailure(title: "Opening the URL failed", message: "URL is invalid")
            }
        }
    }
    
    func getRecentStudentLocations() {
        ParseClient.getStudentLocations(limit: 100) { (studentLocations, error) in
            if error != nil {
                self.showFailure(title: "Refresh failed", message: "Please try again.")
            } else {
                self.appDelegate.studentLocations = studentLocations
                self.tableView.reloadData()
            }
        }
    }

}
