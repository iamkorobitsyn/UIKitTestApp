//
//  Request.swift
//  UIKitTestApp
//
//  Created by Александр Коробицын on 24.06.2024.
//

import Foundation

final class Request {
    
    let host: String
    let path: String
    let method: HTTPMethod
    let headers: [String:String]
    let Parameters: String
    
    init(host: String, 
         path: String,
         method: HTTPMethod,
         headers: [String : String] = [:],
         Parameters: String = "") {
        
        self.host = host
        self.path = path
        self.method = method
        self.headers = headers
        self.Parameters = Parameters
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

