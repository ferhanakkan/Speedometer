//
//  GForcePresenter.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 10.01.2021.
//

import Foundation

struct XYZValue {
    var x: Double
    var y: Double
    var z: Double
}

class GForcePresenter: NSObject {
    
    var view: GForceViewProtocol!
    var interactor: GForceInteractorInputProtocol!
    var router: GForceRouterProtocol!
    
    private var arrayOfGPower: [Double] = []
    private var maxGPower: Double = 0
    private var xyzValue: XYZValue = XYZValue(x: 0, y: 0, z: 0)
    
    override init() {
        super.init()

    }
    
    private func calculateMaxG() {
        if arrayOfGPower.isEmpty {
            maxGPower = 0
        } else {
            maxGPower = arrayOfGPower.max() ?? 0
        }
    }
    
    private func calculateCurrentG() -> Double {
        let powX = pow(xyzValue.x, 2)
        let powY = pow(xyzValue.y, 2)
        let powZ = pow(xyzValue.z, 2)
        
        let total = (powX + powY + powZ).squareRoot()
        arrayOfGPower.append(total)
        return total
    }
}

extension GForcePresenter: GForcePresenterProtocol {
    func viewWillAppear() {
        interactor.getGForces()
    }

    func resetDatas() {
        arrayOfGPower.removeAll()
        view.updateDatas(x: 0, y: 0, z: 0, calculatedGForece: 0, maxGPower: 0)
        xyzValue = XYZValue(x: 0, y: 0, z: 0)
    }
}

extension GForcePresenter: GForceInteractorOutputProtocol {
    func collectedGForece(x: Double, y: Double, z: Double) {
        xyzValue = XYZValue(x: x, y: y, z: x)
        let currentG = calculateCurrentG()
        calculateMaxG()
        view.updateDatas(x: x, y: y, z: z, calculatedGForece: currentG, maxGPower: maxGPower)
    }
}
