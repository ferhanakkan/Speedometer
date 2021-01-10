//
//  GForceRouter.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 10.01.2021.
//

import UIKit

class GForceRouter {
    
    internal var controller: GForceViewController!
    internal var presenter: GForcePresenter!
    internal var interactor: GForceInteractor!
    
    init() {
        interactor = GForceInteractor()
        presenter = GForcePresenter()
        controller = GForceViewController()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = self
        presenter.view = controller
        controller.presenter = presenter
    }
}

extension GForceRouter: GForceRouterProtocol {
 
}
