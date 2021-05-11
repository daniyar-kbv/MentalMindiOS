//
//  Response.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/30/20.
//

import Foundation

protocol Response: Codable {
    var error: String? { get set }
}

class SubscriptionStatusResponse: Response {
    var data: SubscriptionStatusData?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case data, error
    }
}

class SubscriptionStatusData: Codable, PremiumModel {
    var isActive: Bool?
    var isPremium: Bool?
    var isPaid: Bool?
    var isTrial: Bool?
    var isSubscriptionExpired: Bool?
    
    enum CodingKeys: String, CodingKey {
        case isPaid = "is_paid"
        case isPremium = "is_premium"
        case isSubscriptionExpired = "is_subs_expired"
        case isActive = "is_active"
        case isTrial = "is_trial"
    }
    
    func getIsPreimium() -> Bool {
        return (isPremium ?? false) || (isPaid ?? false) || (isTrial ?? false)
    }
}
