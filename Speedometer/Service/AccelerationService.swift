//
//  AccelerationService.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 9.01.2021.
//

import Foundation
import PromiseKit

class AccelerationService {
    
    private let service = ApiService()
    
    func getWeatherDetails(longitude: Double, latitude: Double) -> Promise<WeatherModel> {
        return service.get(apiType: .weatherApi, url: "/weather?lat=\(latitude)&lon=\(longitude)&appid=\(AppManager.shared.weatherApiKey)")
    }
}
