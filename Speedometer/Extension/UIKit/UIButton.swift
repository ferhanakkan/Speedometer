//
//  UIButton.swift
//  Cargram
//
//  Created by Ferhan Akkan on 11.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

extension UIButton {
    
    func createBarButton(backgroundImageName: String, size: Int, cornerRadius: Int, borderWidth: Int, borderColor: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: backgroundImageName), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: CGFloat(size)).isActive = true
        button.borderAndCorner(radius: CGFloat(cornerRadius), color: borderColor, width: borderWidth)
        return button
    }
}
