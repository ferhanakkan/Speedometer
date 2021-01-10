//
//  SettingsSpeedUnitTableViewCell.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 2.01.2021.
//

import UIKit
import SnapKit

final class SettingsSpeedUnitTableViewCell: UITableViewCell {
    
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "settingsSpeedUnit".localized()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let labelDescription: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var switchStatus: UISwitch = {
        let switchStatus = UISwitch()
        switchStatus.addTarget(self, action: #selector(switchChanged(mySwitch:)), for: .valueChanged)
        return switchStatus
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        getSelectedSpeedUnit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Set Cell UI

extension SettingsSpeedUnitTableViewCell {
    
    private func layout() {
        contentView.backgroundColor = .clear
        backgroundColor = .secondColor
        self.roundCornersEachCorner([.bottomLeft,.bottomRight], radius: 5)
        
        addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(5)
        }
        
        addSubview(labelDescription)
        labelDescription.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.leading.equalTo(labelTitle.snp.trailing)
            make.bottom.equalToSuperview().inset(5)
            make.width.equalTo(40)
        }
        
        addSubview(switchStatus)
        switchStatus.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(10)
            make.leading.equalTo(labelDescription.snp.trailing)
        }
    }
}

//MARK: Logic

extension SettingsSpeedUnitTableViewCell {
    
    private func getSelectedSpeedUnit() {
        if let speedUnit = UserDefaults.standard.value(forKey: Constants.SettingsViewController.selectedSpeedUnitKey) as? String{
            if speedUnit == SettingsSpeedUnit.kmh.rawValue {
                labelDescription.text = speedUnit
                switchStatus.isOn = true
            } else {
                labelDescription.text = speedUnit
                switchStatus.isOn = false
            }
        }
    }

    @objc func switchChanged(mySwitch: UISwitch) {
        let userdefs = UserDefaults.standard
        if mySwitch.isOn {
            labelDescription.text = SettingsSpeedUnit.kmh.rawValue
            userdefs.setValue(SettingsSpeedUnit.kmh.rawValue, forKey: Constants.SettingsViewController.selectedSpeedUnitKey)
            AppManager.shared.multiply = 1
            AppManager.shared.speedUnitType = SettingsSpeedUnit.kmh.rawValue
        } else {
            labelDescription.text = SettingsSpeedUnit.mph.rawValue
            userdefs.setValue(SettingsSpeedUnit.mph.rawValue, forKey: Constants.SettingsViewController.selectedSpeedUnitKey)
            AppManager.shared.multiply = 0.621371192
            AppManager.shared.speedUnitType = SettingsSpeedUnit.mph.rawValue
        }
    }
}


