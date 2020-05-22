//
//  UdacitySessionResponse.swift
//  OnTheMap
//
//  Created by Fazakas Loránd on 2020. 04. 17..
//  Copyright © 2020. Lorand Fazakas. All rights reserved.
//

import Foundation

struct UdacitySessionResponse: Codable {
    let account: Account
    let session: Session
    
    struct Account: Codable {
        let registered: Bool
        let key: String
    }

    struct Session: Codable {
        let id: String
        let expiration: String
    }
}


