//
//  PlaceDetails.swift
//  ShutokoSimulator_
//
//  Created by 肥沼英里 on 2021/01/21.
//

import Foundation

struct PlaceDetails: Codable{
    let result: Result
}

struct Result:Codable{
    
    //住所
    let formattedAddress: String
    //名称
    let name: String
    //画像
    let photos: [Photo]!
    
    enum CodingKeys: String, CodingKey{
        case formattedAddress = "formatted_address"
        case name
        case photos
    }
    
    struct Photo:Codable {
        let photoReference: String
        enum CodingKeys:String, CodingKey{
            case photoReference = "photo_reference"
        }
    }
}
