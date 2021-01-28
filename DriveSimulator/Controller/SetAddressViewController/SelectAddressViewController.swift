//
//  SelectAddressViewController.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/01/27.
//

import UIKit

class SelectAddressViewController: UIViewController {
    
    let myView = SelectAddressView()
    var tag: Int = 1
    
    override func loadView() {
        super.loadView()
        self.view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //出発地か到着地かのtagを取得しラベルに反映
        let parentVC = self.parent as! SetAddressViewController
        tag = parentVC.tag
        let state = SearchModel.State(rawValue: tag)!
        myView.instructionLabel.text = "\(state.text)を選択してください。"
    }

}
