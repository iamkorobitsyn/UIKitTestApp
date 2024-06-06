//
//  APIEndpoints.swift
//  UIKitTestApp
//
//  Created by Александр Коробицын on 06.06.2024.
//

import Foundation

struct API {
    static let baseURL = "https://api.escuelajs.co/api/v1/"
}

enum EndPoints {
    case products
    case product(id: Int)
    case categories
    case category(id: Int)
    
    var path: String {
        switch self {
            
        case .products:
            return "products"
        case .product(let id):
            return "products/\(id)"
        case .categories:
            return "categories"
        case .category(let id):
            return "categories/\(id)"
        }
    }
    
    var urlString: String {
        return "\(API.baseURL)\(path)"
    }
    
    var url: URL? {
        return URL(string: urlString)
    }
}
