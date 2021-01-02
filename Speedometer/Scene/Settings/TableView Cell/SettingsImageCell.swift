//
//  SettingsImageCell.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 2.12.2020.
//

import UIKit
import SnapKit

final class SettingsImageCell: UITableViewCell {
    
    var cellIndex = 0
    var type: SettingsActions = .givePoint {
        didSet {
            setUI()
        }
    }
    
    private let myImageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *) {
            setImageViewColor()
        }
    }
}

//MARK: Set Cell UI

extension SettingsImageCell {
    
    private func setUI() {
        self.backgroundColor = .secondColor
        
        if cellIndex == 0 {
            self.roundCornersEachCorner([.topLeft,.topRight], radius: 5)
        } else {
            self.roundCornersEachCorner([.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 0)
        }
        
        setLabel()
        setImage()
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
    
    private func setImage() {
        contentView.addSubview(myImageView)
        myImageView.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(30)
            make.trailing.equalToSuperview().inset(10)
            make.leading.equalTo(titleLabel.snp.trailing)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
    
    private func setDatas() {
        switch type {
        case .givePoint:
            titleLabel.text = "settingsPoint".localized()
            myImageView.image = #imageLiteral(resourceName: "rate")
        case .sendFeedback:
            titleLabel.text = "settingsFeedback".localized()
            myImageView.image = #imageLiteral(resourceName: "feedback")
        case .shareApp:
            titleLabel.text = "settingsShare".localized()
            myImageView.image = #imageLiteral(resourceName: "share")
        case .setLanguage:
            titleLabel.text = "settingsLanguage".localized()
            myImageView.image = #imageLiteral(resourceName: "language")
        case .gps:
            titleLabel.text = "settingsGps".localized()
            myImageView.image = #imageLiteral(resourceName: "gps")
        case .speedUnit:
            break
        }
        setImageViewColor()
    }
    
    private func setImageViewColor() {
        if #available(iOS 12.0, *) {
            switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                myImageView.tintColor = .black
            case .dark:
                myImageView.tintColor = .white
            @unknown default:
                fatalError()
            }
        } else {
            myImageView.tintColor = .black
        }
    }
}




