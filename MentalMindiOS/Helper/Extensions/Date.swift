//
//  Date.swift
//  GOALSTER
//
//  Created by Daniyar on 8/16/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

extension Date {
    var weekday: Int {
        let weekday = Calendar.current.component(.weekday, from: self)
        if weekday != 1 {
            return weekday - 1
        } else {
            return 7
        }
    }
    
    func format(format: String = "dd-MM-yyyy") -> String {
        let dateFormatterOut = DateFormatter()
        dateFormatterOut.timeZone = TimeZone.current
        dateFormatterOut.dateFormat = format
        return dateFormatterOut.string(from: self)
    }
    
    func convertToTimeZone(initTimeZone: TimeZone = TimeZone(secondsFromGMT: 0)!, timeZone: TimeZone = TimeZone.current) -> Date {
         let delta = TimeInterval(timeZone.secondsFromGMT(for: self) - initTimeZone.secondsFromGMT(for: self))
         return addingTimeInterval(delta)
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var startOfMonth: Date {

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)

        return  calendar.date(from: components)!
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }

    func isMonday() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday == 2
    }
}
