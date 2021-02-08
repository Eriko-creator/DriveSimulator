//
//  Action.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/01.
//

import Foundation
import UIKit


enum Action{
    
    enum State: Int{
        
        case start = 1
        case goal = 2
        
        var text: String{
            switch self {
            case .start:
                return "出発地"
            case .goal:
                return "到着地"
            }
        }
    }
    
    enum RealmDataBase{
        case history
        case favorite
    }
    
    case select(state:State)
    case save(realmDatabase: RealmDataBase)
    
    var showFavoriteVC: Bool{
        switch self{
        case .select:
            return false
        case .save:
            return true
        }
    }
    
    var labelText: String{
        switch self{
        case .select(let state):
            return "\(state.text)を選択してください。"
        case .save:
            return "登録地点を設定します。"
        }
    }
    
    var alertTitle: String{
        switch self {
        case .select(let state):
            return "\(state.text)をここに決定しますか？"
        case .save:
            return "この地点を登録しますか？"
        }
    }
}


