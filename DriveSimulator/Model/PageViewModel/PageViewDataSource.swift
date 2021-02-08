//
//  PageViewDataSource.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/08.
//

import Foundation
import UIKit

class PageViewDataSource: NSData, UIPageViewControllerDataSource{
    
    var controllers = [UIViewController]()
    
    func setControllers(action:Action, vc: UIViewController)->[UIViewController]{
        
        switch action{
        
        case .select:
            
            guard let history = vc.storyboard?.instantiateViewController(withIdentifier: "hitsory"),
                  let myLocation = vc.storyboard?.instantiateViewController(withIdentifier: "myLocation"),
                  let favorite = vc.storyboard?.instantiateViewController(withIdentifier: "favorite")
            else {return []}
            return [history, myLocation, favorite]
            
        case .save:
            
            guard let history = vc.storyboard?.instantiateViewController(withIdentifier: "hitsory"),
                  let myLocation = vc.storyboard?.instantiateViewController(withIdentifier: "myLocation"),
                  let map = vc.storyboard?.instantiateViewController(withIdentifier: "map")
            else {return []}
            return [history, myLocation, map]
        }
    }
    
    //ページ数を決定
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }
    
    //右にスワイプした時
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.controllers.firstIndex(of: viewController) else {return nil}
        if index == 0{
            return nil
        }else{
            return controllers[index-1]
        }
    }
    
    //左にスワイプした時
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.controllers.firstIndex(of: viewController) else {return nil}
        if index == controllers.count-1{
            return nil
        }else {
            return controllers[index+1]
        }
    }
}
