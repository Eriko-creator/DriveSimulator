//
//  SearchModel.swift
//  ShutokoSimulator_
//
//  Created by 肥沼英里 on 2021/01/19.
//

import Foundation
import UIKit

class SearchModel {
  
    func setSearchQuery(stateSegment: Int, carTypeSegment: Int){
        //segmentedControlのクエリを追加する
        let searchQueryMaker = SearchQueryMaker.shared
        guard let timeState = TimeState(rawValue: stateSegment),
              let carType = CarType(rawValue: carTypeSegment) else {return}
        searchQueryMaker.timeState = timeState
        searchQueryMaker.carType = carType
    }
    
}
