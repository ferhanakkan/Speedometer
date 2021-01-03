//
//  GaugesInteractor.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 3.01.2021.
//

import Foundation

class GaugesInteractor {
    var presenter: GaugesInteractorOutputProtocol!
    
    private let gaugesService = GaugeService()
    
    private func fetchWeatherDatas(longitude: Double, latitude: Double) {
        gaugesService.getWeatherDetails(longitude: longitude, latitude: latitude).done { (responseWeatherModel) in
            self.presenter.weatherDetailsCompleted(weather: responseWeatherModel, error: nil)
        }.catch { (error) in
            self.presenter.weatherDetailsCompleted(weather: nil, error: error)
        }
    }
    
}

extension GaugesInteractor: GaugesInteractorInputProtocol {
    func getWeatherDetails(longitude: Double, latitude: Double) {
        fetchWeatherDatas(longitude: longitude, latitude: latitude)
    }
}
