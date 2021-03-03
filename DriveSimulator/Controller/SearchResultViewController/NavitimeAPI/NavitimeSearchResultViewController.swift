//
//  SearchResultViewController.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/19.
//

import UIKit
import SegementSlide


final class NavitimeSearchResultViewController: UIViewController{
    
    var segementSlideVC: MyNavitimeSegementSlideVC?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        segementSlideVC = MyNavitimeSegementSlideVC()
        if let segementSlideVC = segementSlideVC{
            self.addChild(segementSlideVC)
            view.addSubview(segementSlideVC.view)
        }

        segementSlideVC?.defaultSelectedIndex = 0
        segementSlideVC?.reloadData()
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

protocol MyNavitimeSegementSlideVCDelegate: class{
    func didChangeView(to config: SearchResultViewConfig)
    func floatHalf()
    func floatFull()
}

class MyNavitimeSegementSlideVC: SegementSlideDefaultViewController{
    
    weak var delegate: MyNavitimeSegementSlideVCDelegate?
    
    override var titlesInSwitcher: [String]{
        return ["推奨","無料道路","時間優先","距離優先"]
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        
        switch index{
        case 0:
            return NavitimeContentViewController(config: RecommendRoute())
        case 1:
            return NavitimeContentViewController(config: FreeRoute())
        case 2:
            return NavitimeContentViewController(config: FastestRoute())
        case 3:
            return NavitimeContentViewController(config: ShortestRoute())
        default:
            return NavitimeContentViewController(config: RecommendRoute())
        }
    }
    
    //画面が変わったことをdelegateで伝える
    override func didSelectContentViewController(at index: Int) {
        
        switch index{
        case 0:
            delegate?.didChangeView(to: RecommendRoute())
        case 1:
            delegate?.didChangeView(to: FreeRoute())
        case 2:
            delegate?.didChangeView(to: FastestRoute())
        case 3:
            delegate?.didChangeView(to: ShortestRoute())
        default:
            delegate?.didChangeView(to: RecommendRoute())
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offsetY = scrollView.contentOffset.y
        //topにいる時に下に引っ張るとfloatingPanelを.halfの状態にする
        if offsetY<0{
            delegate?.floatHalf()
        //Halfの状態で上にスクロールするとfloatingPanelを.fullの状態にする
        }else if offsetY>0{
            delegate?.floatFull()
        }
    }
}

extension SegementSlideContentView{
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        print(offsetY)
        //topにいる時に下に引っ張るとfloatingPanelを.halfの状態にする
        if offsetY<0{
            print("Y<0")
        //Halfの状態で上にスクロールするとfloatingPanelを.fullの状態にする
        }else if offsetY>0{
            print("Y>0")
        }
    }
}
