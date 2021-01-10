//
//  AccelerationRouter.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 9.01.2021.
//

import UIKit

class AccelerationRouter {
    
    internal var controller: AccelerationViewController!
    internal var presenter: AccelerationPresenter!
    internal var interactor: AccelerationInteractor!
    
    init() {
        interactor = AccelerationInteractor()
        presenter = AccelerationPresenter()
        controller = AccelerationViewController()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = self
        presenter.view = controller
        controller.presenter = presenter
    }
}

extension AccelerationRouter: AccelerationRouterProtocol {
 
}
