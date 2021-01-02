//
//  ApiServiceErrorHandling.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 3.01.2021.
//

import Foundation

class ApiServiceErrorHandling {
    
    func getError(json: [String : Any], statusCode: Int) -> String? {
        if let message = json["message"] as? [String:Any] {
            if let tokenError = message["text"] as? String {
                return tokenError
            } else if let tokenError = message["text"] as? [String] {
                return tokenError[0]
            } else {
                return nil
            }
        } else if let errors = json["errors"] as? [String: Any] {
            if let tcGecersiz = errors["TCNo"] as? String {
                return tcGecersiz
            } else if let smsCode = errors["smsCode"] as? String {
                return smsCode
            } else if let alreadyadded = errors["alreadyadded"] as? String {
                return alreadyadded
            } else if let form = errors["form"] as? String {
                return form
            } else if let code = errors["code"] as? String {
                return code
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}

