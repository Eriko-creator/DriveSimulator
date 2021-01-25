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
    
    //ピンを立てる
    func addMarker (lat: Double, lng: Double, mapView:GMSMapView){
    
        let marker = GMSMarker()
        //他のピンを消す
        mapView.clear()
        //ピンを立てる
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        marker.map = mapView
        marker.appearAnimation = .pop
        //ピンを中心にしてカメラを動かす
        updateCameraView(lat: lat, lng: lng, mapView: mapView, zoom: 20)
        
    }
    
    //表示したい地点をviewの中央に持ってくる
    func updateCameraView(lat: Double, lng: Double, mapView: GMSMapView, zoom:Int){
        let center = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: Float(zoom))
        mapView.camera = center
        mapView.animate(to: center)
    }
    
    //位置情報を取得する
    func requestLocation(){
        
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

    }
}
