//
//  AccelerationViewController.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 9.01.2021.
//

import UIKit
import SnapKit
import Charts
import LMGaugeViewSwift

final class AccelerationViewController: UIViewController {
    
    var presenter: AccelerationPresenterProtocol!
    
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
        label.text = "accelerationSignalQuality".localized()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
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
        return chart
    }()
    
    private let labelSpeed: UILabel = {
        let label = UILabel()
        label.text = "\("accelerationSpeed".localized()): 0 KM/H"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 40)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let weatherView: DetailView = {
        let weatherView = DetailView(title: "accelerationWeatherStatus".localized(), description: "")
        return weatherView
    }()
    
    private let moistureView: DetailView = {
        let moistureView = DetailView(title: "accelerationMoisture".localized(), description: "")
        return moistureView
    }()
    
    private let timeView: DetailView = {
        let timeView = DetailView(title: "accelerationTime".localized(), description: "")
        return timeView
    }()
    
    private let maxSpeedView: DetailView = {
        let maxSpeedView = DetailView(title: "accelerationMaxSpeed".localized(), description: "")
        return maxSpeedView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

//MARK: SetUI

extension AccelerationViewController {
    
    private func setNavBar() {
        self.navigationController?.navigationBar.tintColor = .textColor
        self.navigationController?.navigationBar.barTintColor = .firstColor
        self.tabBarController?.tabBar.tintColor = .textColor
        self.tabBarController?.tabBar.barTintColor = .firstColor
        navigationItem.rightBarButtonItem = buttonReset
        title = "accelerationTitle".localized()
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
        
        view.addSubview(labelSpeed)
        labelSpeed.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().inset(20)
            maker.top.equalTo(self.chart.snp.bottom).offset(5)
        }
        
        view.addSubview(timeView)
        timeView.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            maker.height.equalTo(40)
            maker.leading.equalToSuperview().offset(30)
        }
        
        view.addSubview(maxSpeedView)
        maxSpeedView.snp.makeConstraints { (maker) in
            maker.trailing.equalToSuperview().inset(30)
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            maker.height.equalTo(40)
            maker.leading.equalTo(timeView.snp.trailing).offset(20)
            maker.width.equalTo(timeView)
        }
        
        view.addSubview(weatherView)
        weatherView.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(30)
            maker.bottom.equalTo(timeView.snp.top).offset(-20)
            maker.height.equalTo(40)
        }
        
        view.addSubview(moistureView)
        moistureView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.labelSpeed.snp.bottom).offset(5)
            maker.trailing.equalToSuperview().inset(30)
            maker.bottom.equalTo(timeView.snp.top).offset(-20)
            maker.height.equalTo(40)
            maker.leading.equalTo(weatherView.snp.trailing).offset(20)
            maker.width.equalTo(weatherView.snp.width)
        }
    }
}

//MARK: Actions

extension AccelerationViewController {
    
    @objc private func buttonResetPressed() {
        presenter.resetDatas()
    }
}

//MARK: Protocols

extension AccelerationViewController: AccelerationViewProtocol {
    
    func updateDatas(time: Int, maxSpeed: Double, chardData: LineChartData, signalStatus: GPSSignalQualtyStatus, currentSpeed: Double) {
        timeView.updateDescription(text: "\(time) \("accelerationSeconds".localized())")
        maxSpeedView.updateDescription(text: "\(maxSpeed.format(f: ".3")) \(AppManager.shared.speedUnitType)")
        self.chart.data = chardData
        labelSpeed.text = "\(currentSpeed.format(f: ".3")) \(AppManager.shared.speedUnitType) "
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
