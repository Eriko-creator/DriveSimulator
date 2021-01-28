//
//  GoogleMapAPI.swift
//  ShutokoSimulator_
//
//  Created by 肥沼英里 on 2021/01/20.
//

import Foundation
import Alamofire

class GoogleMapAPI {
    
    let APIKey = KeyManager().getValue(key: "GoogleMapAPI") as? String
    
    //地点名から緯度経度を取得するメソッド
    func getGeometry(address: String, completion:@escaping((Geometry?) -> Void)){
       
        let baseUrl = "https://maps.googleapis.com/maps/api/geocode/json?language=ja&address=\(address)&key=\(APIKey!)"
       let url = baseUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
       print(url)
       
       AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
           
           guard let data = response.data else {return}
           do{
           let geometry:Geometry = try JSONDecoder().decode(Geometry.self, from: data)
               print(geometry)
               completion(geometry)
               
           }catch{
               print(error)
           }
       }
   }
    
    //placeIDからplaceDetailsを取得するメソッド
    func getPlaceDetails(placeID: String, completion:@escaping((PlaceDetails?)->Void)){
        
        let baseUrl = "https://maps.googleapis.com/maps/api/place/details/json"
        guard var components = URLComponents(string: baseUrl) else {return}
        components.queryItems = [
            URLQueryItem(name: "place_id", value: placeID),
            URLQueryItem(name: "key", value: APIKey),
            URLQueryItem(name: "language", value: "ja"),
            URLQueryItem(name: "region", value: "jp"),
            //住所、名称、画像、種類を取得
            URLQueryItem(name: "fields", value: "formatted_address,name,photo")
        ]
        
        guard let url = components.url else {return}
        print(url)
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {(response) in
            guard let data = response.data else {return}
            do{
                let placeDetails:PlaceDetails = try JSONDecoder().decode(PlaceDetails.self, from: data)
                completion(placeDetails)
            }catch{
                print(error)
            }
        }
    }
    
    
    func getImage(photoReference:String, completion:@escaping((UIImage)->Void)){
        
        let baseUrl = "https://maps.googleapis.com/maps/api/place/photo"
        guard var components = URLComponents(string: baseUrl) else {return}
        components.queryItems = [
            URLQueryItem(name: "key", value: APIKey),
            URLQueryItem(name: "photoreference", value: photoReference),
            URLQueryItem(name: "maxheight", value: "132"),
            URLQueryItem(name: "maxwidth", value: "284")
        ]
            
            guard let url = components.url else {return}
                AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
                    if let data = response.data{
                        let photoImage = UIImage(data: data)
                        completion(photoImage!)
                    }else{
                        print(AFError.self)
                    }
            }
    }
}
