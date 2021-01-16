//
//  AccelerationProtocol.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 9.01.2021.
//

import UIKit
import Charts
import CoreLocation

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
    func locationPermissionVerified()
    func locationDatas(location: CLLocation, gpsSignal: GPSSignalQualtyStatus)
}

// Presenter -> Interactor

protocol AccelerationInteractorInputProtocol: class {
    var presenter: AccelerationInteractorOutputProtocol! { get set }
    func getWeatherDetails(longitude: Double, latitude: Double)
    func verifyLocationPermission()
    func getLocationDatas()
}

//MARK: View

protocol AccelerationViewProtocol: class {
    var presenter: AccelerationPresenterProtocol! { get set }
    func weatherDatas(temperature: Double, moisture: Int)
    func updateDatas(time: Int, maxSpeed: Double, chardData: LineChartData, signalStatus:  GPSSignalQualtyStatus, currentSpeed: Double)
}
