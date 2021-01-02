//
//  SceneDelegate.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 30.11.2020.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let newScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: newScene)
        window?.rootViewController = AnimatedSplashViewController()
        self.window?.makeKeyAndVisible()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        UserDefaults.standard.setValue(0, forKey: Constants.Badge.badgeNumber)
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        NotificationCenter.default.addObserver(self, selector: #selector(LanguageService.shared.test),
                                                       name: NSLocale.currentLocaleDidChangeNotification, object: nil)
    }
}

