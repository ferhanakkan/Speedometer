//
//  AppDelegate.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 30.11.2020.
//

import UIKit
import Firebase
import Siren
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        firebase(application)
        setLanguage()
        setIQKeyboard()
        setSpeedUnit()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AnimatedSplashViewController()
        window?.makeKeyAndVisible()
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        UserDefaults.standard.setValue(0, forKey: Constants.Badge.badgeNumber)
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        NotificationCenter.default.addObserver(self, selector: #selector(LanguageService.shared.test),
                                                       name: NSLocale.currentLocaleDidChangeNotification, object: nil)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        NotificationCenter.default.addObserver(self, selector: #selector(LanguageService.shared.test),
                                                       name: NSLocale.currentLocaleDidChangeNotification, object: nil)
    }
    
    private func setSpeedUnit() {
        AppManager.shared.checkSpeedUnit()
    }

    private func setLanguage() {
        LanguageService.shared.appLaunchLanguage()
    }
    
    private func setSiren() {
        Siren.shared.wail()
    }
    
    private func setIQKeyboard() {
        IQKeyboardManager.shared.enable = true
    }
}

