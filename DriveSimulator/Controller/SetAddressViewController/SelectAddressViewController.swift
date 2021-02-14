//
//  SelectAddressViewController.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/01/27.
//

import UIKit

class SelectAddressViewController: UIViewController {
    
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var myLocationButton: UIButton!
    @IBOutlet weak var favoritePlaceButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    private let model = SelectAddressViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //instructionLabelに表示するtextを設定
        let placeAction = PlaceAction.shared
        instructionLabel.text = placeAction.action.labelText
        //ボタンを変更する
        model.changeButton(button: favoritePlaceButton)
        
        //containerViewにpageViewを設定
        guard let pageView = self.storyboard?.instantiateViewController(withIdentifier: "pageView") as? PageViewController else {return}
        self.addChild(pageView)
        
        pageView.presentationController?.delegate = self
        
        addSubview(subView: pageView.view, toView: containerView)
        
        //pageViewに表示されているhistoryVCに対応するボタンをdisabledにする
        //ボタンのtagで管理したい。。。
        historyButton.isEnabled = false
    }
    
    private func addSubview(subView:UIView, toView parentView: UIView) {
        parentView.addSubview(subView)
        //subViewをparentViewに合わせる
        subView.frame = parentView.bounds
        subView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func changePageView(_ sender: Any) {
        
        //一度全てのボタンを選択可能にする
        historyButton.isEnabled = true
        myLocationButton.isEnabled = true
        favoritePlaceButton.isEnabled = true
        
        guard let button = sender as? UIButton,
              let pageViewVC = self.children.first as? PageViewController,
              let pageView = pageViewVC.pageView else {return}
        //ボタンのtagと同じ番号のcontrollerを表示する
        pageView.setViewControllers([pageViewVC.controllers[button.tag]], direction: .forward, animated: true, completion: nil)
        //ボタンをdisabledにする
        button.isEnabled = false
        
    }
}

//子ViewのPageViewが閉じた時の処理
extension SelectAddressViewController: UIAdaptivePresentationControllerDelegate{
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        
        let placeAction = PlaceAction.shared
        guard let parentVC = parent as? SetAddressViewController else {return}
        
        switch placeAction.action{
        case .select:
            parentVC.dismiss(animated: true, completion: nil)
        case .save:
            guard let savePointVC = parentVC.storyboard?.instantiateViewController(withIdentifier: "savePoint") as? SavePointViewController else {return}
            //savePointVCに遷移する
            parentVC.navigationController?.pushViewController(savePointVC, animated: true)
        }
    }
}
