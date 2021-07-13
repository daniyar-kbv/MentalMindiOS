//
//  Meditaions.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/1/20.
//

import Foundation

class FavoriteMeditationsResponse: Response {
    var data: FavoriteMeditationsData?
    var error: String?
    
    enum CoingKeys: String, CodingKey {
        case data, error
    }
}

class FavoriteMeditationsData: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Meditation]?
    
    enum CoingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

class Meditation: NSObject, Codable, NSCoding, MeditationAudio {
    var meditationId: Int?
    var meditationName: String?
    var meditationDescription: String?
    var meditationFileMaleVoice: String?
    var meditationFileFemaleVoice: String?
    var collectionId: Int?
    var fileImage: String?
    var durationMale: Int?
    var durationFemale: Int?
    
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
            guard let voiceStr = meditationFileMaleVoice else { return URL(string: "") }
            return URL(string: voiceStr)
        case .female:
            guard let voiceStr = meditationFileFemaleVoice else { return URL(string: "") }
            return URL(string: voiceStr)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case durationMale = "duration_male"
        case durationFemale = "duration_female"
        case meditationId = "meditation_id"
        case meditationName = "meditation_name"
        case meditationDescription = "meditation_description"
        case meditationFileMaleVoice = "meditation_file_male_voice"
        case meditationFileFemaleVoice = "meditation_file_female_voice"
        case collectionId = "collection_id"
        case fileImage = "file_image"
    }
    
    init(meditationId: Int?, meditationName: String?, meditationDescription: String?, meditationFileMaleVoice: String?, meditationFileFemaleVoice: String?, collectionId: Int?, fileImage: String?, durationMale: Int?, durationFemale: Int?) {
        self.meditationId = meditationId
        self.meditationName = meditationName
        self.meditationDescription = meditationDescription
        self.meditationFileMaleVoice = meditationFileMaleVoice
        self.meditationFileFemaleVoice = meditationFileFemaleVoice
        self.collectionId = collectionId
        self.fileImage = fileImage
        self.durationMale = durationMale
        self.durationFemale = durationFemale
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let meditationId = aDecoder.decodeObject(forKey: "meditationId") as? Int
        let meditationName = aDecoder.decodeObject(forKey: "meditationName") as? String
        let meditationDescription = aDecoder.decodeObject(forKey: "meditationDescription") as? String
        let meditationFileMaleVoice = aDecoder.decodeObject(forKey: "meditationFileMaleVoice") as? String
        let meditationFileFemaleVoice = aDecoder.decodeObject(forKey: "meditationFileFemaleVoice") as? String
        let collectionId = aDecoder.decodeObject(forKey: "collectionId") as? Int
        let fileImage = aDecoder.decodeObject(forKey: "fileImage") as? String
        let durationMale = aDecoder.decodeObject(forKey: "durationMale") as? Int
        let durationFemale = aDecoder.decodeObject(forKey: "durationFemale") as? Int
        self.init(meditationId: meditationId, meditationName: meditationName, meditationDescription: meditationDescription, meditationFileMaleVoice: meditationFileMaleVoice, meditationFileFemaleVoice: meditationFileFemaleVoice, collectionId: collectionId, fileImage: fileImage, durationMale: durationMale, durationFemale: durationFemale)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(meditationId, forKey: "meditationId") 
        aCoder.encode(meditationName, forKey: "meditationName")
        aCoder.encode(meditationDescription, forKey: "meditationDescription")
        aCoder.encode(meditationFileMaleVoice, forKey: "meditationFileMaleVoice")
        aCoder.encode(meditationFileFemaleVoice, forKey: "meditationFileFemaleVoice")
        aCoder.encode(collectionId, forKey: "collectionId")
        aCoder.encode(fileImage, forKey: "fileImage")
        aCoder.encode(durationMale, forKey: "durationMale")
        aCoder.encode(durationFemale, forKey: "durationFemale")
    }
}

class MeditationDetailResponse: Response {
    var data: MeditationDetail?
    var error: String?
    
    enum CoingKeys: String, CodingKey {
        case data, error
    }
}
