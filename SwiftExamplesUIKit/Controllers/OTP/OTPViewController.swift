//
//  OTPViewController.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 15/04/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController {
    
    @IBOutlet weak var otpTextFieldOne: SingleDigitField!
    @IBOutlet weak var otpTextFieldTwo: SingleDigitField!
    @IBOutlet weak var otpTextFieldThree: SingleDigitField!
    @IBOutlet weak var otpTextFieldFour: SingleDigitField!
    @IBOutlet weak var otpTextFieldFive: SingleDigitField!
    @IBOutlet weak var otpTextFieldSix: SingleDigitField!
    @IBOutlet weak var resendNowButton: UIButton!
    @IBOutlet weak var resendCodeLabel: UILabel!
    
    private var countOTP: Int = 60
    private var timerOTP: Timer?
    
    private enum ResendLoopSchedule: Int {
        case oneMinute = 59
        case twoMinute = 119
        case fiveMinute = 299
        case restSettings = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfig()
    }
    
    @IBAction func resendNowButtonClick(_ sender: UIButton) {
        print("resend otp called")
    }
    
    @IBAction func verifyButtonClick(_ sender: UIButton) {
        
        guard !otpTextFieldOne.text.isNilOrEmpty,
              !otpTextFieldTwo.text.isNilOrEmpty,
              !otpTextFieldThree.text.isNilOrEmpty,
              !otpTextFieldFour.text.isNilOrEmpty,
              !otpTextFieldFive.text.isNilOrEmpty,
              !otpTextFieldSix.text.isNilOrEmpty
              else {
            self.showAlertWithOk(with: ValidationMessage.emptyOTP.text)
            return
        }
        
        print("Call api")
    }
    
    
    func setupConfig() {
        otpTextFieldConfig()
        setupUIConfig()
    }
    
    func setupUIConfig() {
        resendCodeLabel.font = .systemFont(ofSize: 16, weight: .medium)
        resendNowButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        resendNowButtonToggleConfig(isResendShow: false)
    }
    
    func resendNowButtonToggleConfig(isResendShow: Bool) {
        resendNowButton.isHidden = !isResendShow
        resendCodeLabel.isHidden = isResendShow
    }
    
    func otpTextFieldConfig() {
        [
            otpTextFieldOne,
            otpTextFieldTwo,
            otpTextFieldThree,
            otpTextFieldFour,
            otpTextFieldFive,
            otpTextFieldSix,
        ].forEach {
            $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
            $0?.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        }
        
        otpTextFieldOne.becomeFirstResponder()
        
        notificationCenterConfig()
        
    }
    
    func notificationCenterConfig() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        startTimer()
    }
    
    private func startTimer(with loopSchedule: ResendLoopSchedule = .oneMinute) {
        countOTP = loopSchedule.rawValue
        
        timerOTP = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] completionTimer in
            guard let self else { return }
            if self.countOTP > 0 {
                self.countOTP -= 1
                self.resendCodeLabelConfig()
            } else {
                completionTimer.invalidate()
                self.stopTimer()
                self.resendNowButtonToggleConfig(isResendShow: true)
            }
        })
    }
    
    func resendCodeLabelConfig() {
        resendCodeLabel.text = "Resend code in : \(countOTP)"
    }
    
    func stopTimer() {
        timerOTP?.invalidate()
        timerOTP = nil
        countOTP = ResendLoopSchedule.restSettings.rawValue
    }
    
    @objc private func keyboardWillHide() {
        updateBGColor(for: otpTextFieldSix, isResetEverything: true)
    }
    
    @objc func editingDidBegin(_ textField: UITextField) {
        updateBGColor(for: textField)
    }
    
    @objc func editingChanged(_ textField: SingleDigitField) {
        
        // Handle delete (backspace)
        if textField.pressedDelete {
            textField.pressedDelete = false
            
            if textField.text?.isEmpty == true {
                moveToPreviousField(from: textField)
            }
            return
        }
        
        // Allow only 1 digit
        guard let text = textField.text,
              text.count == 1,
              text.last?.isWholeNumber == true else {
            textField.text = ""
            return
        }
        
        moveToNextField(from: textField)
    }
    
    private func moveToNextField(from textField: UITextField) {
        switch textField {
        case otpTextFieldOne:
            otpTextFieldTwo.becomeFirstResponder()
            updateBGColor(for: otpTextFieldTwo)
        case otpTextFieldTwo:
            otpTextFieldThree.becomeFirstResponder()
            updateBGColor(for: otpTextFieldThree)
        case otpTextFieldThree:
            otpTextFieldFour.becomeFirstResponder()
            updateBGColor(for: otpTextFieldFour)
        case otpTextFieldFour:
            otpTextFieldFive.becomeFirstResponder()
            updateBGColor(for: otpTextFieldFive)
        case otpTextFieldFive:
            otpTextFieldSix.becomeFirstResponder()
            updateBGColor(for: otpTextFieldSix)
        case otpTextFieldSix:
            otpTextFieldSix.resignFirstResponder()
        default:
            break
        }
    }
    
    private func moveToPreviousField(from textField: UITextField) {
        switch textField {
         case otpTextFieldTwo:
            otpTextFieldOne.becomeFirstResponder()
            otpTextFieldOne.text = ""
        case otpTextFieldThree:
            otpTextFieldTwo.becomeFirstResponder()
            otpTextFieldTwo.text = ""
        case otpTextFieldFour:
            otpTextFieldThree.becomeFirstResponder()
            otpTextFieldThree.text = ""
        case otpTextFieldFive:
            otpTextFieldFour.becomeFirstResponder()
            otpTextFieldFour.text = ""
        case otpTextFieldSix:
            otpTextFieldFive.becomeFirstResponder()
            otpTextFieldFive.text = ""
        default:
            break
        }
    }
    
    private func updateBGColor(for activeTextField: UITextField, isResetEverything: Bool = false) {
        let allFields = [
            otpTextFieldOne,
            otpTextFieldTwo,
            otpTextFieldThree,
            otpTextFieldFour,
            otpTextFieldFive,
            otpTextFieldSix
        ]
        
        if isResetEverything {
            allFields.forEach { field in
                if let bgView = field?.superview as? OTPBackgroundView {
                    bgView.layer.borderColor = UIColor.white.cgColor
                }
            }
        }else {
            allFields.forEach { field in
                if let bgView = field?.superview as? OTPBackgroundView {
                    bgView.layer.borderColor = (field == activeTextField) ? UIColor.yellow.cgColor : UIColor.white.cgColor
                }
            }
        }
    }
}
