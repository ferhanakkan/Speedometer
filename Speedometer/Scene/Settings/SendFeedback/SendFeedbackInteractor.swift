//
//  SendFeedbackInteractor.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 2.01.2021.
//

import Foundation
import Firebase
import FirebaseFirestore

class SendFeedbackInteractor {
    var presenter: SendFeedbackInteractorOutputProtocol!
    
    private let db = Firestore.firestore()
    private var firebaseRef: DocumentReference! 
    
    private func sendFeedbackToFirebase(text: String) {
        firebaseRef = db.collection("feedbacks").addDocument(data: [
            "commit": text
        ]) { err in
            if let err = err {
                self.presenter.sendFeedbackCompleted(withError: err)
            } else {
                self.presenter.sendFeedbackCompleted(withError: nil)
            }
        }
    }
}


extension SendFeedbackInteractor: SendFeedbackInteractorInputProtocol {
    
    func sendFeedback(text: String) {
        sendFeedbackToFirebase(text: text)
    }
}
