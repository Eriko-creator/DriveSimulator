//
//  TabBarController.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/15.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag{
        case 2:
            let placeAction = PlaceAction.shared
            placeAction.action = .save(realmDatabase: .favorite)
        default:
            break
        }
    }

}
