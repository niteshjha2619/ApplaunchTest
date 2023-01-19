//
//  StringFile.swift
//  NetworkManager
//
//  Created by Creative Kids on 07/08/21.
//

import Foundation
import UIKit

extension String {
    
    // To Check Whether URL is valid
    func isURL() -> Bool {
        let urlRegex = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+" as String
        let urlText = NSPredicate(format: "SELF MATCHES %@", urlRegex)
        let isValid = urlText.evaluate(with: self) as Bool
        return isValid
    }
    
    // To Check Whether Image URL is valid
    
    func isImageURL() -> Bool {
        if self.isURL() {
            if self.range(of: ".png") != nil || self.range(of: ".jpg") != nil || self.range(of: ".jpeg") != nil {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func toInt() -> Int
    {
        return Int(self) ?? 0
    }
    
    func trimAll()->String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    static func getString(_ message: Any?) -> String {
        guard let strMessage = message as? String else {
            guard let doubleValue = message as? Double else {
                guard let intValue = message as? Int else {
                    guard let int64Value = message as? Int64 else{
                        return ""
                    }
                    return String(int64Value)
                }
                return String(intValue)
            }
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 20
            formatter.minimumIntegerDigits = 1
            guard let formattedNumber = formatter.string(from: NSNumber(value: doubleValue)) else {
                return ""
            }
            return formattedNumber
        }
        return strMessage.stringByTrimmingWhiteSpaceAndNewLine()
    }
    
    static func getLength(_ message: Any?) -> Int {
        return String.getString(message).stringByTrimmingWhiteSpaceAndNewLine().count
    }
    
    static func checkForValidNumericString(_ message: AnyObject?) -> Bool {
        guard let strMessage = message as? String else {
            return true
        }
        
        if strMessage == "" || strMessage == "0" {
            return true
        }
        return false
    }
    
    
    // To Check Whether String is empty
    
    func isStringEmpty() -> Bool {
        return self.stringByTrimmingWhiteSpace().count == 0 ? true : false
    }
    
    mutating func removeSubString(subString: String) -> String {
        if self.contains(subString) {
            guard let stringRange = self.range(of: subString) else { return self }
            return self.replacingCharacters(in: stringRange, with: "")
        }
        return self
    }
    
    
    
    // Get string by removing White Space & New Line
    
    func stringByTrimmingWhiteSpaceAndNewLine() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    // Get string by removing White Space
    
    func stringByTrimmingWhiteSpace() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func getSubStringFrom(begin: NSInteger, to end: NSInteger) -> String {
        // var strRange = begin..<end
        // let str = self.substringWithRange(strRange)
        return ""
    }
    
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}
extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    subscript (r: Range<Int>) -> String {
      _ = index(startIndex, offsetBy: r.lowerBound)
      _ = index(startIndex, offsetBy: r.upperBound)
        return ""//String(self[Range(start ..< end)])
    }
    var containsAlphabets: Bool {
        // Checks if all the characters inside the string are alphabets
        let set = CharacterSet.letters
        return self.utf16.contains {
            guard let unicode = UnicodeScalar($0) else { return false }
            return set.contains(unicode)
        }
    }
}

// MARK: - NSAttributedString extensions
public extension String {
    
    /// Regular string.
    var regular: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.systemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Bold string.
    var bold: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Underlined string
    var underline: NSAttributedString {
      return NSAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    /// Strikethrough string.
    var strikethrough: NSAttributedString {
      return NSAttributedString(string: self, attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
    }
    
    /// Italic string.
    var italic: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Add color to string.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString versions of string colored with given color.
    func colored(with color: UIColor) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
    }
    func font(with font: UIFont) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: font])
    }
    static func convertDateString(dateString : String, fromFormat sourceFormat : String, toFormat desFormat : String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = sourceFormat
            let date = dateFormatter.date(from: dateString) ?? Date()
            dateFormatter.dateFormat = desFormat
            return dateFormatter.string(from: date)
        }

    
}

extension Array where Element: NSAttributedString {
    
    func joined(separator: NSAttributedString) -> NSAttributedString {
        var isFirst = true
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if isFirst {
                isFirst = false
            } else {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }
    
    func joined(separator: String) -> NSAttributedString {
        return joined(separator: NSAttributedString(string: separator))
    }
}
extension StringProtocol  {
    var digits: [Int] { compactMap(\.wholeNumberValue) }
}

