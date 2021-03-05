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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: GMSMapView!
    private var labelView: UIView!
    private var instructionLabel: UILabel!
    var myLocationButton: UIButton!
    private var settingButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        instructionLabel = UILabel()
        labelView = UIView()
        labelView.addSubview(instructionLabel)
        
        myLocationButton = MyLocationButton()
        myLocationButton.addTarget(self, action: #selector(showMyLocation), for: .touchUpInside)
        
        settingButton = SettingButton()
        
        mapView.addSubview(labelView)
        mapView.addSubview(myLocationButton)
        mapView.addSubview(settingButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //東京駅
        let tokyoStation = GMSCameraPosition(latitude: 35.6809591, longitude: 139.7673068, zoom: 15.0)
        mapView.camera = tokyoStation
        mapView.isMyLocationEnabled = true
        mapView.frame = frame
        
        instructionLabel.frame = CGRect(x: 0, y: 0, width: labelView.frame.width, height: labelView.frame.height)
        instructionLabel?.textAlignment = .center
        let placeAction = PlaceAction.shared
        instructionLabel.text = placeAction.action.labelText
        
        labelView.frame = CGRect(x: 10, y: 10, width: mapView.frame.width-20, height: 30)
        labelView.isHidden = placeAction.action.isFavoriteVCPresented
        labelView.backgroundColor = .white
        labelView.layer.cornerRadius = 15.0
        labelView.layer.shadowOffset = CGSize(width: 1, height: 1)
        labelView.layer.shadowOpacity = 0.5
        labelView.layer.shadowRadius = 1
        labelView.layer.shadowColor = UIColor.darkGray.cgColor
        
        myLocationButton.frame.origin = CGPoint(x: frame.width-50, y: labelView.frame.origin.y+50)
        
        settingButton.frame.origin = CGPoint(x: frame.width-50, y: myLocationButton.frame.origin.y+50)
    }

    @objc func showMyLocation(){
        guard let lat = mapView.myLocation?.coordinate.latitude,
              let lng = mapView.myLocation?.coordinate.longitude else {return}
        let camera = GMSCameraPosition(latitude: lat, longitude: lng, zoom: 15.0)
        GMSMapView.animate(withDuration: 0) {
            self.mapView.animate(to: camera)
        } completion: { [unowned self] (flag) in
            myLocationButton.isEnabled = false
        }
    }
    
    @objc func showMapSettings(){
        
    }
}
