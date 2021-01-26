//
//  SearchModel.swift
//  ShutokoSimulator_
//
//  Created by 肥沼英里 on 2021/01/19.
//

import Foundation
import UIKit

class SearchModel {
    
    //画面分岐
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
        func setAddress(address: String, VC:UIViewController){
            let preVC = VC.presentingViewController as! SearchViewController
            switch self{
            case .start:
                preVC.startAddress = address
            case .goal:
                preVC.goalAddress = address
            }
        }
    }
}
