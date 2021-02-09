//
//  PageViewDataSource.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/08.
//

import Foundation
import UIKit

class PageViewModel: NSObject{
    
    func setControllers(action:Action, vc: UIViewController)->[UIViewController]{
        
        switch action{
        
        case .select:
            
            guard let history = vc.storyboard?.instantiateViewController(withIdentifier: "history") as? HistoryTableViewController,
                  let myLocation = vc.storyboard?.instantiateViewController(withIdentifier: "myLocation") as? MyLocationViewController,
                  let favorite = vc.storyboard?.instantiateViewController(withIdentifier: "favorite") as? FavoriteTableViewController
            else {return []}
            
            return [history, myLocation, favorite]
            
        case .save:
            
            guard let history = vc.storyboard?.instantiateViewController(withIdentifier: "history") as? HistoryTableViewController,
                  let myLocation = vc.storyboard?.instantiateViewController(withIdentifier: "myLocation") as? MyLocationViewController,
                  let map = vc.storyboard?.instantiateViewController(withIdentifier: "map") as? SetAddressViewController
            else {return []}
            
            return [history, myLocation, map]
        }
    }
}

