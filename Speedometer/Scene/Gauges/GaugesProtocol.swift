//
//  GaugesProtocol.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 3.01.2021.
//

import UIKit
import Charts
import CoreLocation

//MARK: Router
protocol GaugesRouterProtocol: class {
}

//MARK: Presenter

protocol GaugesPresenterProtocol: class {
    var interactor: GaugesInteractorInputProtocol! { get set }
    func viewWillAppear()
    func resetDatas()
}

//MARK: Interactor

// Interactor -> Presenter
protocol GaugesInteractorOutputProtocol: class {
    func weatherDetailsCompleted(weather: WeatherModel?, error: Error?)
    func locationPermissionVerified()
    func locationDatas(location: CLLocation, gpsSignal: GPSSignalQualtyStatus)
}

// Presenter -> Interactor

protocol GaugesInteractorInputProtocol: class {
    var presenter: GaugesInteractorOutputProtocol! { get set }
    func getWeatherDetails(longitude: Double, latitude: Double)
    func verifyLocationPermission()
    func getLocationDatas()
}

//MARK: View

protocol GaugesViewProtocol: class {
    var presenter: GaugesPresenterProtocol! { get set }
    func weatherDatas(temperature: Double, moisture: Int)
    func updateDatas(time: Int, distance: Double, maxSpeed: Double, avarageSpeed: Double, chardData: LineChartData, currentSpeed: Double, signalStatus:  GPSSignalQualtyStatus)
}
