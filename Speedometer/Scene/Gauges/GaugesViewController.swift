//
//  GaugesViewController.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 3.01.2021.
//

import UIKit
import SnapKit
import Charts
import LMGaugeViewSwift

final class GaugesViewController: UIViewController {
    
    var presenter: GaugesPresenterProtocol!
    
    private lazy var chart: LineChartView = {
        let chart = LineChartView()
        chart.backgroundColor = .clear
        chart.rightAxis.enabled = false
        let yAxis = chart.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(10, force: true)
        yAxis.labelTextColor = .red
        yAxis.axisLineColor = .blue
        
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chart.xAxis.setLabelCount(10, force: true)
        chart.xAxis.labelTextColor = .red
        chart.xAxis.axisLineColor = .blue
//        chart.animate(xAxisDuration: 2.0)
        chart.isHidden = true
        return chart
    }()
    
    private lazy var gaugeView: GaugeView = {
        let gaugeView = GaugeView()
        gaugeView.backgroundColor = .clear
        gaugeView.delegate = self
        let screenMinSize = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        let ratio = Double(screenMinSize)/320
        gaugeView.divisionsRadius = 1.25 * ratio
        gaugeView.subDivisionsRadius = (1.25 - 0.5) * ratio
        gaugeView.ringThickness = 16 * ratio
        gaugeView.valueFont = UIFont(name: GaugeView.defaultFontName, size: CGFloat(140 * ratio))!
        gaugeView.unitOfMeasurementFont = UIFont(name: GaugeView.defaultFontName, size: CGFloat(16 * ratio))!
        gaugeView.minMaxValueFont = UIFont(name: GaugeView.defaultMinMaxValueFont, size: CGFloat(12 * ratio))!
        gaugeView.minValue = 0
        gaugeView.maxValue = 250
        gaugeView.limitValue = 80
        return gaugeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        layout()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setGaugesForColorChanges()
    }
}

//MARK: SetUI

extension GaugesViewController {
    
    private func setNavBar() {
        self.navigationController?.navigationBar.tintColor = .textColor
        self.navigationController?.navigationBar.barTintColor = .firstColor
        self.tabBarController?.tabBar.tintColor = .textColor
        self.tabBarController?.tabBar.barTintColor = .firstColor
        title = "Change IT"
    }
    
    private func layout() {
        view.backgroundColor = .firstColor
        
        view.addSubview(chart)
        chart.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.height.equalTo(UIScreen.main.bounds.width)
        }
        
        view.addSubview(gaugeView)
        gaugeView.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(30)
            maker.trailing.equalToSuperview().inset(30)
            maker.centerY.equalToSuperview()
            maker.height.equalTo(UIScreen.main.bounds.width-60)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            self.gaugeView.value = 160
        }
    }
}

//MARK: Gauges

extension GaugesViewController: GaugeViewDelegate {
    
    func ringStokeColor(gaugeView: GaugeView, value: Double) -> UIColor {
        if value >= 150 {
            return UIColor(red: 1, green: 59.0/255, blue: 48.0/255, alpha: 1)
        }
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle != .dark {
                return UIColor(red: 76.0/255, green: 217.0/255, blue: 100.0/255, alpha: 1)
            }
        }
        return UIColor(red: 11.0/255, green: 150.0/255, blue: 246.0/255, alpha: 1)
    }
    
    
    private func setGaugesForColorChanges() {
        if #available(iOS 12.0, *) {
            switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                gaugeView.ringBackgroundColor = UIColor(white: 0.9, alpha: 1)
                gaugeView.valueTextColor = UIColor(white: 0.1, alpha: 1)
                gaugeView.unitOfMeasurementTextColor = UIColor(white: 0.3, alpha: 1)
                gaugeView.setNeedsDisplay()
            case .dark:
                gaugeView.ringBackgroundColor = .black
                gaugeView.valueTextColor = .white
                gaugeView.unitOfMeasurementTextColor = UIColor(white: 0.7, alpha: 1)
                gaugeView.setNeedsDisplay()
            @unknown default:
                fatalError()
            }
        } else {
            gaugeView.ringBackgroundColor = UIColor(white: 0.9, alpha: 1)
            gaugeView.valueTextColor = UIColor(white: 0.1, alpha: 1)
            gaugeView.unitOfMeasurementTextColor = UIColor(white: 0.3, alpha: 1)
            gaugeView.setNeedsDisplay()
        }
    }
}

//MARK: Protocols

extension GaugesViewController: GaugesViewProtocol {
    func chartData(data: LineChartData) {
        chart.data = data
    }
}
