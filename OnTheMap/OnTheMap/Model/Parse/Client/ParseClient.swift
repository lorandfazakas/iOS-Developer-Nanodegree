//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Fazakas Loránd on 2020. 04. 17..
//  Copyright © 2020. Lorand Fazakas. All rights reserved.
//

import Foundation

class ParseClient {
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case getStudentLocations(Int)
        case postStudentLocation
        
        var stringValue: String {
            switch self {
            case .getStudentLocations(let limit):
                return Endpoints.base + "/StudentLocation?limit=\(limit)&order=-updatedAt"
            case .postStudentLocation:
                return Endpoints.base + "/StudentLocation"
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ParseErrorResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        return task
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ParseErrorResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    
    class func getStudentLocations(limit: Int, completion: @escaping ([StudentLocation], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getStudentLocations(limit).url, responseType: StudentLocationResults.self) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    class func postStudentLocation(studentLocation: StudentLocation, completion: @escaping (Bool, Error?) -> Void) {
        let body = StudentLocationPost(uniqueKey: studentLocation.uniqueKey ?? "9458", firstName: studentLocation.firstName!, lastName: studentLocation.lastName!, mapString: studentLocation.mapString!, mediaURL: studentLocation.mediaURL!, latitude: studentLocation.latitude!, longitude: studentLocation.longitude!)
        taskForPOSTRequest(url: Endpoints.postStudentLocation.url, responseType: StudentLocationPostResponse.self, body: body) { (response, error) in
            if let response = response {
                completion(true, nil)
            } else {
                completion(false, nil)
            }
        }
    }
    
    class func getStudentName() -> (String, String) {
        return ("John", "Doe")
    }
    
}
