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
    private let placeAction = PlaceAction.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //instructionLabelに表示するtextを設定
        instructionLabel.text = placeAction.action?.labelText
        
        //containerViewにpageViewを設定
        guard let pageView = self.storyboard?.instantiateViewController(withIdentifier: "pageView") as? PageViewController else {return}
        self.addChild(pageView)
        addSubview(subView: pageView.view, toView: containerView)
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
        
    }
}
