//
//  LanguageService.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 2.01.2021.
//

import UIKit

enum Language: String {
    case english = "en"
    case turkish = "tr"
}

class LanguageService {
    
    static var shared = LanguageService()
    var bundle = Bundle()
    
    @objc func test() {
        UserDefaults.standard.setValue("asdasda", forKey: Constants.Language.langKey)
    }
    
    func appLaunchLanguage() {
        if let selectedLanguage = UserDefaults.standard.string(forKey: Constants.Language.langKey) {
            let path = Bundle.main.path(forResource: selectedLanguage, ofType: Constants.Language.langpath)
            self.bundle = Bundle(path: path!)!
        } else {
            let supportedLang = [Language.english.rawValue,Language.turkish.rawValue]
            let currentDeviceLang = Locale.current.languageCode
            if supportedLang.contains(currentDeviceLang!) {
                UserDefaults.standard.setValue(currentDeviceLang!, forKey: Constants.Language.phoneSettingsSettedLang)
                setLanguage(language: currentDeviceLang!)
            } else {
                UserDefaults.standard.setValue(currentDeviceLang!, forKey: Constants.Language.phoneSettingsSettedLang)
                setLanguage(language: .english)
            }
        }
    }
    
    func setLanguage(language: Language) {
        UserDefaults.standard.setValue(language.rawValue, forKey: Constants.Language.langKey)
        let path = Bundle.main.path(forResource: language.rawValue, ofType: Constants.Language.langpath)
        self.bundle = Bundle(path: path!)!
    }
    
    func setLanguage(language: String) {
        UserDefaults.standard.setValue(language, forKey: Constants.Language.langKey)
        let path = Bundle.main.path(forResource: language, ofType: Constants.Language.langpath)
        self.bundle = Bundle(path: path!)!
    }
    
    func getLanguage() -> String {
        return UserDefaults.standard.string(forKey: Constants.Language.langKey)!
    }
    
}
