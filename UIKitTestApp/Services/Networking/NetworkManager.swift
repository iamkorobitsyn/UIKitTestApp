//
//  NetworkManager.swift
//  UIKitTestApp
//
//  Created by Александр Коробицын on 06.06.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL, noData, decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchDataTest<T: Decodable>(request: Request, responseType: T.Type) async throws -> T {
        
        let request = try request.asURLRequest()

        let (data, respounce) = try await URLSession.shared.data(for: request)
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.noData
        }
    }
    

    
    // Почитать про параметры запросов(Headers, Body, Query, HttpMhetods)
    
    //MARK: - FetchData
    
//    func fetchData <Model: Decodable>
//    (type: Model.Type, endPoint: EndPoints, completion: @escaping(Result <Model, NetworkError>) -> Void) {
//        
//        guard let url = endPoint.url else {
//            completion(.failure(.invalidURL))
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, respounse, error in
//            
//            guard let data = data else {
//                completion(.failure(.noData))
//                return
//            }
//            
//            do {
//                let type = try JSONDecoder().decode(Model.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(type))
//                }
//            } catch {
//                completion(.failure(.decodingError))
//            }
//            
//        }.resume()
//    }
    
    //MARK: - FetchImage
    
    func fetchImage(url: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        //MARK: CacheSearch
        if let cacheData = StorageManager.shared.getCahedImage(url: url) {
            completion(.success(cacheData))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            
            guard let data = data, let responce = responce else {
                completion(.failure(.noData))
                return
            }
            
            //MARK: - GetCache
            StorageManager.shared.setCashedImage(data: data, responce: responce)
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
            
        }.resume()
    }
}
