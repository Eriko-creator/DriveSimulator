//
//  SearchResultView.swift
//  ShutokoSimulator_
//
//  Created by 肥沼英里 on 2021/01/18.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces

class SetAddressFromMapView: XibView {
    
    var mapView = GMSMapView()
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var instructionLabel: UILabel!
    
    var labelText = ""{
        didSet{
            instructionLabel.text = "\(labelText)を選択してください。"
        }
    }
    //コードから呼び出す際に使用される
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(mapView)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mapView.frame = CGRect(x: 0, y: self.frame.minY + searchBar.frame.height + instructionLabel.frame.height, width: self.frame.width, height: self.frame.height - searchBar.frame.height - instructionLabel.frame.height)
        mapView.camera = GMSCameraPosition(latitude: 35.6809591, longitude: 139.7673068, zoom: 15.0)
        //現在地を表示
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
    }
}
