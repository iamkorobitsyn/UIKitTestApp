//
//  MainPresenterProtocol.swift
//  UIKitTestApp
//
//  Created by Александр Коробицын on 14.06.2024.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didFetchData(products: [Product])
}

class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainVC!
    var interactor: MainInteractorProtocol!
    
    func viewDidLoad() {
        interactor.fetchData()
    }
    
    func didFetchData(products: [Product]) {
        view.updateCollectionView(products: products)
    }
}
