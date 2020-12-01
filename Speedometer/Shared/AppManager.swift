//
//  AppManager.swift
//  BaseCode
//
//  Created by Ferhan Akkan on 30.07.2020.
//

import UIKit

enum Language: String {
    case english = "en"
    case turkish = "tr"
}

class AppManager {
    
    static var shared = AppManager()
    var bundle = Bundle()
}

//MARK: Language

extension AppManager {
    
    
    func appLaunchLanguage() {
        if let selectedLanguage = UserDefaults.standard.string(forKey: Constants.Language.langKey) {
            let path = Bundle.main.path(forResource: selectedLanguage, ofType: Constants.Language.langpath)
            self.bundle = Bundle(path: path!)!
        } else {
            let supportedLang = [Language.english.rawValue,Language.turkish.rawValue]
            let currentDeviceLang = Locale.current.languageCode
            if supportedLang.contains(currentDeviceLang!) {
                setLanguage(language: currentDeviceLang!)
            } else {
                setLanguage(language: .english)
            }
        }
    }
    
    func setLanguage(language: Language) {
        UserDefaults.standard.setValue(language.rawValue, forKey: Constants.Language.langKey)
        let path = Bundle.main.path(forResource: language.rawValue, ofType: Constants.Language.langpath)
        self.bundle = Bundle(path: path!)!
//        let _ = RootSelector()
    }
    
    func setLanguage(language: String) {
        UserDefaults.standard.setValue(language, forKey: Constants.Language.langKey)
        let path = Bundle.main.path(forResource: language, ofType: Constants.Language.langpath)
        self.bundle = Bundle(path: path!)!
//        let _ = RootSelector()
    }
    
    func getLanguage() -> String {
        return UserDefaults.standard.string(forKey: Constants.Language.langKey)!
    }
    
}

//MARK: - Custom Alert
extension AppManager {

func messagePresent(title: String, message: String, moreButtonAction: [UIAlertAction]?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: Constants.AlertMessage.ok, style: .default, handler: { (_) in
        
    }))
    
    if let actions = moreButtonAction {
        for action in actions {
            alert.addAction(action)
        }
    }
    
    UIApplication.getPresentedViewController()?.present(alert, animated: true, completion: nil)
}

}
