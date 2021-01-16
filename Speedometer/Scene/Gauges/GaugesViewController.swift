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
    
    private lazy var buttonReset: UIBarButtonItem = {
        let button = UIBarButtonItem.init(title: "reset".localized(),
                                     style: .plain,
                                     target: self,
                                     action: #selector(buttonResetPressed))
        return button
    }()
    
    private let labelSignalQuality: UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.text = "gaugeSignalQuality".localized()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var buttonChartTypeSelector: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "gauge"), for: .selected)
        button.setBackgroundImage(UIImage(named: "chart"), for: .normal)
        button.addTarget(self, action: #selector(buttonChartTypePressed), for: .touchUpInside)
        return button
    }()
    
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
        gaugeView.isHidden = false
        return gaugeView
    }()
    
    private let weatherView: DetailView = {
        let weatherView = DetailView(title: "gaugeWeatherStatus".localized(), description: "")
        return weatherView
    }()
    
    private let moistureView: DetailView = {
        let moistureView = DetailView(title: "gaugeMoisture".localized(), description: "")
        return moistureView
    }()
     
    private let distanceView: DetailView = {
        let distanceView = DetailView(title: "", description: "")
        return distanceView
    }()
    
    private let timeView: DetailView = {
        let timeView = DetailView(title: "gaugeTime".localized(), description: "")
        return timeView
    }()
    
    private let averageSpeedView: DetailView = {
        let averageSpeedView = DetailView(title: "gaugeAverageSpeed".localized(), description: "")
        return averageSpeedView
    }()
    
    private let maxSpeedView: DetailView = {
        let maxSpeedView = DetailView(title: "gaugeMaxSpeed".localized(), description: "")
        return maxSpeedView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        layout()
        setGaugesForColorChanges()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gaugeView.updateSpeedType(text: AppManager.shared.speedUnitType)
        presenter.viewWillAppear()
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
        navigationItem.rightBarButtonItem = buttonReset
        title = "gaugeTitle".localized()
    }
    
    private func layout() {
        view.backgroundColor = .firstColor
        
        view.addSubview(labelSignalQuality)
        labelSignalQuality.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        view.addSubview(chart)
        chart.snp.makeConstraints { (maker) in
            maker.top.equalTo(labelSignalQuality.snp.bottom).offset(5)
            maker.leading.equalToSuperview().offset(30)
            maker.trailing.equalToSuperview().inset(30)
            maker.height.equalTo(UIScreen.main.bounds.width-60)
        }
        
        view.addSubview(gaugeView)
        gaugeView.snp.makeConstraints { (maker) in
            maker.top.equalTo(labelSignalQuality.snp.bottom).offset(5)
            maker.leading.equalToSuperview().offset(30)
            maker.trailing.equalToSuperview().inset(30)
            maker.height.equalTo(UIScreen.main.bounds.width-60)
        }
        
        view.addSubview(buttonChartTypeSelector)
        buttonChartTypeSelector.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(40)
            maker.trailing.equalToSuperview().inset(20)
            maker.top.equalTo(gaugeView.snp.top)
        }
        
        view.addSubview(averageSpeedView)
        averageSpeedView.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(30)
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            maker.height.equalTo(40)
        }
        
        view.addSubview(maxSpeedView)
        maxSpeedView.snp.makeConstraints { (maker) in
            maker.trailing.equalToSuperview().inset(30)
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            maker.height.equalTo(40)
            maker.leading.equalTo(averageSpeedView.snp.trailing).offset(20)
            maker.width.equalTo(averageSpeedView.snp.width)
        }
        
//        view.addSubview(distanceView)
//        distanceView.snp.makeConstraints { (maker) in
//            maker.leading.equalToSuperview().offset(30)
//            maker.bottom.equalTo(averageSpeedView.snp.top).offset(-20)
//            maker.height.equalTo(40)
//        }
        
        view.addSubview(timeView)
        timeView.snp.makeConstraints { (maker) in
            maker.trailing.equalToSuperview().inset(30)
            maker.bottom.equalTo(maxSpeedView.snp.top).offset(-20)
            maker.height.equalTo(40)
            maker.leading.equalToSuperview().offset(30)
        }
        
        view.addSubview(weatherView)
        weatherView.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(30)
            maker.bottom.equalTo(timeView.snp.top).offset(-20)
            maker.height.equalTo(40)
        }
        
        view.addSubview(moistureView)
        moistureView.snp.makeConstraints { (maker) in
            maker.trailing.equalToSuperview().inset(30)
            maker.bottom.equalTo(timeView.snp.top).offset(-20)
            maker.height.equalTo(40)
            maker.leading.equalTo(weatherView.snp.trailing).offset(20)
            maker.width.equalTo(weatherView.snp.width)
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

//MARK: Actions

extension GaugesViewController {
    
    @objc private func buttonResetPressed() {
        presenter.resetDatas()
    }
    
    @objc private func buttonChartTypePressed() {
        gaugeView.isHidden = !gaugeView.isHidden
        chart.isHidden = !chart.isHidden
        buttonChartTypeSelector.isSelected = !buttonChartTypeSelector.isSelected
    }
}

//MARK: Protocols

extension GaugesViewController: GaugesViewProtocol {
    
    func updateDatas(time: Int, distance: Double, maxSpeed: Double, avarageSpeed: Double, chardData: LineChartData, currentSpeed: Double, signalStatus: GPSSignalQualtyStatus) {
        averageSpeedView.updateDescription(text: "\(avarageSpeed.format(f: ".2")) \(AppManager.shared.speedUnitType)")
        maxSpeedView.updateDescription(text: "\(maxSpeed.format(f: ".2")) \(AppManager.shared.speedUnitType)")
        timeView.updateDescription(text: "\(time) \("gaugeSeconds".localized())")
        self.chart.data = chardData
        gaugeView.value = currentSpeed
        labelSignalQuality.text = signalStatus.rawValue.localized()
        switch signalStatus {
        case .noSignal, .poorSignal:
            labelSignalQuality.textColor = .red
        case .avarageSignal, .fullSignal:
            labelSignalQuality.textColor = .green
        }
    }
    
    func weatherDatas(temperature: Double, moisture: Int) {
        weatherView.updateDescription(text: "\(String(format: "%.2f", temperature)) C")
        moistureView.updateDescription(text: "% \(moisture)")
    }
}

class DetailView: UIView {
    
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let labelDescription: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    init(title: String, description: String) {
        super.init(frame: .zero)
        layout()
        setInitialText(title: title, description: description)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (maker) in
            maker.top.leading.equalToSuperview()
            maker.trailing.equalToSuperview().inset(5)
            maker.height.equalTo(20)
        }
        
        addSubview(labelDescription)
        labelDescription.snp.makeConstraints { (maker) in
            maker.top.equalTo(labelTitle.snp.bottom).offset(5)
            maker.leading.equalToSuperview().offset(5)
            maker.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setInitialText(title: String, description: String) {
        labelTitle.text = title
        labelDescription.text = description
    }
    
    func updateDescription(text: String) {
        labelDescription.text = text
    }
}
