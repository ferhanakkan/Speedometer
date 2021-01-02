//
//  HeaderView.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 2.12.2020.
//

import UIKit

final class HeaderView: UIView {
    
    private let label = UILabel()
    
    public var type: SettingsCellType! {
        didSet {
            setUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Set View

extension HeaderView {
    
    private func setUI() {
        self.backgroundColor = .firstColor
        self.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
        label.tintColor = .firstColor
        label.font = .systemFont(ofSize: 12)
        
        if type == SettingsCellType.actionsType {
            label.text = "settingsFirstTitle".localized()
        } else {
            label.text = "settingsSecondTitle".localized()
        }
    }
}
