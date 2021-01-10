//
//  GPSService.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 2.01.2021.
//

import UIKit
import CoreLocation

enum GPSSignalQualtyStatus: String {
    case noSignal = "No Signal"
    case poorSignal = "Poor Signal"
    case avarageSignal = "Average Signal"
    case fullSignal = "Full Signal"
}

class GPSService: NSObject {
    
    private var locationManager: CLLocationManager!
    var locationDatas: ((CLLocation, GPSSignalQualtyStatus)->())?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }
    
    func verifyOrAskForLocationPermission(completion: @escaping (Bool) -> ()) {
    
        switch locationAuthorizationStatus() {
        case .notDetermined:
            completion(false)
            getPermissionLocation()
        case .denied, .restricted:
            completion(false)
            showPopUp()
        case .authorized:
            completion(true)
            locationManager.startUpdatingLocation()
        case .authorizedAlways:
            completion(true)
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            completion(true)
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    private func locationAuthorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    private func getPermissionLocation() {
        locationManager.requestAlwaysAuthorization()
    }
    
    private func forwardToAppSettings() {
        DispatchQueue.main.async {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    private func showPopUp() {
        let action = UIAlertAction(title: "gpsErrorToSettings".localized(), style: .default) { _ in
            self.forwardToAppSettings()
        }
        AlertService.messagePresent(title: "gpsErrorTitle".localized(), message: "gpsErrorButton".localized(), moreButtonAction: [action])
    }

    private func checkSignalQualty(location: CLLocation) {
        if location.horizontalAccuracy < 0 {
            locationDatas!(location, GPSSignalQualtyStatus.noSignal)
        } else if location.horizontalAccuracy > 163 {
            locationDatas!(location, GPSSignalQualtyStatus.poorSignal)
        } else if location.horizontalAccuracy > 48 {
            locationDatas!(location, GPSSignalQualtyStatus.avarageSignal)
        } else {
            locationDatas!(location, GPSSignalQualtyStatus.fullSignal)
        }
    }
}

//MARK: Core Location Delegate

extension GPSService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        checkSignalQualty(location: locations.last!)
    }
}
