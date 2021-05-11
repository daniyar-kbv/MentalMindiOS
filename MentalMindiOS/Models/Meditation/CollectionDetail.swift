//
//  CollectionDetail.swift
//  MentalMindiOS
//
//  Created by Daniyar on 07.12.2020.
//

import Foundation

class MeditationDetail: NSObject, Codable, NSCoding {
    var id: Int?
    var name: String?
    var description_: String?
    var isFavorite: Bool?
    var duration: Int?
    var fileMaleVoice: String?
    var fileFemaleVoice: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, duration
        case description_ = "description"
        case isFavorite = "is_favorite"
        case fileMaleVoice = "file_male_voice"
        case fileFemaleVoice = "file_female_voice"
    }
    
    init(id: Int?, name: String?, description_: String?, isFavorite: Bool?, duration: Int?, fileMaleVoice: String?, fileFemaleVoice: String?) {
        self.id = id
        self.name = name
        self.description_ = description_
        self.fileMaleVoice = fileMaleVoice
        self.fileFemaleVoice = fileFemaleVoice
        self.isFavorite = isFavorite
        self.duration = duration
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as? Int
        let name = aDecoder.decodeObject(forKey: "name") as? String
        let description_ = aDecoder.decodeObject(forKey: "description_") as? String
        let isFavorite = aDecoder.decodeObject(forKey: "isFavorite") as? Bool
        let duration = aDecoder.decodeObject(forKey: "duration") as? Int
        let fileMaleVoice = aDecoder.decodeObject(forKey: "fileMaleVoice") as? String
        let fileFemaleVoice = aDecoder.decodeObject(forKey: "fileFemaleVoice") as? String
        self.init(id: id, name: name, description_: description_, isFavorite: isFavorite, duration: duration, fileMaleVoice: fileMaleVoice, fileFemaleVoice: fileFemaleVoice)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(description_, forKey: "description_")
        aCoder.encode(isFavorite, forKey: "isFavorite")
        aCoder.encode(duration, forKey: "duration")
        aCoder.encode(fileMaleVoice, forKey: "fileMaleVoice")
        aCoder.encode(fileFemaleVoice, forKey: "fileFemaleVoice")
    }
}

struct CollectionDetail: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var type: String?
    var fileImage: String?
    var forFeeling: [String?]?
    var tags: [String?]?
    var meditations: [MeditationDetail]?
    var challenges: [String?]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, type, tags, meditations, challenges
        case fileImage = "file_image"
        case forFeeling = "for_feeling"
    }
}

class CollectionDetailResponse: Response {
    var data: CollectionDetail?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case data, error
    }
}
