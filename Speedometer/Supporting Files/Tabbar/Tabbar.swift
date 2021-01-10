//
//  Tabbar.swift
//  BaseCode
//
//  Created by Ferhan Akkan on 17.08.2020.
//

import UIKit

class Tabbar {
    class func createTabBar() -> UITabBarController {
        
        let tabController = UITabBarController()
        
        let navigationArray = [UINavigationController(rootViewController: SettingsRouter().controller),
                               UINavigationController(rootViewController: GaugesRouter().controller),
                               UINavigationController(rootViewController: AccelerationRouter().controller) ]
        
        for index in 0 ..< navigationArray.count {
            navigationArray[index].navigationBar.barTintColor = .firstColor
            navigationArray[index].navigationBar.tintColor = .textColor
        }
        
        tabController.viewControllers = navigationArray
        
        tabController.tabBar.barTintColor = .firstColor
        tabController.tabBar.tintColor = .textColor
        
        
//        tabController.tabBar.items?[0].image = UIImage(named: "LaunchScreen")
//        tabController.tabBar.items![0].selectedImage = UIImage(named: "LaunchScreen")

        tabController.tabBar.items![0].title = "tabbar.test".localized()
        tabController.tabBar.items![1].title = "Kadran"
        tabController.tabBar.items![2].title = "Hizlanma"

        return tabController
    }
}
