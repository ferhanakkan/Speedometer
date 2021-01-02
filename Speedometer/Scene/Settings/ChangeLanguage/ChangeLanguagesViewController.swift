//
//  ChangeLanguagesViewController.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 2.01.2021.
//

import UIKit

final class ChangeLanguagesViewController: UIViewController {
    
    var presenter: ChangeLanguagesPresenterProtocol!
    
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

extension ChangeLanguagesViewController {
    
    private func setUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        title = "changeLanguageTitle".localized()
        
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

extension ChangeLanguagesViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerTableView() {
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: Constants.ChangeLanguageViewController.languageCell)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ChangeLanguageViewController.languageCell, for: indexPath) as! LanguageTableViewCell
        cell.cellIndex = indexPath.row
        switch indexPath.row {
        case 0:
            cell.setTitle(title: "changeLanguageEnglish".localized())
        case 1:
            cell.setTitle(title: "changeLanguageTurkish".localized())
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectFromTableView(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: Protocols

extension ChangeLanguagesViewController: ChangeLanguagesViewProtocol {
    
}
