//
//  GForceInteractor.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 10.01.2021.
//

import Foundation
import CoreMotion

class GForceInteractor {
    var presenter: GForceInteractorOutputProtocol!

    private var manager = CMMotionManager()
    
    init() {
        manager.accelerometerUpdateInterval = 0.1
    }
    
    private func listenDeviceMotionUpdates() {
        manager.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
            guard let data = data else { return }
            self.presenter.collectedGForece(x: data.gravity.x, y: data.gravity.y, z: data.gravity.z)
        }
    }
}

extension GForceInteractor: GForceInteractorInputProtocol {
    func getGForces() {
        listenDeviceMotionUpdates()
    }
}
