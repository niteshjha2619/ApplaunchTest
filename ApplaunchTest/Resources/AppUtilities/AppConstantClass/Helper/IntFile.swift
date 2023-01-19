//
//  IntFile.swift
//  NetworkManager
//
//  Created by Creative Kids on 07/08/21.
//

import Foundation
import UIKit

extension Int {
    static func getInt(_ value: Any?) -> Int {
        guard let intValue = value as? Int else {
            guard let DoubleValue = value as? Double else{
            let strInt = String.getString(value)
            guard let intValueOfString = Int(strInt) else { return 0 }
            return intValueOfString
            }
            return Int(DoubleValue)
        }
        return intValue
    }
    static func getIntValue(_ value: Any?) -> Int {
        guard let intValue = value as? Int else {
            guard let DoubleValue = value as? Double else{
            let strInt = String.getString(value)
            guard let intValueOfString = Int(strInt) else { return 101 }
            return intValueOfString
            }
            return Int(DoubleValue)
        }
        return intValue
    }

    func toCGFloat() -> CGFloat
    {
        return CGFloat(self)
    }
    
    func toBool() -> Bool
    {
        return self == 0 ? false : true
    }
    
    func toString(changeToDoubleDigit:Bool = false) -> String {
        
        let number = NSNumber(integerLiteral: self)
        let str = String(format:"%@",number).trimAll()
        
        return Localised((self < 10 && self > 0 && changeToDoubleDigit) ? "0\(str)" : str)
    }   
}

extension NSNumber {
    static func getNSNumber(message: Any?) -> NSNumber {
        guard let number = message as? NSNumber else {
            guard let strNumber = message as? String else {
                return 0
            }
            guard let intNumber = Int(strNumber) else {
                guard let doubleNumber = Double(strNumber) else {
                    return 0
                }
                return NSNumber(value: Double(doubleNumber))
            }
            return NSNumber(value: Int(intNumber))
        }
        return number
    }
    
}
