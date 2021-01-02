//
//  SettingsPresenter.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 1.12.2020.
//

import Foundation
import StoreKit

class SettingsPresenter: NSObject {
    var view: SettingsViewProtocol!
    var interactor: SettingsInteractorInputProtocol!
    var router: SettingsRouterProtocol!
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    
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
                buyPremiumQuotes(productID: "com.ferhanakkan.Cargram.Coffee2")
            case 1:
                buyPremiumQuotes(productID: "com.ferhanakkan.Cargram.Coffee2")
            case 2:
                buyPremiumQuotes(productID: "com.ferhanakkan.Cargram.Coffee2")
            default:
                break
            }
        }
    }
    

}

//MARK: StoreKit

extension SettingsPresenter: SKPaymentTransactionObserver {
    
    func buyPremiumQuotes(productID: String) {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
            
        } else {
            LoadingView.hide()
            AlertService.messagePresent(title: "settingsDonationErrorTitle".localized(),
                                        message: "settingsDonationErrorDescription".localized(),
                                        moreButtonAction: nil)
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        LoadingView.hide()
        for transaction in transactions {
            switch  transaction.transactionState {
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                AlertService.messagePresent(title: "settingsDonationSuccessTitle".localized(),
                                            message: "settingsDonationSuccessDescription".localized(),
                                            moreButtonAction: nil)
            case .failed:
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    AlertService.messagePresent(title: "settingsDonationErrorTitle".localized(),
                                                message: errorDescription,
                                                moreButtonAction: nil)
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                break
            }
        }
    }
    
    func checkPreviousPurchase(_ sender: UIBarButtonItem) {
        /////DİD BUY BEFORE Anything check For next versions
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

extension SettingsPresenter: SettingsInteractorOutputProtocol {
    
}
