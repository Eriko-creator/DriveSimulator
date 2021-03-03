//
//  RouteShape.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/19.
//

import Foundation

struct RouteShape: Codable{
    var items: [items]
}

struct items: Codable{
    let path: [path]
}

struct path: Codable{
    
    let coords: [[Double]]
    let width: Int
    let color: String
    let opacity: Double
    let roadType: String!
    
    enum CodingKeys: String,CodingKey{
        case coords
        case width
        case color
        case opacity
        case roadType = "road_type"
    }
}

