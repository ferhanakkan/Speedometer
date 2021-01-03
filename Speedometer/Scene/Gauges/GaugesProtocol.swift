//
//  GaugesProtocol.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 3.01.2021.
//

import UIKit
import Charts

//MARK: Router
protocol GaugesRouterProtocol: class {
}

//MARK: Presenter

protocol GaugesPresenterProtocol: class {
    var interactor: GaugesInteractorInputProtocol! { get set }
}

//MARK: Interactor

// Interactor -> Presenter
protocol GaugesInteractorOutputProtocol: class {
}

// Presenter -> Interactor

protocol GaugesInteractorInputProtocol: class {
    var presenter: GaugesInteractorOutputProtocol! { get set }
}

//MARK: View

protocol GaugesViewProtocol: class {
    var presenter: GaugesPresenterProtocol! { get set }
    func chartData(data: LineChartData)
}
