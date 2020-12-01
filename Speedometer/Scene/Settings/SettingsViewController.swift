//
//  SettingsViewController.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 1.12.2020.
//

import UIKit

final class SettingsViewController: UITableViewController {
    
    var presenter: SettingsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

//MARK: SetUI

extension SettingsViewController {
    
    private func setUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        title = "test"
//        view.backgroundColor = .lightGray
        
    }
}

//MARK: TableView Delegates

extension SettingsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: Protocols

extension SettingsViewController: SettingsViewProtocol {
    
}
