//
//  ViewController.swift
//  ShutokoSimulator_
//
//  Created by 肥沼英里 on 2021/01/18.
//

import UIKit

class SearchViewController: UIViewController {

    let myView = SearchView()
    
    override func loadView() {
        super.loadView()
        self.view = myView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.delegate = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPlaceName()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func getPlaceName(){
        
        NotificationCenter.default.addObserver(forName: .selectedStartPlaceName, object: nil, queue: nil) { (notification) in
            guard let startPlaceName = notification.userInfo?["selectedStartPlaceName"] as? String else {return}
            self.myView.textLabel[0].text = startPlaceName
        }
        
        NotificationCenter.default.addObserver(forName: .selectedGoalPlaceName, object: nil, queue: nil) { (notification) in
            guard let goalPlaceName = notification.userInfo?["selectedGoalPlaceName"] as? String else {return}
            self.myView.textLabel[1].text = goalPlaceName
        }
        
    }
}

extension SearchViewController: SearchViewDelegate{
    
    func presentSetAddressFromMapView(tag: Int) {
        
        //シングルトン　値を格納
        let placeAction = PlaceAction.shared
        guard let state = Action.State(rawValue: tag) else {return}
        placeAction.action = Action.select(state: state)
        //画面遷移
        let VC = SetAddressFromMapViewController()
        present(VC, animated: true, completion: nil)
    }
    
    func presentSetAddressView(tag: Int){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "SetAddress", bundle: nil)
        guard let VC = storyBoard.instantiateViewController(withIdentifier: "setAddress") as? SetAddressViewController,
              let state = Action.State(rawValue: tag) else {return}
        let placeAction = PlaceAction.shared
        placeAction.action = Action.select(state: state)
        
        present(VC, animated: true, completion: nil)
    }
}
