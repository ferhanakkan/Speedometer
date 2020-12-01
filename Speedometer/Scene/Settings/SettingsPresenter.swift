//
//  SettingsPresenter.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 1.12.2020.
//

import Foundation

class SettingsPresenter {
    var view: SettingsViewProtocol!
    var interactor: SettingsInteractorInputProtocol!
    var router: SettingsRouterProtocol!
    
}

extension SettingsPresenter: SettingsPresenterProtocol {

}

extension SettingsPresenter: SettingsInteractorOutputProtocol {

}
