//
//  SettingsRouter.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 1.12.2020.
//

import Foundation

class SettingsRouter {
    
    internal var controller: SettingsViewController!
    internal var presenter: SettingsPresenter!
    internal var interactor: SettingsInteractor!
    
    init() {
        interactor = SettingsInteractor()
        presenter = SettingsPresenter()
        controller = SettingsViewController()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = self
        presenter.view = controller
        controller.presenter = presenter
    }
}

extension SettingsRouter: SettingsRouterProtocol {}
