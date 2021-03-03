//
//  SearchResultMapView.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/27.
//

import Foundation
import GoogleMaps

class SearchResultMapView: UIView{
    
    let mapView = GMSMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(mapView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        mapView.frame = self.frame
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
}
