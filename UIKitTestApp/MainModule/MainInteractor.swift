//
//  MainInteractor.swift
//  UIKitTestApp
//
//  Created by Александр Коробицын on 14.06.2024.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    func fetchData()
}

class MainInteractor: MainInteractorProtocol {
    
    weak var presenter: MainPresenter!
    
    func fetchData() {
        
        Task {
            do {
                let configuration = URLConfigurations.products.configuration
                
                let request = BaseRequest(method: .get, URLConfiguration: configuration)
                let data = try await NetworkManager.shared.fetchData(request: request, responseType: [Product].self)
                await MainActor.run {
                    self.presenter.didFetchData(products: data)
                }
            } catch {
                print("Task Error")
            }
        }
    }
    
}
