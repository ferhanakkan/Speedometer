//
//  SettingsRouter.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 1.12.2020.
//

import UIKit

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

extension SettingsRouter: SettingsRouterProtocol {
    func showChangeLanguage() {
        let vc = ChangeLanguagesRouter().controller
        vc?.hidesBottomBarWhenPushed = true
        controller.show(vc!, sender: nil)
    }
    
    func presentShareApp(activityVC: UIActivityViewController) {
        controller.present(activityVC, animated: true, completion: nil)
    }
    
    func showFeedbackController() {
        let vc = SendFeedbackRouter().controller
        vc?.hidesBottomBarWhenPushed = true
        controller.show(vc!, sender: nil)
    }
}
