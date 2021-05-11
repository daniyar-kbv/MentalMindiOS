//
//  EndPointType.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import Alamofire

protocol EndPointType {
    var baseURL: URL {get}
    var path: String {get}
    var httpMethod: HTTPMethod {get}
    var header: HTTPHeaders? {get}
    var parameters: Parameters? {get}
    var encoding: Encoder.Encoding {get}
    var additionalHeaders: HTTPHeaders? {get}
    var showLoader: Bool {get}
}
