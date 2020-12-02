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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *) {
            priceLabel.tintColor = .firstColor
            titleLabel.tintColor = .firstColor
            contentView.backgroundColor = .secondColor
        }
    }
}

//MARK: Set Cell UI

extension SettingsDonationCell {
    
    private func setUI() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .secondColor
        
        if cellIndex == 0 {
            contentView.roundCornersEachCorner([.topLeft,.topRight], radius: 8)
        } else if cellIndex == 2 {
            contentView.roundCornersEachCorner([.bottomLeft,.bottomRight], radius: 8)
        } else {
            contentView.roundCornersEachCorner([.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 0)
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
            make.leading.top.equalToSuperview().offset(5)
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
            make.trailing.equalToSuperview().inset(5)
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




