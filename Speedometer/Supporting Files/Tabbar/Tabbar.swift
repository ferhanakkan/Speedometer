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
        
        let navigationArray = [
            UINavigationController(rootViewController: GaugesRouter().controller),
            UINavigationController(rootViewController: AccelerationRouter().controller),
            UINavigationController(rootViewController: GForceRouter().controller),
            UINavigationController(rootViewController: SettingsRouter().controller)]
        
        for index in 0 ..< navigationArray.count {
            navigationArray[index].navigationBar.barTintColor = .firstColor
            navigationArray[index].navigationBar.tintColor = .textColor
        }
        
        tabController.viewControllers = navigationArray
        
        tabController.tabBar.barTintColor = .firstColor
        tabController.tabBar.tintColor = .textColor
        
        
        tabController.tabBar.items?[0].image = UIImage(named: "gaugeTabbar")
        tabController.tabBar.items![0].selectedImage = UIImage(named: "gaugeTabbar")
        tabController.tabBar.items?[1].image = UIImage(named: "pedals")
        tabController.tabBar.items![1].selectedImage = UIImage(named: "pedals")
        tabController.tabBar.items?[2].image = UIImage(named: "g")
        tabController.tabBar.items![2].selectedImage = UIImage(named: "g")
        tabController.tabBar.items?[3].image = UIImage(named: "settings")
        tabController.tabBar.items![3].selectedImage = UIImage(named: "settings")

        tabController.tabBar.items![0].title = "gauge".localized()
        tabController.tabBar.items![1].title = "acceleration".localized()
        tabController.tabBar.items![2].title = "gForce".localized()
        tabController.tabBar.items![3].title = "settings".localized()

        return tabController
    }
}
