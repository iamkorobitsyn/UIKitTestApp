//
//  StorageManager.swift
//  UIKitTestApp
//
//  Created by Александр Коробицын on 13.06.2024.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    //MARK: - Image cache
    
    func setCashedImage(data: Data, responce: URLResponse) {
        guard let url = responce.url else {return}
        
        let cachedResponce = CachedURLResponse(response: responce, data: data)
        let request = URLRequest(url: url)
        
        URLCache.shared.storeCachedResponse(cachedResponce, for: request)
    }
    
    func getCahedImage(url: URL) -> Data? {
        
        let request = URLRequest(url: url)
        if let cachedResponce = URLCache.shared.cachedResponse(for: request) {
            return cachedResponce.data
        }
        return nil
    }
}
