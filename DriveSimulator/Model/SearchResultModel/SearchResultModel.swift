//
//  SearchResultModel.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/19.
//

import Foundation

//車種ごとの料金表示
enum CarType: Int{
    
    case light = 0
    case standard = 1
    case midium = 2
    case large = 3
    case extraLarge = 4

}

class SearchResultModel{
    
    func getCashFare(fare:Fare, carType:CarType)->Int{
        
        switch carType{
        case .light: return fare.lightCash
        case .standard: return fare.standardCash
        case .midium: return fare.mediumCash
        case .large: return fare.largeCash
        case .extraLarge: return fare.extraLargeCash
        }
    }
    
    func getETCFare(fare:Fare, carType:CarType)->Int{
        
        switch carType{
        case .light: return fare.lightETC
        case .standard: return fare.standardETC
        case .midium: return fare.mediumETC
        case .large: return fare.largeETC
        case .extraLarge: return fare.extraLargeETC
        }
    }
    
    func formatDistanceToKm(from m:Int)->Double{
        //小数第三位で切り上げ
        return ceil(Double(m)/100)/100
    }
    
    func formatTime(from min:Int)->String{
        //何時間何分という表記にする
        return "\(min/60)時間\(min%60)分"
    }
    
    func getTime(from date: String)->String{
        let dateFormatter = DateFormatter()
        return dateFormatter.dateStringToTime(from: date)
    }
    
    
    
}
