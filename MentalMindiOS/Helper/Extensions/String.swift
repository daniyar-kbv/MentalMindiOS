//
//  String.swift
//  Samokat
//
//  Created by Daniyar on 7/8/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

extension String {
    internal func format(mask: String = "+X XXX XXX XX XX") -> String {
        let cleanPhoneNumber = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    internal func changeSubstringFont(lastElement: String, font: UIFont) -> NSAttributedString{
        let firstIndex = self.index(self.startIndex, offsetBy: 12)
        let lastIndex = self.range(of: lastElement)
        let substring = self[firstIndex...lastIndex!.lowerBound]
        return self.substringFont(substring: String(substring), changedFont: font)
    }
    
    internal func substringFont(substring: String, changedFont: UIFont) -> NSAttributedString{
        let longestWord = substring
        let longestWordRange = (self as NSString).range(of: longestWord)
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.setAttributes([NSAttributedString.Key.font: changedFont], range: longestWordRange)
        return attributedString
    }
    
    internal func formatDateTime(inputFormat: String = "yyyy-MM-dd'T'HH:mm:ss", outputFormat: String) -> String{
        let dateFormatterIn = DateFormatter()
        dateFormatterIn.dateFormat = inputFormat
        let dateFormatterOut = DateFormatter()
        dateFormatterOut.dateFormat = outputFormat
        if let date = dateFormatterIn.date(from: self) {
            return dateFormatterOut.string(from: date)
        } else {
            return ""
        }
    }
    
    var localized: String {
        get {
            let language: Language = ModuleUserDefaults.getLanguage()
            
            let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj")
            let bundle = Bundle(path: path!)
            
            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        }
    }
    
    var kz: String {
        get {
            let path = Bundle.main.path(forResource: Language.kz.rawValue, ofType: "lproj")
            let bundle = Bundle(path: path!)
            
            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        }
    }
    
    var ru: String {
        get {
            let path = Bundle.main.path(forResource: Language.ru.rawValue, ofType: "lproj")
            let bundle = Bundle(path: path!)
            
            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        }
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func toDate(format: String = "dd-MM-yyyy") -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func underline(substring: String) -> NSMutableAttributedString {
        let range = (self as NSString).range(of: substring)
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSNumber(value: 1), range: range)
        return attributedString
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
    
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)!
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from!),
                       length: utf16.distance(from: from!, to: to))
    }
}
