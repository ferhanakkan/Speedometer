//
//  GForceProtocol.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 10.01.2021.
//

import UIKit
import Charts

//MARK: Router
protocol GForceRouterProtocol: class {
}

//MARK: Presenter

protocol GForcePresenterProtocol: class {
    var interactor: GForceInteractorInputProtocol! { get set }
    func viewWillAppear()
    func resetDatas()
}

//MARK: Interactor

// Interactor -> Presenter
protocol GForceInteractorOutputProtocol: class {
    func collectedGForece(x: Double, y: Double, z: Double)
}

// Presenter -> Interactor

protocol GForceInteractorInputProtocol: class {
    var presenter: GForceInteractorOutputProtocol! { get set }
    func getGForces()
}

//MARK: View

protocol GForceViewProtocol: class {
    var presenter: GForcePresenterProtocol! { get set }
    func updateDatas(x: Double, y: Double, z: Double, calculatedGForece: Double, maxGPower: Double)
}
