//
//  Double.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 9.01.2021.
//

import Foundation

extension Int {
    func format(f: String) -> String {
        return String(format: "%\(f)d", self)
    }
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
