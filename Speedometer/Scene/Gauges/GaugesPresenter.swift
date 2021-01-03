//
//  GaugesPresenter.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 3.01.2021.
//

import Foundation
import Charts

class GaugesPresenter: NSObject {
    
    var view: GaugesViewProtocol!
    var interactor: GaugesInteractorInputProtocol!
    var router: GaugesRouterProtocol!
    
    private var chartSettings: LineChartDataSet!
    private var chartData: LineChartData!
    private let testChartDatas: [ChartDataEntry] = [ChartDataEntry(x: 0, y: 0), ChartDataEntry(x: 2, y: 2),ChartDataEntry(x: 3, y: 3), ChartDataEntry(x: 1, y: 4)]
    
    override init() {
        super.init()
//        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
//            self.setChartSetSettings(chartDataObject: self.testChartDatas)
//        }
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
}

extension GaugesPresenter: GaugesPresenterProtocol {
}

extension GaugesPresenter: GaugesInteractorOutputProtocol {
    
}
