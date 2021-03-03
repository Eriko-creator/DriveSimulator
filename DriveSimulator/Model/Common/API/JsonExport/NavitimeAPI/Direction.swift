//
//  Direction.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/19.
//

import Foundation

struct Direction: Codable{
    let items: [Items]
}

struct Items: Codable{
    let sections: [Sections]
    let summary: Summary
}

struct Sections: Codable{
    //地点情報か移動情報か
    let type: String
    //経路の座標
    let coord: LocationPoint?
    //地点名称
    let name: String?
    //道路名称
    let lineName: String?
    //地点間の距離(m)
    let distance: Int?
    //地点間の所要時間(分)
    let time: Int?
    //高速道路
    let highway: String?
    //経由地かどうかのフラグ
    let isVia: Bool?
    //一つ上のpointからの出発時刻
    let fromTime: String?
    //一つ下のpointへの到着時刻
    let toTime: String?
    
    enum CodingKeys: String,CodingKey{
        
        case type
        case coord
        case name
        case lineName = "line_name"
        case distance
        case time
        case highway
        case isVia = "with_via"
        case fromTime = "from_time"
        case toTime = "to_time"
        
    }
}

struct Summary: Codable{
    
    //移動情報
    let move: Move
    //出発地点に関する情報
    let start: Start
    //ルート結果内番号
    let number: String
    //到着地点に関する情報
    let goal: Goal
    
    enum CodingKeys: String, CodingKey{
        case move
        case start
        case number = "no"
        case goal
    }
}

struct Move: Codable{
    
    //出発時刻
    let fromTime :String
    //総距離(m)
    let distance: Int
    //総時間（分）
    let time: Int
    //到着時刻
    let toTime: String
    //運賃
    let fare: Fare?
    
    enum CodingKeys: String, CodingKey{
        case fromTime = "from_time"
        case distance
        case time
        case toTime = "to_time"
        case fare
    }
}

struct Fare: Codable{
    
    //軽自動車（現金）
    let lightCash: Int
    //軽自動車（ETC）
    let lightETC: Int
    //普通自動車（現金）
    let standardCash: Int
    //普通自動車（ETC）
    let standardETC: Int
    //中型車(現金）
    let mediumCash: Int
    //中型車(ETC）
    let mediumETC: Int
    //大型車(現金）
    let largeCash: Int
    //大型車（ETC）
    let largeETC: Int
    //特大車(現金）
    let extraLargeCash: Int
    //特大車(ETC）
    let extraLargeETC: Int
    
    enum CodingKeys: String, CodingKey{
        
        case lightCash = "unit_1024_1"
        case lightETC = "unit_1025_1"
        case standardCash = "unit_1024_2"
        case standardETC = "unit_1025_2"
        case mediumCash = "unit_1024_3"
        case mediumETC = "unit_1025_3"
        case largeCash = "unit_1024_4"
        case largeETC = "unit_1025_4"
        case extraLargeCash = "unit_1024_5"
        case extraLargeETC = "unit_1025_5"
    }
}

struct Start: Codable{
    let coord: LocationPoint
}

struct Goal: Codable{
    let coord: LocationPoint
}

struct LocationPoint: Codable{
    let lon: Double
    let lat: Double
}
