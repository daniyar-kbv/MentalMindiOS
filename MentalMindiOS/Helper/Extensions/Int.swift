//
//  Int.swift
//  Samokat
//
//  Created by Daniyar on 7/8/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

extension Int {
    internal func toTime() -> String{
        let minutes = self / 60
        let seconds = self % 60
        return "\(minutes > 9 ? "\(minutes)" : "0\(minutes)"):\(seconds > 9 ? "\(seconds)" : "0\(seconds)")"
    }
    
    func toTime(resultCase: Case = .nominitive, timeType: TimeType) -> String {
        var time = ""
        switch resultCase {
        case .nominitive:
            switch Int(String(String(self).last!)) {
            case 0, 5, 6, 7, 8, 9:
                switch timeType {
                case .days:
                    time = "дней".localized
                case .minutes:
                    time = "минут".localized
                }
            case 1:
                switch timeType {
                case .days:
                    time = "день".localized
                case .minutes:
                    time = "минута".localized
                }
            case 2, 3, 4:
                switch timeType {
                case .days:
                    time = "дня".localized
                case .minutes:
                    time = "минуты".localized
                }
            default:
                break
            }
        case .genetive:
            switch Int(String(String(self).last!)) {
            case 0, 2, 3, 4, 5, 6, 7, 8, 9:
                switch timeType {
                case .days:
                    time = "дней".localized
                case .minutes:
                    time = "минут".localized
                }
            case 1:
                switch timeType {
                case .days:
                    time = "дня".localized
                case .minutes:
                    time = "минуты".localized
                }
            default:
                break
            }
        }
        return "\(self) \(time)"
    }
}
