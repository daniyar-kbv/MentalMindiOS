//
//  History.swift
//  MentalMindiOS
//
//  Created by Dan on 12/22/20.
//

import Foundation

class SendHistoryResponse: Response {
    var data: SendHistoryData?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case data, error
    }
}

class SendHistoryData: Codable {
    var meditation: Int?
    var listenedSeconds: Int?
    
    enum CodingKeys: String, CodingKey {
        case meditation
        case listenedSeconds = "listened_seconds"
    }
}

class GetHistoryResponse: Response {
    var data: GetHistoryData?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case data, error
    }
}

class GetHistoryData: Codable{
    var count: Int?
    var next: String?
    var previous: String?
    var results: [HistoryRecord]?
    
    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

class HistoryRecord: Codable {
    var meditation: String?
    
    enum CodingKeys: String, CodingKey {
        case meditation
    }
}
