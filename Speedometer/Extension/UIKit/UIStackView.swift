//
//  UIStackView.swift
//  DortMevsimSwift
//
//  Created by Ferhan Akkan on 26.09.2020.
//

import UIKit

extension UIStackView {
    
    func safelyRemoveArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (sum, next) -> [UIView] in
            self.removeArrangedSubview(next)
            return sum + [next]
        }
        
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    func addVerticalSeparators(color : UIColor) {
        var i = self.arrangedSubviews.count-1
        while i >= 1 {
            let separator = createSeparator(color: color)
            insertArrangedSubview(separator, at: i)
            separator.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
            i -= 1
        }
    }
    
    private func createSeparator(color : UIColor) -> UIView {
        let separator = UIView()
        separator.widthAnchor.constraint(equalToConstant: 2).isActive = true
        separator.backgroundColor = color
        return separator
    }
}
