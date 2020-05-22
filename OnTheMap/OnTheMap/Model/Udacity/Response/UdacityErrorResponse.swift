//
//  UdacityErrorResponse.swift
//  OnTheMap
//
//  Created by Fazakas Loránd on 2020. 04. 17..
//  Copyright © 2020. Lorand Fazakas. All rights reserved.
//

import Foundation

struct UdacityErrorResponse: Codable {
    let status: Int
    let error: String
}

extension UdacityErrorResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
