//
//  Regex.swift
//  NetworkManager
//
//  Created by Creative Kids on 07/08/21.
//

import Foundation

extension String {
    //To Check Whether Email is valid
    func isEmail() -> Bool {
        let emailRegex = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,4})$" as String
        let emailText = NSPredicate(format: "SELF MATCHES %@",emailRegex)
        let isValid  = emailText.evaluate(with: self) as Bool
        return isValid
    }
    // To Check Whether name is valid
    func isValidName() -> Bool {
        //self.trim
        let replaced = self.replacingOccurrences(of: "", with: "")
        let RegEx = "^[([A-Za-z]+[\\s]*[A-Za-z]*)+]{1,30}$"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: replaced)
    }
    
    // To Check Whether Email is valid
    func isValidString() -> Bool {
        if self == "<null>" || self == "(null)" {
            return false
        }
        return true
    }
    
    func isValidPassword(text: String) -> Bool {
        
        let letters = CharacterSet.letters
        
        let phrase = text
        let range = phrase.rangeOfCharacter(from: letters)
        
        // range will be nil if no letters is found
        if range != nil {
            return false
        }
        else {
            return true
        }
    }
    
    // To Check Whether Phone Number is valid
    
    func isPhoneNumber() -> Bool {
        if self.isStringEmpty() {
            return false
        }
        let phoneRegex = "^\\d{8,15}$"
        let phoneText = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let isValid = phoneText.evaluate(with: self) as Bool
        return isValid
    }
    
    func isNumber() -> Bool {
        if self.isStringEmpty() {
            return false
        }
        let phoneRegex = "^\\d{1,15}$"
        let phoneText = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let isValid = phoneText.evaluate(with: self) as Bool
        return isValid
    }
    // Password_Validation
    
    func isPasswordValidate() -> Bool {
        let passwordRegix = "[A-Za-z0-9.@#$%*?:!+-/]{8,25}"
        let passwordText  = NSPredicate(format:"SELF MATCHES %@",passwordRegix)
        
        return passwordText.evaluate(with:self)
    }
}
