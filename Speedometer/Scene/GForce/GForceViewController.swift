//
//  GForceViewController.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 10.01.2021.
//

import UIKit
import SnapKit
import Charts
import LMGaugeViewSwift

final class GForceViewController: UIViewController {
    
    var presenter: GForcePresenterProtocol!
    
    private lazy var buttonReset: UIBarButtonItem = {
        let button = UIBarButtonItem.init(title: "reset".localized(),
                                     style: .plain,
                                     target: self,
                                     action: #selector(buttonResetPressed))
        return button
    }()
    
    private let labelXGforce: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.adjustsFontSizeToFitWidth = true
        label.text = "gForceXAxis".localized()
        return label
    }()
    
    private let labelYGforce: UILabel = {
        let label = UILabel()
        label.text = "gForceYAxis".localized()
        label.font = .boldSystemFont(ofSize: 30)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let labelZGforce: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.text = "gForceZAxis".localized()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let labelCalculatedGforce: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 50)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.text = "0 G"
        return label
    }()
    
    private let labelDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 4
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.text = "gForceDescription".localized()
        return label
    }()
    
    private let viewMaxGForce: DetailView = {
        let viewMaxGForce = DetailView(title: "gForceMaxForce".localized(), description: "")
        return viewMaxGForce
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

//MARK: SetUI

extension GForceViewController {
    
    private func setNavBar() {
        self.navigationController?.navigationBar.tintColor = .textColor
        self.navigationController?.navigationBar.barTintColor = .firstColor
        self.tabBarController?.tabBar.tintColor = .textColor
        self.tabBarController?.tabBar.barTintColor = .firstColor
        navigationItem.rightBarButtonItem = buttonReset
        title = "gForceTitle".localized()
    }
    
    private func layout() {
        view.backgroundColor = .firstColor
  
        view.addSubview(viewMaxGForce)
        viewMaxGForce.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview()
            maker.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-25)
            maker.height.equalTo(40)
        }
        
        view.addSubview(labelDescription)
        labelDescription.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().inset(20)
            maker.bottom.equalTo(self.viewMaxGForce.snp.top)
            maker.height.equalTo(150)
        }
        
        view.addSubview(labelXGforce)
        labelXGforce.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().inset(20)
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            maker.height.equalTo(25)
        }
        
        view.addSubview(labelYGforce)
        labelYGforce.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().inset(20)
            maker.top.equalTo(self.labelXGforce.snp.bottom).offset(20)
            maker.height.equalTo(25)
        }
        
        view.addSubview(labelZGforce)
        labelZGforce.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().inset(20)
            maker.top.equalTo(self.labelYGforce.snp.bottom).offset(20)
            maker.height.equalTo(25)
        }
        
        view.addSubview(labelCalculatedGforce)
        labelCalculatedGforce.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().inset(20)
            maker.top.equalTo(self.labelZGforce.snp.bottom).offset(10)
            maker.bottom.equalTo(self.labelDescription.snp.bottom).offset(-10)
        }
    }
}

//MARK: Actions

extension GForceViewController {
    
    @objc private func buttonResetPressed() {
        presenter.resetDatas()
    }
}

//MARK: Protocols

extension GForceViewController: GForceViewProtocol {
    func updateDatas(x: Double, y: Double, z: Double, calculatedGForece: Double, maxGPower: Double) {
        labelXGforce.text = "\("gForceXAxis".localized()):" + x.format(f: ".8")
        labelYGforce.text = "\("gForceYAxis".localized()):" + y.format(f: ".8")
        labelZGforce.text = "\("gForceZAxis".localized()):" + z.format(f: ".8")
        labelCalculatedGforce.text = "\(calculatedGForece.format(f: ".5")) G"
        viewMaxGForce.updateDescription(text: "\(maxGPower.format(f: ".3")) G")
    }
}
