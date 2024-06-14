//
//  MainInteractor.swift
//  UIKitTestApp
//
//  Created by Александр Коробицын on 14.06.2024.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    func fetchData(endPoint: EndPoints)
}

class MainInteractor: MainInteractorProtocol {
    
    weak var presenter: MainPresenter!
    
    func fetchData(endPoint: EndPoints) {
        NetworkManager.shared.fetchData(type: [Product].self, endPoint: endPoint) { result in
            
            switch result {
            case .success(let data):
                self.presenter.didFetchData(products: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
