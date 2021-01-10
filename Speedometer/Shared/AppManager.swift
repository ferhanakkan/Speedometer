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
    var multiply: Double = 1
    var weatherApiKey = Bundle.main.object(forInfoDictionaryKey: "WeatherApiKey") as! String
    
    func checkSpeedUnit() {
        if let speedUnit = UserDefaults.standard.value(forKey: Constants.SettingsViewController.selectedSpeedUnitKey) as? String {
            speedUnitType = speedUnit
            
            if speedUnit == SettingsSpeedUnit.kmh.rawValue {
                multiply = 1
            } else {
                multiply = 0.621371192
            }
        } else {
            UserDefaults.standard.setValue(SettingsSpeedUnit.kmh.rawValue, forKey: Constants.SettingsViewController.selectedSpeedUnitKey)
            speedUnitType = SettingsSpeedUnit.kmh.rawValue
        }
        
    }
}
