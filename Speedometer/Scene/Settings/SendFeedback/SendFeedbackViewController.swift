//
//  SendFeedbackViewController.swift
//  Speedometer
//
//  Created by Ferhan Akkan on 2.01.2021.
//

import UIKit
import SnapKit

final class SendFeedbackViewController: UIViewController {
    
    var presenter: SendFeedbackPresenterProtocol!
    
    private let labelTop: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "sendFeedbackLabel".localized()
        return label
    }()
    
    private lazy var textViewFeedback: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .left
        textView.textColor = .orange
        textView.text = "sendFeedbackTextViewPlaceHolder".localized()
        textView.textColor = UIColor.lightGray
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.borderAndCorner(radius: 8, color: .lightGray, width: 2)
        textView.delegate = self
        return textView
    }()
    
    private lazy var buttonSend: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.orange, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.setTitle("sendFeedbackSendButton".localized(), for: .normal)
        button.shadowAndCorner(cornerRadius: 25,
                               shadowRadius: 25,
                               opacity: 1, color: .firstColor,
                               width: 0,
                               height: 0)
        button.backgroundColor = .secondColor
        button.addTarget(self, action: #selector(buttonSendPressed), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        layout()
    }
}

//MARK: SetUI

extension SendFeedbackViewController {
    
    private func setNavBar() {
        title = "sendFeedbackTitle".localized()
    }
    
    private func layout() {
        view.backgroundColor = .firstColor
        
        view.addSubview(labelTop)
        labelTop.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
        }
        
        view.addSubview(textViewFeedback)
        textViewFeedback.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(labelTop.snp.bottom).offset(15)
        }
        
        view.addSubview(buttonSend)
        buttonSend.snp.makeConstraints { (make) in
            make.top.equalTo(textViewFeedback.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-15)
        }
    }
}

//MARK: TextView Delegates

extension SendFeedbackViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .orange
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "sendFeedbackTextViewPlaceHolder".localized()
            textView.textColor = UIColor.lightGray
        }
        presenter.textViewText(text: textView.text)
    }
}

//MARK: Actions

extension SendFeedbackViewController {
    
    @objc func buttonSendPressed() {
        LoadingView.show()
        presenter.buttonSendPressed()
    }
}

//MARK: Protocols 

extension SendFeedbackViewController: SendFeedbackViewProtocol {
    
    func sendFeedbackCompleted() {
        LoadingView.hide()
    }
    
    func sendButtonIsActive(isActive: Bool) {
        buttonSend.isEnabled = isActive
    }
}
