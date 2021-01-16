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
    private var time: Int = 0
    private var isFirstTimeWeatherRequest = true
    private var signalStatus: GPSSignalQualtyStatus = .noSignal
    private var arrayLocationDatas: [CLLocation] = []
    private var arraySpeedDatas: [Double] = []
    
    private let gpsService = GPSService()
    private var chartSettings: LineChartDataSet!
    private var chartData: LineChartData!
    private var arrayChartDatas: [ChartDataEntry] = []
    
    override init() {
        super.init()
        setTimer()
        sendDatas()
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
            self.calculateChartDatas()
        }
    }
    
    private func sendDatas() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.updateDatas()
        }
    }
    
    private func setChartSetSettings(chartDataObject: [ChartDataEntry]) -> LineChartData {
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
        return chartData
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
            if let maxData = arraySpeedDatas.max() {
                if maxData >= 0.1 {
                    maxSpeed = maxData
                } else {
                    maxSpeed = 0
                }
            } else {
                maxSpeed = 0
            }
        }
    }
    
    private func calculateDistance() {
        distance = 0
//        if arraySpeedDatas.isEmpty {
//            distance = 0
//        } else {
//
//        }
    }
    
    private func calculateChartDatas() {
        let doubleTime = Double(self.time)
        let lastSpeed = self.arraySpeedDatas.last ?? 0
        self.arrayChartDatas.append(ChartDataEntry(x: doubleTime, y: lastSpeed))
    }
    
    private func updateDatas() {
        calculateDistance()
        calculateMaxSpeed()
        calculateAverageSpeed()
        
        let lineChartDataToSend = setChartSetSettings(chartDataObject: self.arrayChartDatas)
        guard let currentSpeedToSend = arraySpeedDatas.last else { return }

        view.updateDatas(time: time, distance: distance, maxSpeed: maxSpeed, avarageSpeed: avarageSpeed, chardData: lineChartDataToSend, currentSpeed: currentSpeedToSend, signalStatus: signalStatus)
    }
}

extension GaugesPresenter: GaugesPresenterProtocol {
    func viewWillAppear() {
        interactor.verifyLocationPermission()
    }
    
    func resetDatas() {
        time = 0
        avarageSpeed = 0
        distance = 0
        maxSpeed = 0
        arrayLocationDatas.removeAll()
        arrayChartDatas.removeAll()
        arraySpeedDatas.removeAll()
        
        view.updateDatas(time: time, distance: distance, maxSpeed: maxSpeed, avarageSpeed: avarageSpeed, chardData: setChartSetSettings(chartDataObject: []), currentSpeed: 0.0, signalStatus: signalStatus)
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
    
    func locationPermissionVerified() {
        interactor.getLocationDatas()
    }
    
    func locationDatas(location: CLLocation, gpsSignal: GPSSignalQualtyStatus) {
        self.getWeatherInformation(latitude: location.coordinate.latitude,
                                   longitude: location.coordinate.longitude)
        self.signalStatus = gpsSignal
        self.arrayLocationDatas.append(location)
        if location.speed.nextUp >= 0 {
            self.arraySpeedDatas.append(location.speed.nextUp*AppManager.shared.multiply)
        } else {
            self.arraySpeedDatas.append(0)
        }
    }
}
