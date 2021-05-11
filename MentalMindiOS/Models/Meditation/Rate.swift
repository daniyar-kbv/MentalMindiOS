//
//  Rate.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11.12.2020.
//

import Foundation

class RateMeditationResponse: Response {
    var data: RateMeditationData?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case data, error
    }
}

class RateMeditationData: Codable {
    var star: Int?
    var meditation: Int?
    
    enum CodingKeys: String, CodingKey {
        case star, meditation
    }
}
