//
//  Geometry.swift
//  ShutokoSimulator_
//
//  Created by 肥沼英里 on 2021/01/20.
//

import Foundation

struct Geometry: Codable{
    let results: [results]
}

struct results: Codable{
    let geometry : geometry
    let address: [Address]
    
    enum CodingKeys: String, CodingKey{
        case geometry
        case address = "address_components"
    }
}

struct geometry: Codable{
    let location: location
}

struct Address:Codable{
    let shortName: String
    
    enum CodingKeys: String,CodingKey{
        case shortName = "short_name"
    }
}

struct location: Codable{
    let lat: Double
    let lng: Double
}
