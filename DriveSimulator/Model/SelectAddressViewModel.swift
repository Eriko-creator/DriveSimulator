//
//  SelectAddressViewModel.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/10.
//

import Foundation
import UIKit

class SelectAddressViewModel{
    
    private let placeAction = PlaceAction.shared
    
    init(){
        print("setAddressModel生成")
    }
    deinit {
        print("setAddressModel解放")
    }
    
    func changeButton(button: UIButton){
        
        switch placeAction.action{
        case .select:
            button.setImage(UIImage(named: "favorite"), for: .normal)
            button.setImage(UIImage(named: "favoriteSelected"), for: .disabled)
        case .save:
            button.setImage(UIImage(named: "map"), for: .normal)
            button.setImage(UIImage(named: "mapSelected"), for: .disabled)
        }
    }
}
