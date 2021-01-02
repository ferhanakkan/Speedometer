//
//  SettingsDonationCell.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 2.12.2020.
//

import UIKit
import SnapKit

final class SettingsDonationCell: UITableViewCell {
    
    var cellIndex = 0
    var type: SettingsDonate! {
        didSet {
            setUI()
        }
    }
    
    private let priceLabel = UILabel()
    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//MARK: Set Cell UI

extension SettingsDonationCell {
    
    private func setUI() {
        self.backgroundColor = .secondColor
        self.contentView.backgroundColor = .clear
        
        if cellIndex == 0 {
            self.roundCornersEachCorner([.topLeft,.topRight], radius: 8)
        } else if cellIndex == 2 {
            self.roundCornersEachCorner([.bottomLeft,.bottomRight], radius: 8)
        } else {
            self.roundCornersEachCorner([.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 0)
        }
        
        setLabel()
        setPrice()
        setDatas()
    }
    
    private func setLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.tintColor = .firstColor
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(5)
        }
    }
    
    private func setPrice() {
        contentView.addSubview(priceLabel)
        priceLabel.tintColor = .firstColor
        priceLabel.textAlignment = .right
        priceLabel.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(80)
            make.trailing.equalToSuperview().inset(10)
            make.leading.equalTo(titleLabel.snp.trailing)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
    
    private func setDatas() {
        switch type {
        case .fiveDolar:
            titleLabel.text = "settingsMiniBox".localized()
            priceLabel.text = "$ 4.99"
        case .tenDolar:
            titleLabel.text = "settingsMediumBox".localized()
            priceLabel.text = "$ 9.99"
        case .fifteen:
            titleLabel.text = "settingsBigBox".localized()
            priceLabel.text = "$ 14.99"
        default:
            print("unexpected status")
        }
    }
}




