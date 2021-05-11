//
//  Course.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/1/20.
//

import Foundation

class CoursesResponse: Response {
    var data: CoursesData?
    var error: String?
    
    enum CoingKeys: String, CodingKey {
        case data, error
    }
}

class CoursesData: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Course]?
    
    enum CoingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

class Course: Codable {
    var id: Int?
    var name: String?
    var url: String?
    var fileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, url
        case fileImage = "file_image"
    }
}
