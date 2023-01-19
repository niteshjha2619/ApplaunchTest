//
//  OTPViewModel.swift
//  NetworkManager
//
//  Created by Creative Kids on 07/08/21.
//

import Foundation
import UIKit

@objc protocol OTPViewModelDelegate {
    func requestSent(isVerified: Bool, otp:String)
}

class OTPViewModel: NSObject {
    weak var delegate: OTPViewModelDelegate?
    var textFieldsOTP: [UITextField] = []
    
    func configure(textFields: [UITextField]) {
        self.textFieldsOTP = textFields
        self.textFieldsOTP.forEach { $0.delegate = self}
    }
    
    func confirmOTP() {
        let validates = self.validateFields()
        if validates.isValid {
            self.sendOTP(otp: validates.otp)
        }
    }
    
    
    private func validateFields() -> (isValid: Bool, otp: String) {
        let texts = self.textFieldsOTP.map { String.getString($0.text)}
        
        if !(texts.filter{ $0.isEmpty }).isEmpty {
            showAlertMessage.alert(message: "Please enter the verification code.")
            return (isValid: false, otp: "")
        } else {
            
            let otp = texts.reduce(into: "", { return $0 = $0 + $1 })
            return (isValid: true, otp: otp)
            
        }
    }
    
    private func clearFields() {
        self.textFieldsOTP.forEach { $0.text = ""}
    }
    
    deinit {
        print("deinit")
        self.textFieldsOTP = []
    }
}


extension OTPViewModel: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let texts = self.textFieldsOTP.map { String.getString($0.text)}
        var shouldBegin    = false
        shouldBegin = (texts[0 ..< textField.tag].filter { $0.isEmpty }).isEmpty
        if shouldBegin {
            textField.text  = " "
        }
        return shouldBegin
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField.tag < self.textFieldsOTP.count else {return false}
        if string.isBackspace() {
            return self.backSpaceAction(forTextField: textField)
        } else {
            textField.text  = string
            switch textField.tag {
            case textFieldsOTP.count - 1:
                textField.resignFirstResponder()
                return true
            case let value where value < textFieldsOTP.count:
                textFieldsOTP[value + 1].becomeFirstResponder()
                return true
            default:
                return true
            }
        }
    }
    
    func backSpaceAction(forTextField textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            textField.text = " "
            return false
        case let value where value < textFieldsOTP.count:
            textField.text = " "
            textFieldsOTP[value - 1].becomeFirstResponder()
            return false
        default:
            return true
        }
        
    }
}


//MARK:- API Integration
extension OTPViewModel {
    func sendOTP(otp: String) {
        self.delegate?.requestSent(isVerified: true, otp:otp)
    }
}

extension String {
    func isBackspace() -> Bool {
        if let char = self.cString(using: String.Encoding.utf8) {
            return strcmp(char, "\\b") == -92
        } else {
            return false
        }
    }
}

