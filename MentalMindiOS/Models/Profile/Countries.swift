//
//  Countries.swift
//  MentalMindiOS
//
//  Created by Dan on 2/19/21.
//

import Foundation

class CountriesResponse: Response {
    var data: CountriesData?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case data, error
    }
}

class CountriesData: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Country]?
    
    enum CoingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

class Country: NSObject, Codable, NSCoding {
    var id: Int?
    var name: String?
    var cities: [City]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, cities
    }
    
    init(id: Int?, name: String?, cities: [City]?) {
        self.id = id
        self.name = name
        self.cities = cities
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as? Int
        let name = aDecoder.decodeObject(forKey: "name") as? String
        let cities = aDecoder.decodeObject(forKey: "cities") as? [City]
        self.init(id: id, name: name, cities: cities)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(cities, forKey: "cities")
    }
}

class City: NSObject, Codable, NSCoding {
    var id: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as? Int
        let name = aDecoder.decodeObject(forKey: "name") as? String
        self.init(id: id, name: name)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
    }
}
