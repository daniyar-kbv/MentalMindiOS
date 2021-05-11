//
//  SocialLogin.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/30/20.
//

import Foundation


protocol PremiumModel {
    func getIsPreimium() -> Bool
}


class LoginResponse: Response {
    var data: LoginData?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case data, error
    }
}

class LoginData: Codable {
    var accessToken: String?
    var user: User?
    
    enum CodingKeys: String, CodingKey {
        case user
        case accessToken = "access_token"
    }
}

class User: NSObject, Codable, NSCoding, PremiumModel {
    var id: Int?
    var email: String?
    var fullName: String?
    var dateJoined: String?
    var daysWithUs: Int?
    var listenedMinutes: Int?
    var birthday: String?
    var country: String?
    var city: String?
    var subsExpiryDate: String?
    var language: String?
    var isPremium: Bool?
    var isActive: Bool?
    var isPaid: Bool?
    var isTrial: Bool?
    var level: Int?
    var feeling: String?
    var socialLogin: String?
    var socialId: String?
    var favoriteMeditations: [Meditation]?
    var profileImage: String?
    var tariff: Tariff?
    
    func getIsPreimium() -> Bool {
        return (isPremium ?? false) || (isPaid ?? false) || (isTrial ?? false)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, email, birthday, country, city, language, level, feeling, tariff
        case fullName = "full_name"
        case dateJoined = "date_joined"
        case daysWithUs = "days_with_us"
        case listenedMinutes = "listened_minutes"
        case subsExpiryDate = "subs_expiry_date"
        case isPremium = "is_premium"
        case isActive = "is_active"
        case isPaid = "is_paid"
        case isTrial = "is_trial"
        case socialLogin = "social_login"
        case socialId = "social_id"
        case favoriteMeditations = "favorite_meditations"
        case profileImage = "profile_image"
    }
    
    init(id: Int?, email: String?, fullName: String?, dateJoined: String?, daysWithUs: Int?, listenedMinutes: Int?, birthday: String?, country: String?, city: String?, subsExpiryDate: String?, language: String?, isPremium: Bool?, isActive: Bool?, isPaid: Bool?, isTrial: Bool?, level: Int?, feeling: String?, socialLogin: String?, socialId: String?, favoriteMeditations: [Meditation]?, profileImage: String?, tariff: Tariff?) {
        self.id = id
        self.email = email
        self.fullName = fullName
        self.dateJoined = dateJoined
        self.daysWithUs = daysWithUs
        self.listenedMinutes = listenedMinutes
        self.birthday = birthday
        self.country = country
        self.city = city
        self.subsExpiryDate = subsExpiryDate
        self.language = language
        self.isPremium = isPremium
        self.isActive = isActive
        self.isPaid = isPaid
        self.isTrial = isTrial
        self.level = level
        self.feeling = feeling
        self.socialLogin = socialLogin
        self.socialId = socialId
        self.favoriteMeditations = favoriteMeditations
        self.profileImage = profileImage
        self.tariff = tariff
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as? Int
        let email = aDecoder.decodeObject(forKey: "email") as? String
        let fullName = aDecoder.decodeObject(forKey: "fullName") as? String
        let dateJoined = aDecoder.decodeObject(forKey: "dateJoined") as? String
        let daysWithUs = aDecoder.decodeObject(forKey: "daysWithUs") as? Int
        let listenedMinutes = aDecoder.decodeObject(forKey: "listenedInMinutes") as? Int
        let birthday = aDecoder.decodeObject(forKey: "birthday") as? String
        let country = aDecoder.decodeObject(forKey: "country") as? String
        let city = aDecoder.decodeObject(forKey: "city") as? String
        let subsExpiryDate = aDecoder.decodeObject(forKey: "subsExpiryDate") as? String
        let language = aDecoder.decodeObject(forKey: "language") as? String
        let isPremium = aDecoder.decodeObject(forKey: "isPremium") as? Bool
        let isActive = aDecoder.decodeObject(forKey: "isActive") as? Bool
        let isPaid = aDecoder.decodeObject(forKey: "isPaid") as? Bool
        let isTrial = aDecoder.decodeObject(forKey: "isTrial") as? Bool
        let level = aDecoder.decodeObject(forKey: "level") as? Int
        let feeling = aDecoder.decodeObject(forKey: "feeling") as? String
        let socialLogin = aDecoder.decodeObject(forKey: "socialLogin") as? String
        let socialId = aDecoder.decodeObject(forKey: "socialId") as? String
        let favoriteMeditations = aDecoder.decodeObject(forKey: "favoriteMeditations") as? [Meditation]
        let profileImage = aDecoder.decodeObject(forKey: "profileImage") as? String
        let tariff = aDecoder.decodeObject(forKey: "tariff") as? Tariff
        self.init(id: id, email: email, fullName: fullName, dateJoined: dateJoined, daysWithUs: daysWithUs, listenedMinutes: listenedMinutes, birthday: birthday, country: country, city: city, subsExpiryDate: subsExpiryDate, language: language, isPremium: isPremium, isActive: isActive, isPaid: isPaid, isTrial: isTrial, level: level, feeling: feeling, socialLogin: socialLogin, socialId: socialId, favoriteMeditations: favoriteMeditations, profileImage: profileImage, tariff: tariff)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(fullName, forKey: "fullName")
        aCoder.encode(dateJoined, forKey: "dateJoined")
        aCoder.encode(daysWithUs, forKey: "daysWithUs")
        aCoder.encode(listenedMinutes, forKey: "listenedInMinutes")
        aCoder.encode(birthday, forKey: "birthday")
        aCoder.encode(country, forKey: "country")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(subsExpiryDate, forKey: "subsExpiryDate")
        aCoder.encode(language, forKey: "language")
        aCoder.encode(isPremium, forKey: "isPremium")
        aCoder.encode(isActive, forKey: "isActive")
        aCoder.encode(isPaid, forKey: "isPaid")
        aCoder.encode(isTrial, forKey: "isTrial")
        aCoder.encode(level, forKey: "level")
        aCoder.encode(feeling, forKey: "feeling")
        aCoder.encode(socialLogin, forKey: "socialLogin")
        aCoder.encode(socialId, forKey: "socialId")
        aCoder.encode(favoriteMeditations, forKey: "favoriteMeditations")
        aCoder.encode(profileImage, forKey: "profileImage")
        aCoder.encode(tariff, forKey: "tariff")
    }
}
