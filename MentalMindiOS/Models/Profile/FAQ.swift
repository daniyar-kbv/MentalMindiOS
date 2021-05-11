//
//  FAQ.swift
//  MentalMindiOS
//
//  Created by Daniyar on 15.12.2020.
//

import Foundation

class FAQResponse: Response {
    var data: FAQData?
    var error: String?
    
    enum CoingKeys: String, CodingKey {
        case data, error
    }
}


class FAQData: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [FAQ]?
    
    enum CoingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

class FAQ: Codable {
    var id: Int?
    var question: String?
    var answer: String?
    
    enum CodingKeys: String, CodingKey {
        case id, question, answer
    }
}
