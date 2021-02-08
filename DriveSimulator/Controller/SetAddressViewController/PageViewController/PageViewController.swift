//
//  PageViewController.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/08.
//

import UIKit

class PageViewController: UIViewController {

    private let model = PageViewDataSource()
    private let placeAction = PlaceAction.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initPageViewController()
    }
    
    private func initPageViewController(){
        
        let pageView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        //表示するcontrollerを決定
        guard let action = placeAction.action else {return}
        let controllers = model.setControllers(action: action, vc: self)
        
        //dataSourceを設定
        pageView.dataSource = model
        
        //最初に表示するVCをセット
        pageView.setViewControllers([controllers[0]], direction: .forward, animated: true, completion: nil)
        
        self.view.addSubview(pageView.view)
        
    }
}

//pageViewを閉じたら親Viewに知らせる
extension UIPageViewController{
    
    open override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        
        guard let presentationController = presentationController else {return}
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}
