//
//  SearchView.swift
//  ShutokoSimulator_
//
//  Created by 肥沼英里 on 2021/01/18.
//

import Foundation
import UIKit

protocol SearchViewDelegate {
    func presentSetAddressFromMapView(tag: Int)
    func presentSetAddressView(tag:Int)
    func presentDatePicker()
}

class SearchView: XibView{
    
    var delegate: SearchViewDelegate?
    
    override func didAddSubview(_ subview: UIView) {
        //地点名の通知を受け取る
        //出発地名を受け取ったらボタンのタイトルに反映
        NotificationCenter.default.addObserver(forName: .selectedStartPlace, object: nil, queue: nil) { [unowned self] (notification) in
            guard let startPlace = notification.userInfo?["selectedStartPlace"] as? Place else {return}
            selectStartPlaceButton.setTitle(startPlace.placeName, for: .normal)
        }
        //到着地名を受け取ったらボタンのタイトルに反映
        NotificationCenter.default.addObserver(forName: .selectedGoalPlace, object: nil, queue: nil) { [unowned self] (notification) in
            guard let goalPlace = notification.userInfo?["selectedGoalPlace"] as? Place else {return}
            selectGoalPlaceButton.setTitle(goalPlace.placeName, for: .normal)
        }
        //経由地名を受け取ったらラベルを追加
        NotificationCenter.default.addObserver(forName: .selectedViaPlace, object: nil, queue: nil) { [unowned self] (notification) in
            guard let viaPlace = notification.userInfo?["selectedViaPlace"] as? Place else {return}
            let label = ViaPlaceLabel()
            label.viaPlaceNameButton.setTitle(viaPlace.placeName, for: .disabled)
            let stackIndex = placeNameStackView.arrangedSubviews.count
            placeNameStackView.insertArrangedSubview(label, at: stackIndex-2)
            
        }
        //日付の通知を受け取ったらボタンに反映
        NotificationCenter.default.addObserver(forName: .selectedDate, object: nil, queue: nil) { [unowned self](notification) in
            guard let date = notification.userInfo?["selectedDate"] as? String else {return}
            setDateButton.setTitle(date, for: .normal)
        }
    }
    
    @IBOutlet weak var selectStartPlaceButton: UIButton!
    @IBOutlet weak var selectGoalPlaceButton: UIButton!
    @IBOutlet weak var addViaButton: UIButton!
    @IBOutlet weak var addViaFromMapButton: UIButton!
    @IBOutlet weak var selectStartPlaceFromMapButton: UIButton!
    @IBOutlet weak var selectGoalPlaceFromMapButton: UIButton!
    @IBOutlet weak var reversePlaceNameButton: UIButton!
    @IBOutlet weak var setDateButton: UIButton!
    @IBOutlet weak var stateSegmentedControl: UISegmentedControl!
    @IBOutlet weak var carTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var showSavedRouteButton: UIButton!
    @IBOutlet weak var searchFromHistoryButton: UIButton!
    @IBOutlet weak var placeNameStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //ここでボタンにaddtargetした方が読みやすい気がする
        selectStartPlaceButton.addTarget(self, action: #selector(presentSelectPlaceVC(_:)), for: .touchUpInside)
        selectGoalPlaceButton.addTarget(self, action: #selector(presentSelectPlaceVC(_:)), for: .touchUpInside)
        addViaButton.addTarget(self, action: #selector(presentSelectPlaceVC(_:)), for: .touchUpInside)
        addViaFromMapButton.addTarget(self, action: #selector(presentSelectPlaceFromMapVC(_:)), for: .touchUpInside)
        selectStartPlaceFromMapButton.addTarget(self, action: #selector(presentSelectPlaceFromMapVC(_:)), for: .touchUpInside)
        selectGoalPlaceFromMapButton.addTarget(self, action: #selector(presentSelectPlaceFromMapVC(_:)), for: .touchUpInside)
        reversePlaceNameButton.addTarget(self, action: #selector(reversePlaceName), for: .touchUpInside)
        setDateButton.addTarget(self, action: #selector(presentDatePicker), for: .touchUpInside)
    }
    
    @objc func presentSelectPlaceVC(_ sender: Any){
        let button = sender as! UIButton
        delegate?.presentSetAddressView(tag: button.tag)
    }
    
    @objc func reversePlaceName(){
        guard let title1 = selectStartPlaceButton.currentTitle else {return}
        selectStartPlaceButton.setTitle("\(selectGoalPlaceButton.currentTitle ?? "")", for: .normal)
        selectGoalPlaceButton.setTitle(title1, for: .normal)
    }
    
    @objc func presentSelectPlaceFromMapVC(_ sender: Any){
        let button = sender as! UIButton
        delegate?.presentSetAddressFromMapView(tag:button.tag)
    }
    
    @objc func presentDatePicker(){
        delegate?.presentDatePicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
