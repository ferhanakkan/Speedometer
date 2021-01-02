//
//  SendFeedbackRouter.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 2.01.2021.
//

import UIKit

class SendFeedbackRouter {
    
    internal var controller: SendFeedbackViewController!
    internal var presenter: SendFeedbackPresenter!
    internal var interactor: SendFeedbackInteractor!
    
    init() {
        interactor = SendFeedbackInteractor()
        presenter = SendFeedbackPresenter()
        controller = SendFeedbackViewController()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = self
        presenter.view = controller
        controller.presenter = presenter
    }
}

extension SendFeedbackRouter: SendFeedbackRouterProtocol {
    func popViewController() {
        controller.navigationController?.popViewController(animated: true)
    }
}
