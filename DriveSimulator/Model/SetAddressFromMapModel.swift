//
//  SetAddressFromMapModel.swift
//  ShutokoSimulator_
//
//  Created by 肥沼英里 on 2021/01/19.
//

import Foundation
import GoogleMaps

protocol SetAddressFromMapViewDelegate {
    func closeViewController(address:String, tag:Int)
}

final class SetAddressFromMapModel {
    
    struct Point{
        var marker: GMSMarker
        var mapView: GMSMapView
        var coordinate: CLLocationCoordinate2D
        var placeID: String!
        var infoWindow: InfoWindowView
    }

    struct Info{
        var name: String = ""
        var address: String = ""
        var image: UIImage = UIImage(named: "noImage")!
        
        func setInfo(infoWindow:InfoWindowView){
            infoWindow.nameLabel.text = name
            infoWindow.addressLabel.text = address
            infoWindow.photoImageView.image = image
        }
    }
    
    let googleMapAPI = GoogleMapAPI()
    let mapSettings = MapSettings()
    var delegate: SetAddressFromMapViewDelegate?
    
    func setMarkerOnMap(point:Point, info:Info){
        //InfoWindowの内容を変更する
        info.setInfo(infoWindow: point.infoWindow)
        //タップ地点を中央にしてカメラを動かし、ピンを立てる
        mapSettings.addMarker(lat: point.coordinate.latitude, lng: point.coordinate.longitude, mapView: point.mapView)
        
    }
    
    public func moveToPlace(name:String, mapView:GMSMapView){
        
        googleMapAPI.getGeometry(address: name) {[unowned self](geometry) in
            if let geometry = geometry{
                guard let results = geometry.results.first else {return}
                
                mapSettings.updateCameraView(lat:results.geometry.location.lat , lng: results.geometry.location.lng, mapView: mapView, zoom:15)
            }
        }
    }
    
    //POI地点のInfoWindow情報を取得し、表示する
    public func showPOIinfoWindow(point:Point){
        
        googleMapAPI.getPlaceDetails(placeID: point.placeID) { [unowned self](placeDetails) in
            print(placeDetails as Any)
            //画像がない場合
            if let placeDetails = placeDetails{
                if placeDetails.result.photos == nil{
                    let noImageInfo = Info(name: placeDetails.result.name, address: placeDetails.result.formattedAddress)
                    noImageInfo.setInfo(infoWindow: point.infoWindow)
                    setPOIMarker(point: point)
                //画像がある場合
                }else if let photos = placeDetails.result.photos.first{
                    googleMapAPI.getImage(photoReference: photos.photoReference) { (image) in
                        let imageInfo = Info(name: placeDetails.result.name, address: placeDetails.result.formattedAddress, image: image)
                        imageInfo.setInfo(infoWindow: point.infoWindow)
                        setPOIMarker(point: point)
                    }
                }
            }
        }
    }
    
    private func setPOIMarker(point:Point){
        //POIにInfoWindowを表示
        point.marker.position = point.coordinate
        point.marker.opacity = 0
        point.marker.map = point.mapView
        point.mapView.selectedMarker = point.marker
        //POIを中心にしてカメラを移動させる
        mapSettings.updateCameraView(lat: point.coordinate.latitude, lng: point.coordinate.longitude, mapView: point.mapView, zoom: 20)

    }
    
    //infoWindowをタップした時のアラート
    func showAlert(tag:Int, infoWindow:InfoWindowView)->UIAlertController{
        
        let state = SearchModel.State(rawValue: tag)!
        let alert = UIAlertController(title: "\(state.text)をここに決定しますか？", message: "\(infoWindow.nameLabel.text!)", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default) { [self](action) in
            alert.dismiss(animated: true, completion: nil)
            delegate?.closeViewController(address: infoWindow.nameLabel.text!, tag: tag)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        return alert
    }
}
