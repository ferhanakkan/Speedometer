//
//  ChangeLanguagesPresenter.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 2.01.2021.
//

import Foundation
import StoreKit

class ChangeLanguagesPresenter {
    var view: ChangeLanguagesViewProtocol!
    var interactor: ChangeLanguagesInteractorInputProtocol!
    var router: ChangeLanguagesRouterProtocol!
    
    private func changeLanguage(index: Int) {
        switch index {
        case 0:
            LanguageService.shared.setLanguage(language: .english)
        case 1:
            LanguageService.shared.setLanguage(language: .turkish)
        default:
            break
        }
        router.refreshRoot()
    }
}

extension ChangeLanguagesPresenter: ChangeLanguagesPresenterProtocol {
    func didSelectFromTableView(indexPath: IndexPath) {
        changeLanguage(index: indexPath.row)
    }
}

extension ChangeLanguagesPresenter: ChangeLanguagesInteractorOutputProtocol {

}
