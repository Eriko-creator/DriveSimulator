//
//  APIConfigure.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/20.
//

import Foundation
import Alamofire

protocol APIConfigure{
   
    associatedtype JsonExport: Codable
    //APIの呼び出し先
    static var path: URLConvertible? { get }
    //ヘッダー
    static var headers: HTTPHeaders? { get }
    //リクエストする
    static func request(completion: @escaping((JsonExport)->Void))
}

extension APIConfigure{
    
    static func request(completion: @escaping((JsonExport)->Void)){
        
        guard let path = self.path else {return}
        print(path)
        AF.request(path, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: self.headers).responseJSON { (response) in
            do{
                guard let data = response.data else {return}
                let result = try JSONDecoder().decode(JsonExport.self, from: data)
                completion(result)
            }catch{
                print(error)
            }
        }
    }
}
