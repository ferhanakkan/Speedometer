//
//  Constants.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 1.12.2020.
//

import Foundation

struct Constants {
    
    struct Api {
        static var token = "token"
    }
    
     struct Language {
        static var langKey = "lang"
        static var langpath = "lproj"
        static var phoneSettingsSettedLang = "phoneLangSettings"
    }
    
    struct Badge {
        static let badgeNumber = "badge"
    }
    
    struct AlertMessage {
        static var title = "alertTitle".localized()
        static var ok = "alertOkButton".localized()
    }
    
    struct SettingsViewController {
        static var speedCell = "SettingsSpeedUnitTableViewCell"
        static var donationCell = "SettingsDonationCell"
        static var imageCell = "SettingsImageCell"
        static var selectedSpeedUnitKey = "SpeedUnit"
    }
    
    struct ChangeLanguageViewController {
        static var languageCell = "LanguageTableViewCell"
    }
}


