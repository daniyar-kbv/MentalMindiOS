//
//  Tags.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/2/20.
//

import Foundation

class TagsResponse: Response {
    var data: TagsData?
    var error: String?
    
    enum CoingKeys: String, CodingKey {
        case data, error
    }
}

class TagsData: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Tag]?
    
    enum CoingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

class Tag: Codable {
    var id: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
