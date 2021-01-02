//
//  ChangeLanguageProtocols.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 2.01.2021.
//

import UIKit

//MARK: Router
protocol ChangeLanguagesRouterProtocol: class {
    func refreshRoot()
}

//MARK: Presenter

protocol ChangeLanguagesPresenterProtocol: class {
    var interactor: ChangeLanguagesInteractorInputProtocol! { get set }
    func didSelectFromTableView(indexPath: IndexPath)
}

//MARK: Interactor

// Interactor -> Presenter
protocol ChangeLanguagesInteractorOutputProtocol: class {
}

// Presenter -> Interactor

protocol ChangeLanguagesInteractorInputProtocol: class {
    var presenter: ChangeLanguagesInteractorOutputProtocol! { get set }
}

//MARK: View

protocol ChangeLanguagesViewProtocol: class {
    var presenter: ChangeLanguagesPresenterProtocol! { get set }
}
