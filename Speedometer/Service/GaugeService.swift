//
//  GaugeService.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 3.01.2021.
//

import Foundation
import PromiseKit

class GaugeService {
    
    private let service = ApiService()
    
    func getWeatherDetails(longitude: Double, latitude: Double) -> Promise<WeatherModel> {
        return service.get(apiType: .weatherApi, url: "/weather?lat=\(latitude)&lon=\(longitude)&appid=\(AppManager.shared.weatherApiKey)")
    }
}
