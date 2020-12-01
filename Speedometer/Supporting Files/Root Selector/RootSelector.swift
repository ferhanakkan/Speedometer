//
//  RootSelector.swift
//  BaseCode
//
//  Created by Ferhan Akkan on 13.08.2020.
//

import UIKit

class RootSelector {
    
    init() {
        UIApplication.getPresentedViewController()?.view.window?.rootViewController = Tabbar.createTabBar()
    }
}

