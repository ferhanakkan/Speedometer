//
//  SettingsViewController.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 1.12.2020.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    var presenter: SettingsPresenterProtocol!
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        registerTableView()
        setTableViewDelegate()
        tableView.reloadData()
    }
}

//MARK: SetUI

extension SettingsViewController {
    
    private func setUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.tintColor = .textColor
        self.navigationController?.navigationBar.barTintColor = .firstColor
        self.tabBarController?.tabBar.tintColor = .textColor
        self.tabBarController?.tabBar.barTintColor = .firstColor
        title = "settingsTitle".localized()
        
        view.backgroundColor = .firstColor
        setTableView()
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

//MARK: TableView Delegates

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerTableView() {
        tableView.register(SettingsDonationCell.self, forCellReuseIdentifier: Constants.SettingsViewController.donationCell)
        tableView.register(SettingsImageCell.self, forCellReuseIdentifier: Constants.SettingsViewController.imageCell)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        " "
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        CGFloat(30)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderView()
        if section == 0 {
            view.type = .actionsType
        } else {
            view.type = .donateType
        }
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.SettingsViewController.imageCell) as! SettingsImageCell
            cell.cellIndex = row
            if row == 0 {
                cell.type = .givePoint
            } else if row == 1 {
                cell.type = .sendFeedback
            } else if row == 2 {
                cell.type = .shareApp
            } else if row == 3 {
                cell.type = .setLanguage
            } else {
                cell.type = .gps
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.SettingsViewController.donationCell) as! SettingsDonationCell
            cell.cellIndex = row
            if row == 0 {
                cell.type = .fiveDolar
            } else if row == 1 {
                cell.type = .tenDolar
            } else {
                cell.type = .fifteen
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectFromTableView(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: Protocols

extension SettingsViewController: SettingsViewProtocol {
    
}
