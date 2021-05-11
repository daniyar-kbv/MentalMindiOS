//
//  Encodings.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import Alamofire

class Encoder {

    enum Encoding {
        case urlEncoding
        case jsonEncoding
    }

    static func getEncoding(_ encoding: Encoding) -> ParameterEncoding {
        switch encoding{
        case .jsonEncoding:
            return JSONEncoding()
        case .urlEncoding:
            return URLEncoding()
        }
    }
}


