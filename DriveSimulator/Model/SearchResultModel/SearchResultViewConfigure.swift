//
//  SearchResultViewConfigure.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/22.
//

import Foundation

protocol SearchResultViewConfig{
    func getResult(completion: @escaping((Direction)->Void))
    func getRouteShape(completion: @escaping((RouteShape)->Void))
}


struct RecommendRoute: SearchResultViewConfig{
    func getResult(completion: @escaping ((Direction) -> Void)) {
        NavitimeAPIClient.getRecommendRoute.request { (direction) in
            completion(direction)
        }
    }
    func getRouteShape(completion: @escaping ((RouteShape) -> Void)) {
        NavitimeAPIClient.getRecommendRouteShape.request { (routeShape) in
            completion(routeShape)
        }
    }
}

struct FastestRoute: SearchResultViewConfig{
    func getResult(completion: @escaping ((Direction) -> Void)) {
        NavitimeAPIClient.getFastestRoute.request { (direction) in
            completion(direction)
        }
    }
    func getRouteShape(completion: @escaping ((RouteShape) -> Void)) {
        NavitimeAPIClient.getFastestRouteShape.request { (routeShape) in
            completion(routeShape)
        }
    }
}

struct ShortestRoute: SearchResultViewConfig{
    func getResult(completion: @escaping ((Direction) -> Void)) {
        NavitimeAPIClient.getShortestRoute.request { (direction) in
            completion(direction)
        }
    }
    func getRouteShape(completion: @escaping ((RouteShape) -> Void)) {
        NavitimeAPIClient.getShortestRouteShape.request { (routeShape) in
            completion(routeShape)
        }
    }
}

struct WorstUsingGasRoute: SearchResultViewConfig{
    func getResult(completion: @escaping ((Direction) -> Void)) {
        NavitimeAPIClient.getWorstUsingGasRoute.request { (direction) in
            completion(direction)
        }
    }
    func getRouteShape(completion: @escaping ((RouteShape) -> Void)) {
        NavitimeAPIClient.getWorstUsingGasRouteShape.request { (routeShape) in
            completion(routeShape)
        }
    }
}

struct FreeRoute: SearchResultViewConfig{
    func getResult(completion: @escaping ((Direction) -> Void)) {
        NavitimeAPIClient.getFreeRoute.request { (direction) in
            completion(direction)
        }
    }
    func getRouteShape(completion: @escaping ((RouteShape) -> Void)) {
        NavitimeAPIClient.getFreeRouteShape.request { (routeShape) in
            completion(routeShape)
        }
    }
}
