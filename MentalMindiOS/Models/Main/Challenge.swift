//
//  Challenge.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/1/20.
//

import Foundation

class ChallengesResponse: Response {
    var data: ChallengesData?
    var error: String?
    
    enum CoingKeys: String, CodingKey {
        case data, error
    }
}

class ChallengesData: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Challenge]?
    
    enum CoingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

class Challenge: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var fileImage: String?
    var dateBegin: String?
    var dateEnd: String?
    var collections: [String?]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, collections
        case fileImage = "file_image"
        case dateBegin = "date_begin"
        case dateEnd = "date_end"
    }
}

class ChallengeDetailResponse: Response {
    var data: ChallengeDetail?
    var error: String?
    
    enum CoingKeys: String, CodingKey {
        case data, error
    }
}

class ChallengeDetail: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var fileImage: String?
    var dateBegin: String?
    var dateEnd: String?
    var collections: [Collection]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, collections
        case fileImage = "file_image"
        case dateBegin = "date_begin"
        case dateEnd = "date_end"
    }
}
