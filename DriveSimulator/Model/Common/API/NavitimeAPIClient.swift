//
//  APIClient.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/20.
//

import Foundation
import Alamofire

protocol NavitimeApiConfigure: APIConfigure{
    static var baseUrl: String { get }
    static var queryItems: [URLQueryItem] { get }
    static func request(completion: @escaping((JsonExport)->Void))
}

extension NavitimeApiConfigure{
    
    static var headers: HTTPHeaders?{
        if let APIKey = KeyManager().getValue(key: "NavitimeAPI") as? String{
            let headerContent = [
                "x-rapidapi-host": "navitime-route-car.p.rapidapi.com",
                "x-rapidapi-key": "\(APIKey)"
            ]
            return HTTPHeaders.init(headerContent)
        }
        return nil
    }
    
    static var path: URLConvertible?{
        var components = URLComponents(string: baseUrl)
        components?.queryItems = self.queryItems
        if let url = components?.url{
            return url
        }
        return nil
    }
}

protocol NavitimeDirectionApi: NavitimeApiConfigure{
    static var conditions: Conditions { get }
}

extension NavitimeDirectionApi{
    
    static var baseUrl: String{
        return "https://navitime-route-car.p.rapidapi.com/route_car"
    }
    
    static var queryItems: [URLQueryItem]{
        let searchPathMaker = SearchQueryMaker.shared
        let query = searchPathMaker.getQueryItems(conditions: self.conditions)
        return query
    }
}

protocol NavitimeRouteShapeApi: NavitimeApiConfigure{
    static var conditions: Conditions { get }
}

extension NavitimeRouteShapeApi{
    
    static var baseUrl: String{
        return "https://navitime-route-car.p.rapidapi.com/shape_car"
    }
    
    static var queryItems: [URLQueryItem]{
        let searchPathMaker = SearchQueryMaker.shared
        var query = searchPathMaker.getQueryItems(conditions: self.conditions)
        query.append(URLQueryItem(name: "format", value: "json"))
        return query
    }
}

struct NavitimeAPIClient {
    
    //ルート詳細取得
    struct getRecommendRoute: NavitimeDirectionApi{
        typealias JsonExport = Direction
        static let conditions = Conditions.recommend
    }
    
    struct getFastestRoute: NavitimeDirectionApi{
        typealias JsonExport = Direction
        static let conditions = Conditions.time
    }
    
    struct getShortestRoute: NavitimeDirectionApi{
        typealias JsonExport = Direction
        static let conditions = Conditions.distance
    }
    
    struct getWorstUsingGasRoute: NavitimeDirectionApi{
        typealias JsonExport = Direction
        static let conditions = Conditions.gas
    }
    
    struct getFreeRoute: NavitimeDirectionApi{
        typealias JsonExport = Direction
        static let conditions = Conditions.free
    }

    //ルート形状取得
    struct getRecommendRouteShape: NavitimeRouteShapeApi{
        typealias JsonExport = RouteShape
        static let conditions = Conditions.recommend
    }
    
    struct getFastestRouteShape: NavitimeRouteShapeApi{
        typealias JsonExport = RouteShape
        static let conditions = Conditions.time
    }
    
    struct getShortestRouteShape: NavitimeRouteShapeApi{
        typealias JsonExport = RouteShape
        static let conditions = Conditions.distance
    }
    
    struct getWorstUsingGasRouteShape: NavitimeRouteShapeApi{
        typealias JsonExport = RouteShape
        static let conditions = Conditions.gas
    }
    
    struct getFreeRouteShape: NavitimeRouteShapeApi{
        typealias JsonExport = RouteShape
        static let conditions = Conditions.free
    }
}
