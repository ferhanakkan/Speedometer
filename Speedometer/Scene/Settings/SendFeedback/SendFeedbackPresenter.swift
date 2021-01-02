//
//  SendFeedbackPresenter.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 2.01.2021.
//

import Foundation
import StoreKit
import Firebase

class SendFeedbackPresenter {
    var view: SendFeedbackViewProtocol!
    var interactor: SendFeedbackInteractorInputProtocol!
    var router: SendFeedbackRouterProtocol!
    
    private var textViewText: String = "" {
        didSet {
            if textViewText == "sendFeedbackTextViewPlaceHolder".localized() {
                view.sendButtonIsActive(isActive: false)
            } else {
                view.sendButtonIsActive(isActive: true)
            }
        }
    }
}

extension SendFeedbackPresenter: SendFeedbackPresenterProtocol {
    
    func buttonSendPressed() {
        interactor.sendFeedback(text: textViewText)
    }
    
    func textViewText(text: String) {
        textViewText = text
    }
}

extension SendFeedbackPresenter: SendFeedbackInteractorOutputProtocol {
    
    func sendFeedbackCompleted(withError: Error?) {
        if let error = withError {
            let action = UIAlertAction(title: "sendFeedbackAlertButtonTitle".localized(), style: .default) { _ in
            }
            AlertService.messagePresent(title: "sendFeedbackAlertTitle".localized(), message: error.localizedDescription, moreButtonAction: nil, firstAlertAction: action)
        } else {
            let action = UIAlertAction(title: "sendFeedbackAlertButtonTitle".localized(), style: .default) { _ in
                self.router.popViewController()
            }
            AlertService.messagePresent(title: "sendFeedbackAlertTitleSuccess".localized(), message: "sendFeedbackAlertTitleSuccessDescription".localized(), moreButtonAction: nil, firstAlertAction: action)
        }
        view.sendFeedbackCompleted()
    }
}
