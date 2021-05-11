//
//  Main.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/1/20.
//

import Foundation

class CollectionsResponse: Response {
    var data: CollectionsData?
    var error: String?
    
    enum CoingKeys: String, CodingKey {
        case data, error
    }
}

class CollectionsData: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Collection]?
    
    enum CoingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

class Collection: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var type: String?
    var fileImage: String?
    var forFeeling: [String?]?
    var tags: [String?]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, type, tags
        case fileImage = "file_image"
        case forFeeling = "for_feeling"
    }
}
