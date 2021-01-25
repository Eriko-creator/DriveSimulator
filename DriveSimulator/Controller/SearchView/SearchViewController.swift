//
//  ViewController.swift
//  ShutokoSimulator_
//
//  Created by 肥沼英里 on 2021/01/18.
//

import UIKit

class SearchViewController: UIViewController {

    let myView = SearchView()
    var startAddress = ""{
        didSet{
            myView.startTextLabel.text = startAddress
        }
    }
    var goalAddress = ""{
        didSet{
            myView.goalTextLabel.text = goalAddress
        }
    }
    
    override func loadView() {
        super.loadView()
        self.view = myView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.delegate = self
        
    }

}

extension SearchViewController: SearchViewDelegate{
    
    func presentSetAddressFromMapView(tag: Int) {
        
        let VC = SetAddressFromMapViewController()
        //tagで表示内容変更
        VC.tag = tag

        //画面遷移
        present(VC, animated: true, completion: nil)
    }
}
