//
//  TestVC.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 30.11.2020.
//

import UIKit

class TestVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.

        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
        button.setTitle("Crash", for: [])
        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(button)
        view.backgroundColor = .white
        
        
    }

    @objc func crashButtonTapped(_ sender: AnyObject) {
        fatalError()
    }
}
