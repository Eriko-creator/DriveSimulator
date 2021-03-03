//
//  DateFormatter.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/23.
//

import Foundation

extension DateFormatter{
 
    func dateFormatForLabel(date:Date)->String{
        
        locale = Locale(identifier: "ja_JP")
        dateFormat = "yyyy年M月d日(E)HH時mm分"
        let labelDate = string(from: date)
        return labelDate
    }
    
    func dateFormatForQuery(date:Date)->String{
        
        dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let queryDate = string(from: date)
        return queryDate
    }
    
    func dateStringToTime(from dateString: String)->String{
        
        locale = Locale(identifier: "ja_JP")
        dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let dates = date(from: dateString) else {return ""}
        let components = calendar.dateComponents([.hour, .minute], from: dates)
        guard let time = calendar.date(from: components) else {return ""}
        dateFormat = "HH:mm"
        let finalTime = string(from: time)
        
        return finalTime
    }
    
}
