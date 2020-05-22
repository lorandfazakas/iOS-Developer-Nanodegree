//
//  ParseErrorResponse.swift
//  OnTheMap
//
//  Created by Fazakas Loránd on 2020. 04. 18..
//  Copyright © 2020. Lorand Fazakas. All rights reserved.
//

import Foundation

struct ParseErrorResponse: Codable {
    let code: Int
    let error: String
}

extension ParseErrorResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
