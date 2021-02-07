//
//  SetPlaceName.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/06.
//

import Foundation
import RealmSwift


struct Place{
    var placeName:String
    var lat: Double
    var lng: Double
}

class PlaceAction{
    
    //シングルトン
    var action: Action?
    var lat: Double = 0.0
    var lng: Double = 0.0
    
    static let shared = PlaceAction()
    private init(){
    }
    
    //エラー 地名を取得できませんでした
    func setPlaceName(place:Place){
        
        switch action{
        case .select(let state):
            
            switch state{
            case .start:
                NotificationCenter.default.post(name: .selectedStartPlaceName, object: nil, userInfo: ["selectedStartPlaceName": place.placeName])
            case .goal:
                NotificationCenter.default.post(name: .selectedGoalPlaceName, object: nil, userInfo: ["selectedGoalPlaceName": place.placeName])
            }
        case .save(let realmDataBase):
            savePlace(placeName: place.placeName, lat: place.lat, lng: place.lng, realmDataBase: realmDataBase)
        case .none:
            break
        }
    }
    
    private func savePlace(placeName: String, lat: Double, lng: Double, realmDataBase: Action.RealmDataBase){
        
        do{
            let realm = try Realm()
            
            //保存するデータを作成
            let dictionary:[String:Any] =
                ["placeName": placeName,
                 "location": [["lat": lat,"lng": lng]]]
                
                switch realmDataBase{
                case .history:
                    
                    let history = History(value: dictionary)
                    //realmにデータを保存
                    try! realm.write {
                        realm.add(history)
                        print(history)
                    }
                        
                case .favorite:
                   
                    let favorite = Favorite(value: dictionary)
                    try! realm.write {
                        realm.add(favorite)
                        print(favorite)
                    }
            }
        }catch{
            print("データの保存に失敗しました:\(error)")
        }
    }
}

extension Notification.Name{
    
    static let selectedStartPlaceName = Notification.Name("selectedStartPlaceName")
    static let selectedGoalPlaceName = Notification.Name("selectedGoalPlaceName")

}


