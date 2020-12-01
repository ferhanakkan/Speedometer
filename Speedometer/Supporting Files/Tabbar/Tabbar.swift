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
        
        let navigationArray = [UINavigationController(rootViewController: TestVC())]
        
        for index in 0 ..< navigationArray.count {
            navigationArray[index].navigationBar.barTintColor = .darkGray
            navigationArray[index].navigationBar.backgroundColor = .gray
            navigationArray[index].navigationBar.tintColor = .orange
        }
        
        tabController.viewControllers = navigationArray
        
        tabController.tabBar.backgroundColor = .gray
        tabController.tabBar.barTintColor = .darkGray
        tabController.tabBar.tintColor = .orange
        
//        tabController.tabBar.items?[0].image = UIImage(named: "LaunchScreen")
//        tabController.tabBar.items![0].selectedImage = UIImage(named: "LaunchScreen")

        tabController.tabBar.items![0].title = "tabbar.test".localized()

        return tabController
    }
}
