//
//  SettingsPresenter.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 1.12.2020.
//

import Foundation
import StoreKit

class SettingsPresenter {
    var view: SettingsViewProtocol!
    var interactor: SettingsInteractorInputProtocol!
    var router: SettingsRouterProtocol!
    
    
    private func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "appId") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func shareApp() {
        if let link = NSURL(string: "https://apps.apple.com/us/app/discover-city/id1497328732") {
            let objectsToShare = ["settingsShareDescription".localized() ,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            router.presentShareApp(activityVC: activityVC)
        }
    }
    
    private func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    private func showFeedbackController() {
        router.showFeedbackController()
    }
    
    private func showChangeLanguage() {
        router.showChangeLanguage()
    }
}

extension SettingsPresenter: SettingsPresenterProtocol {
    func didSelectFromTableView(indexPath: IndexPath) {
        let row = indexPath.row
        let section = indexPath.section
        
        if section == 0 {
            switch row {
            case 0:
                rateApp()
            case 1:
                showFeedbackController()
            case 2:
                shareApp()
            case 3:
                showChangeLanguage()
            case 4:
                openSettings()
            default:
                break
            }
        } else {
            switch row {
            case 0:
                print("test")
            case 1:
                print("test")
            case 2:
                print("test")
            default:
                break
            }
        }
    }
    

}

extension SettingsPresenter: SettingsInteractorOutputProtocol {

}
