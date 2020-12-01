//
//  AppDelegate.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 30.11.2020.
//

import UIKit
import Firebase
import Siren

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        firebase(application)
        setLanguage()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AnimatedSplashViewController()
        window?.makeKeyAndVisible()
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        UserDefaults.standard.setValue(0, forKey: Constants.Badge.badgeNumber)
        UIApplication.shared.applicationIconBadgeNumber = 0
    }


    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    private func setLanguage() {
        AppManager.shared.appLaunchLanguage()
    }
    
    private func setSiren() {
        Siren.shared.wail()
    }

}

