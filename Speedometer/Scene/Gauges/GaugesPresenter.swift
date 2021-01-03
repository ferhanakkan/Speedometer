//
//  GaugesPresenter.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 3.01.2021.
//

import Foundation
import Charts
import CoreLocation

class GaugesPresenter: NSObject {
    
    var view: GaugesViewProtocol!
    var interactor: GaugesInteractorInputProtocol!
    var router: GaugesRouterProtocol!
    
    private var avarageSpeed: Double = 0
    private var distance: Double = 0
    private var maxSpeed: Double = 0
    private var time: Double = 0
    private var isFirstTimeWeatherRequest = true
    private var signalStatus: GPSSignalQualtyStatus = .noSignal
    private var arrayLocationDatas: [CLLocation] = []
    private var arraySpeedDatas: [Double] = []
    
    private let gpsService = GPSService()
    private var chartSettings: LineChartDataSet!
    private var chartData: LineChartData!
    private var arrayChartDatas: [ChartDataEntry] = []
//    private let testChartDatas: [ChartDataEntry] = [ChartDataEntry(x: 0, y: 0), ChartDataEntry(x: 2, y: 2),ChartDataEntry(x: 3, y: 3), ChartDataEntry(x: 1, y: 4)]
    
    override init() {
        super.init()
//        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
//            self.setChartSetSettings(chartDataObject: self.testChartDatas)
//        }
    }
    
    private func verifyLocationpermission() {
        gpsService.verifyOrAskForLocationPermission { (isValidate) in
            if isValidate {
                self.getLocationDatas()
            }
        }
    }
    
    private func getLocationDatas() {
        gpsService.locationDatas = { location, gpsSignalQualty in
            self.getWeatherInformation(latitude: location.coordinate.latitude,
                                       longitude: location.coordinate.longitude)
            self.signalStatus = gpsSignalQualty
            self.arrayLocationDatas.append(location)
            self.arraySpeedDatas.append(location.speed.nextUp)
            
        }
    }
    
    private func getWeatherInformation(latitude: Double, longitude: Double) {
        if isFirstTimeWeatherRequest {
            isFirstTimeWeatherRequest = false
            interactor.getWeatherDetails(longitude: longitude, latitude: latitude)
        }
    }
    
    private func setTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.time += 1
        }
    }
    
    private func setChartSetSettings(chartDataObject: [ChartDataEntry]) {
        chartSettings = LineChartDataSet(entries: chartDataObject, label: "Speed Chart")
        chartSettings.drawCirclesEnabled = false
        chartSettings.mode = .cubicBezier
        chartSettings.lineWidth = 2
        chartSettings.setColor(.red)
        chartSettings.fill = Fill(color: UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.4))
        chartSettings.drawFilledEnabled = true
        chartSettings.drawHorizontalHighlightIndicatorEnabled = false
        chartSettings.drawVerticalHighlightIndicatorEnabled = false
        chartData = LineChartData(dataSet: chartSettings)
        chartData.setDrawValues(false)
        view.chartData(data: chartData)
    }
    
    private func calculateAverageSpeed() {
        if arraySpeedDatas.isEmpty {
            avarageSpeed = 0
        } else {
            let average = arraySpeedDatas.reduce(0.0) {
                return $0 + $1/Double(arraySpeedDatas.count)
            }
            avarageSpeed = average
        }
    }
    
    private func calculateMaxSpeed() {
        if arraySpeedDatas.isEmpty {
            maxSpeed = 0
        } else {
            maxSpeed = arraySpeedDatas.max()!
        }
    }
    
    private func calculateDistance() {
        
    }
    
    private func calculateChartDatas() {
        
    }
}

extension GaugesPresenter: GaugesPresenterProtocol {
    func viewWillAppear() {
        verifyLocationpermission()
    }
    
    func resetDatas() {
        time = 0
        avarageSpeed = 0
        distance = 0
        maxSpeed = 0
        arrayLocationDatas.removeAll()
        arrayChartDatas.removeAll()
    }
}

extension GaugesPresenter: GaugesInteractorOutputProtocol {
    func weatherDetailsCompleted(weather: WeatherModel?, error: Error?) {
        if let weather = weather {
            let celsuisTemp = (weather.main!.temp!-273)
            view.weatherDatas(temperature: celsuisTemp, moisture: weather.main!.humidity!)
        } else {
            AlertService.messagePresent(title: "Error", message: error!.localizedDescription, moreButtonAction: nil)
        }
    }
}
