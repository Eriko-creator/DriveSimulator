//
//  MyLocationModel.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/08.
//

import Foundation
import GoogleMaps

class MyLocationModel{
    
    init(){
        print("myLocationModel生成")
    }
    deinit {
        print("myLocationModel解放")
    }
    
    func setButtonTitle(action:Action)->String{
        
        switch action{
        case .select(let state):
            return "\(state.text)に設定"
        case .save:
            return "地点を登録"
        }
    }
    
    //ボタンが押下可能かどうかの真偽値を返すメソッド
    func isButtonEnabled(text: String)->Bool{
        if text == ""{
            return false
        }else if text == "現在地を取得できません。"{
            return false
        }else{
            return true
        }
    }
}
