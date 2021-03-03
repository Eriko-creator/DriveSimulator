//
//  SearchConditions.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/20.
//

import Foundation

enum TimeState: Int{
    case start = 0
    case goal = 1
    
    var text: String{
        switch self{
        case .start: return "start"
        case .goal: return "goal"
        }
    }
    var japaneseText: String{
        switch self{
        case .start: return "出発"
        case .goal: return "到着"
        }
    }
}

enum Conditions{
    case recommend
    case time
    case distance
    case gas
    case free
    
    var queryValue:String{
        switch self{
        case .recommend: return "recommend"
        case .time: return "toll_time"
        case .distance: return "toll_distance"
        case .gas: return "toll_gas"
        case .free: return "free_time"
        }
    }
}

class SearchQueryMaker{
    
    //クエリの中身
    var startPlace: Place?
    var goalPlace: Place?
    var viaPlace: [Place]?
    var timeState: TimeState?
    var date: String?
    var carType: CarType?
    
    static let shared = SearchQueryMaker()
    
    private init(){
        print("SearchConditions生成")
    }
    deinit {
        print("SearchConditions解放")
    }
    
    //QueryItemsを作成
    public func getQueryItems(conditions:Conditions)->[URLQueryItem] {
        
        var queryItems = [URLQueryItem]()
        guard let startLat = startPlace?.lat,
              let startLng = startPlace?.lng,
              let goalLat = goalPlace?.lat,
              let goalLng = goalPlace?.lng,
              let timeState = timeState,
              let date = date else {return []}
        
        //経由地がある場合経由地を追加
        if let viaPlaces = viaPlace{
            let value = getViaPlaceQueryValue(from: viaPlaces)
            queryItems.append(URLQueryItem(name: "via", value: "[\(value)]"))
        }
        
        //交差点等、進行情報を案内するための地点情報
        queryItems.append(URLQueryItem(name: "options", value: "turn_by_turn"))
        //出発地
        queryItems.append(URLQueryItem(name: "start", value: "\(startLat),\(startLng)"))
        //到着地
        queryItems.append(URLQueryItem(name: "goal", value: "\(goalLat),\(goalLng)"))
        //出発・到着時刻
        queryItems.append(URLQueryItem(name: "\(timeState.text)_time", value: date))
        //検索方法
        queryItems.append(URLQueryItem(name: "condition", value: conditions.queryValue))
        
        return queryItems
    }
    
    //経由地の配列からクエリに必要な文字列を取り出す
    private func getViaPlaceQueryValue(from viaPlaces:[Place])->String{
        
        var value = [String]()
        for viaPlace in viaPlaces{
            let item = "{\"lat\":\(viaPlace.lat),\"lng\":\(viaPlace.lng)}"
            value.append(item)
        }
        let valueString = value.reduce("") { (result, element) -> String in
            if result == ""{
                return result+element
            }else{
                return result+","+element
            }
        }
        return valueString
    }
}
