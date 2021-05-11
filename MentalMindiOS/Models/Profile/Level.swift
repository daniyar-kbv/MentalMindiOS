//
//  Level.swift
//  MentalMindiOS
//
//  Created by Daniyar on 14.12.2020.
//

import Foundation

class MyLevelResponse: Response {
    var data: Level?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case data, error
    }
}

class Level: NSObject, Codable, NSCoding {
    var id: Int?
    var name: String?
    var label: String?
    var listenedMinutes: Int?
    var daysWithUs: Int?
    var fileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, label
        case listenedMinutes = "listened_minutes"
        case daysWithUs = "days_with_us"
        case fileImage = "file_image"
    }
    
    init(id: Int?, name: String?, label: String?, listenedMinutes: Int?, daysWithUs: Int?, fileImage: String?) {
        self.id = id
        self.name = name
        self.label = label
        self.listenedMinutes = listenedMinutes
        self.daysWithUs = daysWithUs
        self.fileImage = fileImage
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as? Int
        let name = aDecoder.decodeObject(forKey: "name") as? String
        let label = aDecoder.decodeObject(forKey: "label") as? String
        let listenedMinutes = aDecoder.decodeObject(forKey: "listenedMinutes") as? Int
        let daysWithUs = aDecoder.decodeObject(forKey: "daysWithUs") as? Int
        let fileImage = aDecoder.decodeObject(forKey: "fileImage") as? String
        self.init(id: id, name: name, label: label, listenedMinutes: listenedMinutes, daysWithUs: daysWithUs, fileImage: fileImage)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(label, forKey: "label")
        aCoder.encode(listenedMinutes, forKey: "listenedMinutes")
        aCoder.encode(daysWithUs, forKey: "daysWithUs")
        aCoder.encode(fileImage, forKey: "fileImage")
    }
}

class LevelsResponse: Response {
    var data: LevelsData?
    var error: String?
    
    enum CoingKeys: String, CodingKey {
        case data, error
    }
}


class LevelsData: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Level]?
    
    enum CoingKeys: String, CodingKey {
        case count, next, previous, results
    }
}
