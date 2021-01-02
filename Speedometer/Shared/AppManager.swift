//
//  AppManager.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 2.01.2021.
//

import Foundation

final class AppManager {
    
    static var shared = AppManager()
    
    var speedUnitType: String = ""
    
    func checkSpeedUnit() {
        if let speedUnit = UserDefaults.standard.value(forKey: Constants.SettingsViewController.selectedSpeedUnitKey) as? String {
            speedUnitType = speedUnit
        } else {
            UserDefaults.standard.setValue(SettingsSpeedUnit.kmh.rawValue, forKey: Constants.SettingsViewController.selectedSpeedUnitKey)
            speedUnitType = SettingsSpeedUnit.kmh.rawValue
        }
        
    }
}
