//
//  NetworkManager.swift
//  UIKitTestApp
//
//  Created by Александр Коробицын on 06.06.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let schared = NetworkManager()
    
    func fetchData <Model: Decodable> 
    (type: Model.Type, url: EndPoints, completion: @escaping(Result <Model, NetworkError>) -> Void) {
        
        guard let url = url.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, respounse, error in
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let type = try JSONDecoder().decode(Model.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}
