//
//  Feelings.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/1/20.
//

import Foundation

class FeelingsResponse: Response {
    var data: FeelingsData?
    var error: String?
    
    enum CoingKeys: String, CodingKey {
        case data, error
    }
}

class FeelingsData: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Feeling]?
    
    enum CoingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

class Feeling: Codable {
    var id: Int?
    var name: String?
    
    enum CoingKeys: String, CodingKey {
        case id, name
    }
}

//    init(id: Int? ) {
//    }
//
//    required convenience init(coder aDecoder: NSCoder) {
//        let time = aDecoder.decodeObject(forKey: "time") as? LessonTime
//        self.init(time: time, image: image, name: name, courseId: courseId)
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(time, forKey: "time")
//    }
