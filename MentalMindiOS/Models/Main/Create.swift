//
//  Create.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/3/20.
//

import Foundation

class TypesResponse: Response {
    var data: TypesData?
    var error: String?
    
    enum CoingKeys: String, CodingKey {
        case data, error
    }
}

class TypesData: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Type]?
    
    enum CoingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

class Type: Codable {
    var id: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

class AffirmationsResponse: Response {
    var data: AffirmationsData?
    var error: String?
    
    enum CoingKeys: String, CodingKey {
        case data, error
    }
}

class AffirmationsData: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Affirmation]?
    
    enum CoingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

class Affirmation: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var fileImage: String?
    var date: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, date
        case fileImage = "file_image"
    }
}

class AffirmationDetailResponse: Response {
    var data: Affirmation?
    var error: String?
    
    enum CoingKeys: String, CodingKey {
        case data, error
    }
}
