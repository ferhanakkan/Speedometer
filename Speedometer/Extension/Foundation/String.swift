//
//  String.swift
//  BaseCode
//
//  Created by Ferhan Akkan on 13.08.2020.
//

import UIKit

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: LanguageService.shared.bundle, value: "", comment: "")
    }
}


