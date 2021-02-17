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
    var address: String = ""
}

class PlaceAction{
    
    //シングルトン
    lazy var place: Place = Place(placeName: "", lat: 0.0, lng: 0.0, address: "")
    lazy var action: Action = Action.save(realmDatabase: .favorite)
    
    static let shared = PlaceAction()
    private init(){
        print("placeAction生成")
    }
    deinit {
        print("placeAction解放")
    }
    
    //エラー 地名を取得できませんでした
    func setPlaceName(completion: ()->Void){
        
        switch action{
        case .select(let state):
            
            switch state{
            case .start:
                NotificationCenter.default.post(name: .selectedStartPlace, object: nil, userInfo: ["selectedStartPlace": place])
                completion()
            case .goal:
                NotificationCenter.default.post(name: .selectedGoalPlace, object: nil, userInfo: ["selectedGoalPlace": place])
                completion()
            }
        case .save:
            completion()
        }
    }
    
    public func savePlace(placeName: String, lat: Double, lng: Double, realmDataBase: Action.RealmDataBase){
        
        do{
            let realm = try Realm()
            
            //保存するデータを作成
            let dictionary:[String:Any] =
                ["placeName": placeName,
                 "location": ["lat": lat,"lng": lng]]
                
                switch realmDataBase{
                case .history:
                    
                    let history = History(value: dictionary)
                    //realmにデータを保存
                    try! realm.write {
                        realm.add(history)
                        print(history)
                    }
                    //成功アニメーションを流す
                        
                case .favorite:
                   
                    let favorite = Favorite(value: dictionary)
                    try! realm.write {
                        realm.add(favorite)
                        print(favorite)
                    }
                    //成功アニメーションを流す
            }
        }catch{
            print("データの保存に失敗しました:\(error)")
        }
    }
}

extension Notification.Name{
    
    static let selectedStartPlace = Notification.Name("selectedStartPlace")
    static let selectedGoalPlace = Notification.Name("selectedGoalPlace")

}
