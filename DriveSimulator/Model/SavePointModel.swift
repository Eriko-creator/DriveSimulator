//
//  SavePointModel.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/10.
//

import Foundation
import GoogleMaps
import RealmSwift

final class SavePointModel{
    
    
    func setAddress(){
        
        var place = PlaceAction.shared.place
        
        if place.address == ""{
            let geocoder = GMSGeocoder()
            geocoder.reverseGeocodeCoordinate(CLLocationCoordinate2D(latitude: place.lat, longitude: place.lng)) { (response, error) in
                guard let result = response?.results()?.first,
                      let address = result.lines?.first else {return}
                place.address = address
            }
        }else{
            return
        }
    }
    
    func checkPoint(placeName: String, lat: Double, lng: Double) throws{
        
        guard placeName != "" else {
            throw InvalidData.voidPlaceName
        }
        
        guard placeName.count<=20 else {
            throw InvalidData.invalidPlaceName
        }
        
        do{
            let realm = try Realm()
            let favorite = realm.objects(Favorite.self)
            let duplicatedName = favorite.filter("placeName == \(placeName)")
            let duplicatedLocation = favorite.filter("location == [lat:\(lat), lng:\(lng)]")
            
            guard duplicatedName.count == 0 else{
                throw InvalidData.duplicatedPlaceName
            }
            
            guard duplicatedLocation.count == 0 else{
                throw InvalidData.duplicatedLocation
            }
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    enum InvalidData: Error{
        case duplicatedPlaceName
        case duplicatedLocation //上書き保存できるようになると良いかも
        case invalidPlaceName
        case voidPlaceName
        
        var alertText: String{
            switch self{
            case .duplicatedPlaceName:
                return "その地点名は既に登録されています。別の名前を設定してください。"
            case .duplicatedLocation:
                return "この地点は既に登録されています。名前を変更したい場合、一度登録地点から削除してください。"
            case .invalidPlaceName:
                return "文字数は20文字以内に収めてください。"
            case .voidPlaceName:
                return "登録地点名を入力してください。"
            }
        }
    }
}
    
    

