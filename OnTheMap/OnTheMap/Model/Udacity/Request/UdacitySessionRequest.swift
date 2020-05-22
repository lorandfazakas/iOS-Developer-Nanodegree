//
//  UdacitySessionRequest.swift
//  OnTheMap
//
//  Created by Fazakas Loránd on 2020. 04. 17..
//  Copyright © 2020. Lorand Fazakas. All rights reserved.
//

import Foundation

struct UdacitySessionRequest : Codable {
    let credentials : Credentials
    
    enum CodingKeys: String, CodingKey {
        case credentials = "udacity"
    }
    
    struct Credentials : Codable {
        let username: String
        let password: String
    }
}
