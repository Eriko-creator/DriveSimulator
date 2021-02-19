//
//  ViewController.swift
//  ShutokoSimulator_
//
//  Created by 肥沼英里 on 2021/01/18.
//

import UIKit

class SearchViewController: UIViewController {

    private let myView = SearchView()
    
    override func loadView() {
        super.loadView()
        self.view = myView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.delegate = self
        myView.searchButton.isEnabled = true
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         getPlaceName()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    func presentDatePicker() {
        let datePickerView = DatePickerView()
        datePickerView.frame = CGRect(x: 10, y: myView.frame.maxY, width: myView.bounds.width-20, height: 30+datePickerView.datePicker.frame.height)
        UIView.animate(withDuration: 0.3) { [unowned self] in
            guard let tabHeight = tabBarController?.tabBar.frame.height else {return}
            datePickerView.frame.origin.y = myView.frame.height-tabHeight-datePickerView.frame.height-10
        }
        myView.addSubview(datePickerView)
    }
    
}
