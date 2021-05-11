//
//  Bundle.swift
//  Samokat
//
//  Created by Daniyar on 7/30/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    func getPlistData(name: String) -> NSDictionary? {
        guard let path = Bundle.main.path(forResource: name, ofType: "plist"), let dic = NSDictionary(contentsOfFile: path) else { return nil }
        return dic
    }
    
    func getValueFromPlist(key: String, plistName: String) -> Any? {
        return getPlistData(name: plistName)?.value(forKey: key)
    }
    
    func getSecret(key: String) -> Any? {
        return getValueFromPlist(key: key, plistName: "Secrets")
    }
}
