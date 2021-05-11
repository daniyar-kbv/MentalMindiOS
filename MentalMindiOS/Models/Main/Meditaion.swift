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

class Meditation: NSObject, Codable, NSCoding {
    var meditationId: Int?
    var meditationName: String?
    var meditationDescription: String?
    var meditationFileMaleVoice: String?
    var meditationFileFemaleVoice: String?
    var collectionId: Int?
    var fileImage: String?
    var duration: Int?
    
    enum CodingKeys: String, CodingKey {
        case duration
        case meditationId = "meditation_id"
        case meditationName = "meditation_name"
        case meditationDescription = "meditation_description"
        case meditationFileMaleVoice = "meditation_file_male_voice"
        case meditationFileFemaleVoice = "meditation_file_female_voice"
        case collectionId = "collection_id"
        case fileImage = "file_image"
    }
    
    init(meditationId: Int?, meditationName: String?, meditationDescription: String?, meditationFileMaleVoice: String?, meditationFileFemaleVoice: String?, collectionId: Int?, fileImage: String?, duration: Int?) {
        self.meditationId = meditationId
        self.meditationName = meditationName
        self.meditationDescription = meditationDescription
        self.meditationFileMaleVoice = meditationFileMaleVoice
        self.meditationFileFemaleVoice = meditationFileFemaleVoice
        self.collectionId = collectionId
        self.fileImage = fileImage
        self.duration = duration
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let meditationId = aDecoder.decodeObject(forKey: "meditationId") as? Int
        let meditationName = aDecoder.decodeObject(forKey: "meditationName") as? String
        let meditationDescription = aDecoder.decodeObject(forKey: "meditationDescription") as? String
        let meditationFileMaleVoice = aDecoder.decodeObject(forKey: "meditationFileMaleVoice") as? String
        let meditationFileFemaleVoice = aDecoder.decodeObject(forKey: "meditationFileFemaleVoice") as? String
        let collectionId = aDecoder.decodeObject(forKey: "collectionId") as? Int
        let fileImage = aDecoder.decodeObject(forKey: "fileImage") as? String
        let duration = aDecoder.decodeObject(forKey: "duration") as? Int
        self.init(meditationId: meditationId, meditationName: meditationName, meditationDescription: meditationDescription, meditationFileMaleVoice: meditationFileMaleVoice, meditationFileFemaleVoice: meditationFileFemaleVoice, collectionId: collectionId, fileImage: fileImage, duration: duration)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(meditationId, forKey: "meditationId") 
        aCoder.encode(meditationName, forKey: "meditationName")
        aCoder.encode(meditationDescription, forKey: "meditationDescription")
        aCoder.encode(meditationFileMaleVoice, forKey: "meditationFileMaleVoice")
        aCoder.encode(meditationFileFemaleVoice, forKey: "meditationFileFemaleVoice")
        aCoder.encode(collectionId, forKey: "collectionId")
        aCoder.encode(fileImage, forKey: "fileImage")
        aCoder.encode(duration, forKey: "duration")
    }
}

class MeditationDetailResponse: Response {
    var data: MeditationDetail?
    var error: String?
    
    enum CoingKeys: String, CodingKey {
        case data, error
    }
}
