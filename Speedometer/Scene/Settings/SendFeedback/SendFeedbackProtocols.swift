//
//  SendFeedbackProtocols.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 2.01.2021.
//

import UIKit

//MARK: Router
protocol SendFeedbackRouterProtocol: class {
    func popViewController()
}

//MARK: Presenter

protocol SendFeedbackPresenterProtocol: class {
    var interactor: SendFeedbackInteractorInputProtocol! { get set }
    func textViewText(text: String)
    func buttonSendPressed()
}

//MARK: Interactor

// Interactor -> Presenter
protocol SendFeedbackInteractorOutputProtocol: class {
    func sendFeedbackCompleted(withError: Error?)
}

// Presenter -> Interactor

protocol SendFeedbackInteractorInputProtocol: class {
    var presenter: SendFeedbackInteractorOutputProtocol! { get set }
    func sendFeedback(text: String)
}

//MARK: View

protocol SendFeedbackViewProtocol: class {
    var presenter: SendFeedbackPresenterProtocol! { get set }
    func sendButtonIsActive(isActive: Bool)
    func sendFeedbackCompleted()
}
