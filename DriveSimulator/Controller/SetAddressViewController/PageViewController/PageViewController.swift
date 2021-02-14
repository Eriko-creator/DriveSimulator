//
//  PageViewController.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/08.
//

import UIKit

class PageViewController: UIViewController{

    var pageView: UIPageViewController?
    var controllers: [UIViewController] = []
    private let placeAction = PlaceAction.shared
    private let model = PageViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initPageViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func initPageViewController(){
        
        pageView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        //表示するcontrollerを決定
        let action = placeAction.action
        controllers = model.setControllers(action: action, vc: self)
        
        //最初に表示するVCをセット
        pageView?.setViewControllers([controllers[0]], direction: .forward, animated: true, completion: nil)
        
        //dataSourceを設定
        pageView?.dataSource = self
        
        if let pageView = pageView{
            self.addChild(pageView)
            self.view.addSubview(pageView.view)
        }
    }
}

extension PageViewController: UIPageViewControllerDataSource{
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }
    
    //右にスワイプした時(戻る)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else {return nil}
        if index == 0{
            return nil
        }else{
            return controllers[index-1]
        }
    }
    
    //左にスワイプした時(進む)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else {return nil}
        if index == controllers.count-1{
            return nil
        }else {
            return controllers[index+1]
        }
    }
}

//pageViewを閉じたら親Viewに知らせる
extension UIPageViewController{
    
    open override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        
        guard let parentVC = parent as? PageViewController,
              let presentationController = parentVC.presentationController else {return}
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}
