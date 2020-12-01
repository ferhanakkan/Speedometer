//
//  AnimatedSplashViewController.swift
//  BaseCode
//
//  Created by Ferhan Akkan on 13.08.2020.
//

import UIKit
import SwiftyGif
import SnapKit

class AnimatedSplashViewController: UIViewController, SwiftyGifDelegate {
    
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let gif = try UIImage(gifName: "giphy.gif")
            self.imageView = UIImageView(gifImage: gif, loopCount: 1)
        } catch {
            print(error)
        }
        
        imageView.delegate = self
        view.addSubview(imageView)
        
        let ratio = CGFloat(480/360)
        imageView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.height*ratio)
        }

        view.layoutIfNeeded()
    }
    
    
    func gifDidStop(sender: UIImageView) {
        let _ = RootSelector()
    }
    
}
