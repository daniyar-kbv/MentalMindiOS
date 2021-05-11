//
//  Profile.swift
//  MentalMindiOS
//
//  Created by Daniyar on 14.12.2020.
//

import Foundation

class MeResponse: Response {
    var data: User?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case data, error
    }
}
