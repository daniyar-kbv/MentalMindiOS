//
//  Data.swift
//  GOALSTER
//
//  Created by Daniyar on 9/29/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

extension Data {
    func saveToFile(name: String) {
        let filename = getDocumentsDirectory().appendingPathComponent(name)
        try? self.write(to: filename)
    }
    
    func addImageProperties(properties: NSMutableDictionary) -> Data? {
        let dict = NSMutableDictionary()
        dict[(kCGImagePropertyGPSDictionary as String)] = properties

        if let source = CGImageSourceCreateWithData(self as CFData, nil) {
            if let uti = CGImageSourceGetType(source) {
            let destinationData = NSMutableData()
            if let destination = CGImageDestinationCreateWithData(destinationData, uti, 1, nil) {
                CGImageDestinationAddImageFromSource(destination, source, 0, dict as CFDictionary)
                    if CGImageDestinationFinalize(destination) == false {
                        return nil
                    }
                return destinationData as Data
                }
            }
        }
        return nil
    }
}
