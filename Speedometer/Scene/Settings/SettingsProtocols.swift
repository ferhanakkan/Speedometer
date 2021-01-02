//
//  SettingsProtocols.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 1.12.2020.
//

import UIKit

//MARK: Router
protocol SettingsRouterProtocol: class {
    func presentShareApp(activityVC: UIActivityViewController)
    func showFeedbackController()
    func showChangeLanguage()
}

//MARK: Presenter

protocol SettingsPresenterProtocol: class {
    var interactor: SettingsInteractorInputProtocol! { get set }
    func didSelectFromTableView(indexPath: IndexPath)
}

//MARK: Interactor

// Interactor -> Presenter
protocol SettingsInteractorOutputProtocol: class {
}

// Presenter -> Interactor

protocol SettingsInteractorInputProtocol: class {
    var presenter: SettingsInteractorOutputProtocol! { get set }
}

//MARK: View

protocol SettingsViewProtocol: class {
    var presenter: SettingsPresenterProtocol! { get set }
}
