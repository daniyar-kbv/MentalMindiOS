//
//  Promocode.swift
//  MentalMindiOS
//
//  Created by Dan on 12/22/20.
//

import Foundation

class PromocodeResponse: Response {
    var data: String?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case data, error
    }
}
