//
//  ChangeLanguagesRouter.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 2.01.2021.
//

import UIKit

class ChangeLanguagesRouter {
    
    internal var controller: ChangeLanguagesViewController!
    internal var presenter: ChangeLanguagesPresenter!
    internal var interactor: ChangeLanguagesInteractor!
    
    init() {
        interactor = ChangeLanguagesInteractor()
        presenter = ChangeLanguagesPresenter()
        controller = ChangeLanguagesViewController()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = self
        presenter.view = controller
        controller.presenter = presenter
    }
}

extension ChangeLanguagesRouter: ChangeLanguagesRouterProtocol {
    func refreshRoot() {
        let _ = RootSelector()
    }
}
