//
//  SetAddressFromMapModel.swift
//  ShutokoSimulator_
//
//  Created by 肥沼英里 on 2021/01/19.
//

import Foundation
import GoogleMaps
import GooglePlaces

protocol SetAddressFromMapViewDelegate: class {
    func closeViewController()
}

final class SetAddressFromMapModel {
    
    struct Point{
        var marker: GMSMarker
        var mapView: GMSMapView
        var coordinate: CLLocationCoordinate2D
        var placeID: String?
        var infoWindow: InfoWindowView
    }

    struct Info{
        var name: String = ""
        var address: String? = ""
        var image: UIImage? = UIImage(named: "noImage")
        
        func setInfo(infoWindow:InfoWindowView){
            infoWindow.nameLabel.text = name
            infoWindow.addressLabel.text = address
            infoWindow.photoImageView.image = image
        }
    }
    
    private let googleMapAPI = GoogleMapAPI()
    weak var delegate: SetAddressFromMapViewDelegate?
    private let placeAction = PlaceAction.shared
    
    init(){
        print("setfromMapModel生成")
    }
    deinit {
        print("setfromMapModel解放")
    }
    
    func setMarkerOnMap(point:Point){
        //緯度経度から住所を取得してinfoWindowに表示する
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(point.coordinate) { [unowned self] (response, error) in
            guard let result = response?.firstResult(), let address = result.lines?.first else {return}
            let info = Info(name: address)
            info.setInfo(infoWindow: point.infoWindow)
            setMarker(point: point, opacity: 1)
        }
    }
    
    func moveToPlace(name:String, mapView:GMSMapView){
        
        googleMapAPI.getGeometry(address: name) {(geometry) in
            if let geometry = geometry{
                guard let results = geometry.results.first else {return}
                
                MapSettings.updateCameraView(lat:results.geometry.location.lat , lng: results.geometry.location.lng, mapView: mapView, zoom:15)
            }
        }
    }
    
    //POI地点のInfoWindow情報を取得し、表示する
    public func showPOIinfoWindow(point:Point){
        
        point.mapView.clear()
        let placesClient = GMSPlacesClient()
        placesClient.fetchPlace(fromPlaceID: point.placeID ?? "", placeFields: [.name, .formattedAddress, .photos], sessionToken: nil) { [unowned self] (result, error) in
            if let result = result{
                
                //画像がない場合
                if result.photos == nil{
                    let noImageInfo = Info(name: result.name ?? "", address: result.formattedAddress ?? "")
                    noImageInfo.setInfo(infoWindow: point.infoWindow)
                    setMarker(point: point, opacity: 0)
                //画像がある場合
                }else if let photos = result.photos?.first{
                    placesClient.loadPlacePhoto(photos, constrainedTo: CGSize(width: 284, height: 132), scale: 1.0) { (image, error) in
                        if let image = image{
                            let imageInfo = Info(name: result.name ?? "", address: result.formattedAddress ?? "", image: image)
                            imageInfo.setInfo(infoWindow: point.infoWindow)
                            setMarker(point: point, opacity: 0)
                        }
                    }
                }
            }else{
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    private func setMarker(point:Point, opacity: Float){
        //POIにInfoWindowを表示
        point.marker.position = point.coordinate
        point.marker.opacity = opacity
        point.marker.map = point.mapView
        point.mapView.selectedMarker = point.marker
        //POIを中心にしてカメラを移動させる
        MapSettings.updateCameraView(lat: point.coordinate.latitude, lng: point.coordinate.longitude, mapView: point.mapView, zoom: 20)

    }
    
    //infoWindowをタップした時のアラート
    func showAlert(infoWindow:InfoWindowView, coordinate: CLLocationCoordinate2D)->UIAlertController{
        
        let alert = UIAlertController(title: "\(placeAction.action.alertTitle)", message: "\(infoWindow.nameLabel.text!)", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default) { [unowned self](alertAction) in
            
            alert.dismiss(animated: true, completion: nil)
            //地名、緯度経度を保持させる
            let place = Place(placeName: infoWindow.nameLabel.text ?? "", lat: coordinate.latitude, lng: coordinate.longitude, address: infoWindow.addressLabel.text ?? "")
            placeAction.place = place
            //画面を閉じる
            delegate?.closeViewController()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        return alert
    }
}
