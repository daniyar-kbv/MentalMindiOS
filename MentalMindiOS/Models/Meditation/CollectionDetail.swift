//
//  CollectionDetail.swift
//  MentalMindiOS
//
//  Created by Daniyar on 07.12.2020.
//

import Foundation

protocol MeditationAudio {
    var durationMale: Int? { get set }
    var durationFemale: Int? { get set }
    
    func getDuration(_ voice: VoiceTypes) -> Int
    func getVoiceURL(_ voice: VoiceTypes) -> URL?
}

class MeditationDetail: NSObject, Codable, NSCoding, MeditationAudio {
    var id: Int?
    var name: String?
    var description_: String?
    var isFavorite: Bool?
    var durationMale: Int?
    var durationFemale: Int?
    var fileMaleVoice: String?
    var fileFemaleVoice: String?
    
    func getDuration(_ voice: VoiceTypes) -> Int {
        switch voice {
        case .male:
            guard let duration = durationMale else { return 0 }
            return duration
        case .female:
            guard let duration = durationFemale else { return 0 }
            return duration
        }
    }
    
    func getVoiceURL(_ voice: VoiceTypes) -> URL? {
        switch voice {
        case .male:
            guard let voiceStr = fileMaleVoice else { return URL(string: "") }
            return URL(string: voiceStr)
        case .female:
            guard let voiceStr = fileFemaleVoice else { return URL(string: "") }
            return URL(string: voiceStr)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case durationMale = "duration_male"
        case durationFemale = "duration_female"
        case description_ = "description"
        case isFavorite = "is_favorite"
        case fileMaleVoice = "file_male_voice"
        case fileFemaleVoice = "file_female_voice"
    }
    
    init(id: Int?, name: String?, description_: String?, isFavorite: Bool?, durationMale: Int?, durationFemale: Int?, fileMaleVoice: String?, fileFemaleVoice: String?) {
        self.id = id
        self.name = name
        self.description_ = description_
        self.fileMaleVoice = fileMaleVoice
        self.fileFemaleVoice = fileFemaleVoice
        self.isFavorite = isFavorite
        self.durationMale = durationMale
        self.durationFemale = durationFemale
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as? Int
        let name = aDecoder.decodeObject(forKey: "name") as? String
        let description_ = aDecoder.decodeObject(forKey: "description_") as? String
        let isFavorite = aDecoder.decodeObject(forKey: "isFavorite") as? Bool
        let durationMale = aDecoder.decodeObject(forKey: "durationMale") as? Int
        let durationFemale = aDecoder.decodeObject(forKey: "durationFemale") as? Int
        let fileMaleVoice = aDecoder.decodeObject(forKey: "fileMaleVoice") as? String
        let fileFemaleVoice = aDecoder.decodeObject(forKey: "fileFemaleVoice") as? String
        self.init(id: id, name: name, description_: description_, isFavorite: isFavorite, durationMale: durationMale, durationFemale: durationFemale, fileMaleVoice: fileMaleVoice, fileFemaleVoice: fileFemaleVoice)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(description_, forKey: "description_")
        aCoder.encode(isFavorite, forKey: "isFavorite")
        aCoder.encode(durationMale, forKey: "durationMale")
        aCoder.encode(durationFemale, forKey: "durationFemale")
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
