//
//  StudentLocationPost.swift
//  OnTheMap
//
//  Created by Fazakas Loránd on 2020. 04. 18..
//  Copyright © 2020. Lorand Fazakas. All rights reserved.
//

import Foundation

struct StudentLocationPost: Codable {
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
}
