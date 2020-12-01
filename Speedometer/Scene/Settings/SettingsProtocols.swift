//
//  SettingsProtocols.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 1.12.2020.
//

import Foundation

//MARK: Router
protocol SettingsRouterProtocol: class { }

//MARK: Presenter

protocol SettingsPresenterProtocol: class {
    var interactor: SettingsInteractorInputProtocol! { get set }
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
