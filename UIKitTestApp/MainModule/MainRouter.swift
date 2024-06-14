//
//  MainRouter.swift
//  UIKitTestApp
//
//  Created by Александр Коробицын on 14.06.2024.
//

import Foundation
import UIKit


protocol MainRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

class MainRouter: MainRouterProtocol {
    static func createModule() -> UIViewController {
        let view = MainVC()
        let presenter = MainPresenter()
        let interactor = MainInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}


