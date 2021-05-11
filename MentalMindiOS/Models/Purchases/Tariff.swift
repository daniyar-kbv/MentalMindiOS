//
//  Tariff.swift
//  MentalMindiOS
//
//  Created by Dan on 12/23/20.
//

import Foundation

class TariffsResponse: Response {
    var data: TariffsData?
    var error: String?
    
    enum CoingKeys: String, CodingKey {
        case data, error
    }
}


class TariffsData: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Tariff]?
    
    enum CoingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

class Tariff: NSObject, Codable, NSCoding {
    var id: Int?
    var name: String?
    var description_: String?
    var price: Int?
    var productId: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, price
        case productId = "apple_product_id"
        case description_ = "description"
    }
    
    init(id: Int?, name: String?, description_: String?, price: Int?, productId: String?) {
        self.id = id
        self.name = name
        self.description_ = description_
        self.price = price
        self.productId = productId
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as? Int
        let name = aDecoder.decodeObject(forKey: "name") as? String
        let description_ = aDecoder.decodeObject(forKey: "description_") as? String
        let price = aDecoder.decodeObject(forKey: "price") as? Int
        let productId = aDecoder.decodeObject(forKey: "productId") as? String
        self.init(id: id, name: name, description_: description_, price: price, productId: productId)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(description_, forKey: "description_")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(productId, forKey: "productId")
    }
}

class PaymentResponse: Response {
    var data: PaymentData?
    var error: String?
    
    enum CoingKeys: String, CodingKey {
        case data, error
    }
}

class PaymentData: Codable {
    var receiptData: String?
    var tariffId: Int?
    
    enum CodingKeys: String, CodingKey {
        case receiptData = "receipt_data"
        case tariffId = "tariff_id"
    }
}
