//
//  APIEndpoints.swift
//  UIKitTestApp
//
//  Created by Александр Коробицын on 06.06.2024.
//

import Foundation
//
//struct API {
//    static let baseURL = "https://api.escuelajs.co/api/v1/"
//}
//
//enum EndPoints {
//    case products
//    case product(id: Int)
//    case categories
//    case category(id: Int)
//    
//    var path: String {
//        switch self {
//            
//        case .products:
//            return "products"
//        case .product(id: let id):
//            return "product/\(id)"
//        case .categories:
//            return "categories"
//        case .category(id: let id):
//            return "category/\(id)"
//        }
//    }
//    
//    var url: URL? {
//        return URL(string: "\(API.baseURL)\(path)")
//    }
//}












struct API {
    static let baseURL = "https://fakestoreapi.com/"
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
        case .product(id: let id):
            return "products/\(id)"
        case .categories:
            return "categories"
        case .category(id: let id):
            return "categories/\(id)"
        }
    }
    
    var url: URL? {
        return URL(string: "\(API.baseURL)\(path)")
    }
    
}





































