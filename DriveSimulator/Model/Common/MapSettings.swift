//
//  MapSettings.swift
//  ShutokoSimulator_
//
//  Created by 肥沼英里 on 2021/01/20.
//

import Foundation
import GoogleMaps
import GooglePlaces

class MapSettings{
    
    //表示したい地点をviewの中央に持ってくる
    static func updateCameraView(lat: Double, lng: Double, mapView: GMSMapView, zoom:Int){
        let center = GMSCameraPosition.camera(withLatitude: lat+0.0001, longitude: lng, zoom: Float(zoom))
        mapView.camera = center
        mapView.animate(to: center)
    }
    
    //位置情報を取得する
    static func requestLocation(){
        
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

    }
}
