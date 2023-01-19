//
//  Double.swift
//  NetworkManager
//
//  Created by Creative Kids on 07/08/21.
//

import Foundation

extension Double {
    static func getDouble(_ value: Any?) -> Double {
        guard let doubleValue = value as? Double else {
            let strDouble = String.getString(value)
            guard let doubleValueOfString = Double(strDouble) else {
                return 0.0
            }
            return doubleValueOfString
        }
        return doubleValue
    }
}
extension Double {
    
    func splitIntoParts(decimalPlaces: Int, round: Bool) -> (leftPart: Int, rightPart: Int) {
        
        var number = self
        if round {
            //round to specified number of decimal places:
            let divisor = pow(10.0, Double(decimalPlaces))
            number = Darwin.round(self * divisor) / divisor
        }
        
        //convert to string and split on decimal point:
        let parts = String(number).components(separatedBy: ".")
        
        //extract left and right parts:
        let leftPart = Int(parts[0]) ?? 0
        let rightPart = Int(parts[1]) ?? 0
        
        return(leftPart, rightPart)
        
    }
}
