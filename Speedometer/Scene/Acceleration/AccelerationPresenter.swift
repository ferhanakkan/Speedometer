//
//  AccelerationPresenter.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 9.01.2021.
//

import Foundation
import Charts
import CoreLocation

class AccelerationPresenter: NSObject {
    
    var view: AccelerationViewProtocol!
    var interactor: AccelerationInteractorInputProtocol!
    var router: AccelerationRouterProtocol!
    
    private var maxSpeed: Double = 0
    private var time: Double = 0
    private var arraySpeedDatas: [Double] = []
    
    private var signalStatus: GPSSignalQualtyStatus = .noSignal
    private var isFirstTimeWeatherRequest = true
    
    private var chartSettings: LineChartDataSet!
    private var chartData: LineChartData!
    private var arrayChartDatas: [ChartDataEntry] = []
    
    
    override init() {
        super.init()
        setTimer()
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
    
    private func appendNewChartDatas() {
        let lastSpeed = self.arraySpeedDatas.last ?? 0
        self.arrayChartDatas.append(ChartDataEntry(x: time, y: lastSpeed))
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
  
    private func getWeatherInformation(latitude: Double, longitude: Double) {
        if isFirstTimeWeatherRequest {
            isFirstTimeWeatherRequest = false
            interactor.getWeatherDetails(longitude: longitude, latitude: latitude)
        }
    }
    
    private func updateDatas() {
        let lineChartDataToSend = setChartSetSettings(chartDataObject: self.arrayChartDatas)
        appendNewChartDatas()
        self.view.updateDatas(time: Int(time), maxSpeed: maxSpeed, chardData: lineChartDataToSend, signalStatus: signalStatus, currentSpeed: arraySpeedDatas.last ?? 0 )
    }
    
    private func setTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.time += 0.01
            self.updateDatas()
        }
    }
}

extension AccelerationPresenter: AccelerationPresenterProtocol {
    func viewWillAppear() {
        interactor.verifyLocationPermission()
    }
    
    func resetDatas() {
        arrayChartDatas.removeAll()
        maxSpeed = 0
        time = 0
        arraySpeedDatas.removeAll()
        view.updateDatas(time: Int(time), maxSpeed: maxSpeed, chardData: setChartSetSettings(chartDataObject: []), signalStatus: signalStatus, currentSpeed: 0)
    }
}

extension AccelerationPresenter: AccelerationInteractorOutputProtocol {
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
        
        if location.speed.nextUp >= 0 {
            self.arraySpeedDatas.append(location.speed.nextUp*AppManager.shared.multiply)
        } else {
            self.arraySpeedDatas.append(0)
        }
    }
}
