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
}

class SearchView: XibView{
    
    var delegate: SearchViewDelegate?
    
    
    @IBOutlet var textLabel: [UILabel]!
    
    @IBOutlet weak var addViaButton: UIButton!
    @IBOutlet weak var reverseButton: UIButton!
    
    @IBAction func setAddressFromMapButton(_ sender: Any) {
        let button = sender as! UIButton
        delegate?.presentSetAddressFromMapView(tag:button.tag)
        print(button.tag)
    }
    
    @IBOutlet weak var setDateButton: UIButton!
    @IBOutlet weak var stateSegmentedControl: UISegmentedControl!
    @IBOutlet weak var carTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var showSavedRouteButton: UIButton!
    @IBOutlet weak var searchFromHistoryButton: UIButton!
    
    
}
