//
//  AccelerationProtocol.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 9.01.2021.
//

import UIKit
import Charts

//MARK: Router
protocol AccelerationRouterProtocol: class {
}

//MARK: Presenter

protocol AccelerationPresenterProtocol: class {
    var interactor: AccelerationInteractorInputProtocol! { get set }
    func viewWillAppear()
    func resetDatas()
}

//MARK: Interactor

// Interactor -> Presenter
protocol AccelerationInteractorOutputProtocol: class {
    func weatherDetailsCompleted(weather: WeatherModel?, error: Error?)
}

// Presenter -> Interactor

protocol AccelerationInteractorInputProtocol: class {
    var presenter: AccelerationInteractorOutputProtocol! { get set }
    func getWeatherDetails(longitude: Double, latitude: Double)
}

//MARK: View

protocol AccelerationViewProtocol: class {
    var presenter: AccelerationPresenterProtocol! { get set }
    func weatherDatas(temperature: Double, moisture: Int)
    func updateDatas(time: Int, maxSpeed: Double, chardData: LineChartData, signalStatus:  GPSSignalQualtyStatus, currentSpeed: Double)
}
