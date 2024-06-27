//
//  Request.swift
//  UIKitTestApp
//
//  Created by Александр Коробицын on 24.06.2024.
//

import Foundation

final class BaseRequest {
    
    //MARK: - HTTPMethod
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    //MARK: - Parameters
    
    struct Parameters {
        
        enum Context {
            case url, body, plain
        }
        
        let context: Context
        private let dictionary: [String : Any]
        
        init(context: Context, dictionary: [String : Any]) {
            self.context = context
            self.dictionary = dictionary
        }
        
        func asData() throws -> Data {
            if JSONSerialization.isValidJSONObject(dictionary) { throw NetworkError.decodingError }
            return try JSONSerialization.data(withJSONObject: dictionary, options: [])
        }
        
        func asQueryItems() -> [URLQueryItem] {
            dictionary.map { URLQueryItem(name: $0, value: "\($1)") }
        }
    }
    
    //MARK: - Properties
    
    let method: HTTPMethod
    let configuration: URLConfiguration
    let headers: [String:String]
    let parameters: [Parameters]
    
    
    //MARK: - Init
    
    init(method: HTTPMethod,
         URLConfiguration: URLConfiguration,
         headers: [String : String] = [:],
         parameters: [Parameters] = []) {
        
        self.method = method
        self.configuration = URLConfiguration
        self.headers = headers
        self.parameters = parameters
    }
    
    //MARK: - asURLRequest
    
    func asURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = configuration.scheme
        components.host = configuration.host
        components.path = configuration.path
        
        guard let url = components.url else {
                throw NetworkError.invalidURL
            }

            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
        
        request.httpMethod = method.rawValue
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key)
            
            if !parameters.isEmpty {
                for parameter in parameters {
                    switch parameter.context {
                    case .url:
                        request.httpBody = try? parameter.asData()
                    case .body:
                        components.queryItems = parameter.asQueryItems()
                        request.url = components.url
                    case .plain:
                        continue
                    }
                }
            }
        }
        return request
    }
}


