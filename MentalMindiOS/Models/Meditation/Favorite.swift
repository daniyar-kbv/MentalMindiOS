//
//  Favorite.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11.12.2020.
//

import Foundation

class FavoriteAddResponse: Response {
    var data: FavoriteAddData?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case data, error
    }
}

class FavoriteAddData: Codable {
    var meditation: Int?
    var collection: Int?
    
    enum CodingKeys: String, CodingKey {
        case meditation, collection
    }
}

class FavoriteDeleteResponse: Response {
    var data: String?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case data, error
    }
}
