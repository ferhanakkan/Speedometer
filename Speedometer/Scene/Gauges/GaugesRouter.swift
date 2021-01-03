//
//  GaugesRouter.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 3.01.2021.
//

import UIKit

class GaugesRouter {
    
    internal var controller: GaugesViewController!
    internal var presenter: GaugesPresenter!
    internal var interactor: GaugesInteractor!
    
    init() {
        interactor = GaugesInteractor()
        presenter = GaugesPresenter()
        controller = GaugesViewController()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = self
        presenter.view = controller
        controller.presenter = presenter
    }
}

extension GaugesRouter: GaugesRouterProtocol {
 
}
