//
//  Listeners.swift
//  MentalMindiOS
//
//  Created by Dan on 5/11/21.
//

import Foundation


class CurrentListenersResponse: Response {
    var data: CurrentListenersData?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case data, error
    }
}


class CurrentListenersData: Codable {
    var amount: Int?
    
    enum CodingKeys: String, CodingKey {
        case amount
    }
}
