//
//  Auth.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/30/20.
//

import Foundation

class RegisterResponse: Response {
    var data: User?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case data, error
    }
}


class PasswordRestoreResponse: Response {
    var success: Bool?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case success, error
    }
}
