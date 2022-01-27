//
//  AppConfiguration.swift
//  MentalMindiOS
//
//  Created by Dan on 6/14/21.
//

import Foundation

enum AppConfiguration: String {
    case Debug
    case TestFlight
    case AppStore
}

struct Config {
    private static let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"

    static var isDebug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }

    static var appConfiguration: AppConfiguration {
        if isDebug {
            return .Debug
        } else if isTestFlight {
            return .TestFlight
        } else {
            return .AppStore
        }
    }
    
    static var isDevelopment: Bool {
        return [.Debug, .TestFlight].contains(appConfiguration)
    }
}
