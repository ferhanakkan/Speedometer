//
//  LanguageTableViewCell.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 2.01.2021.
//

import UIKit
import SnapKit

final class LanguageTableViewCell: UITableViewCell {
    
    var cellIndex = 0 {
        didSet {
            layout()
            setSelectedImageView()
        }
    }
    
    private let labelLanguage: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private let imageViewSelected: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "selected")
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//MARK: Set Cell UI

extension LanguageTableViewCell {
    
    private func layout() {
        self.backgroundColor = .secondColor
        self.contentView.backgroundColor = .clear
        
        if cellIndex == 0 {
            self.roundCornersEachCorner([.topLeft,.topRight], radius: 5)
        } else if cellIndex == 1 {
            self.roundCornersEachCorner([.bottomLeft,.bottomRight], radius: 5)
        } else {
            self.roundCornersEachCorner([.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 0)
        }
        
        addSubview(labelLanguage)
        labelLanguage.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(10)
            maker.top.equalToSuperview().offset(5)
            maker.bottom.equalToSuperview().inset(5)
        }
        
        addSubview(imageViewSelected)
        imageViewSelected.snp.makeConstraints { (maker) in
            maker.trailing.equalToSuperview().inset(10)
            maker.top.equalToSuperview().offset(15)
            maker.bottom.equalToSuperview().inset(15)
            maker.leading.equalTo(labelLanguage.snp.trailing).offset(10)
            maker.width.equalTo(20)
        }
    }
}

//MARK: Logic

extension LanguageTableViewCell {
    
    func setTitle(title: String) {
        labelLanguage.text = title
    }
    
    private func setSelectedImageView() {
        if let selectedLanguage = UserDefaults.standard.string(forKey: Constants.Language.langKey) {
            if selectedLanguage == "tr" && cellIndex == 1 {
                imageViewSelected.isHidden = false
            } else if selectedLanguage == "en" && cellIndex == 0 {
                imageViewSelected.isHidden = false
            } else {
                print("unexpected status ?!")
            }
        }
    }
}
