//
//  AlertService.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 2.01.2021.
//

import UIKit

final class AlertService {
    
    static func messagePresent(title: String, message: String, moreButtonAction: [UIAlertAction]?, firstAlertAction: UIAlertAction? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let firstAlert = firstAlertAction {
            alert.addAction(firstAlert)
        } else {
            alert.addAction(UIAlertAction(title: "sendFeedbackAlertButtonTitle".localized(), style: .default, handler: { (_) in
            }))
        }
        
        if let actions = moreButtonAction {
            for action in actions {
                alert.addAction(action)
            }
        }
        
        UIApplication.getPresentedViewController()?.present(alert, animated: true, completion: nil)
    }

}
