//
//  Password.swift
//  MentalMindiOS
//
//  Created by Dan on 12/21/20.
//

import Foundation

class SuccessResponse: Response {
    var data: SuccessData?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case data, error
    }
}

class SuccessData: Codable {
    var success: Bool?
    
    enum CodingKeys: String, CodingKey {
        case success
    }
}
