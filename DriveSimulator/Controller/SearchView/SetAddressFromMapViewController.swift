//
//  SetAddressFromMapViewController.swift
//  ShutokoSimulator_
//
//  Created by 肥沼英里 on 2021/01/19.
//

import UIKit
import GoogleMaps

class SetAddressFromMapViewController: UIViewController, UISearchBarDelegate{
    
    let myView = SetAddressFromMapView()
    let model = SetAddressFromMapModel()
    let infoWindow = InfoWindowView()
    let marker = GMSMarker()
    
    //出発地を選択する画面か到着地を選択する画面か値を受け取る
    var tag:Int = 1

    override func loadView() {
        super.loadView()
        self.view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //出発地か到着地か判定
        let state = SetAddressFromMapModel.State(rawValue: tag)!
        myView.labelText = state.text
        //searchBarのデリゲートを設定
        myView.searchBar.delegate = self
        model.delegate = self
        //GMSMapViewDelegateを設定
        myView.mapView.delegate = self
        //Modelのデリゲートを設定
        model.delegate = self
        //現在地を取得する
        MapSettings().requestLocation()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Searchキーが押されたらキーボードを閉じる
        resignFirstResponder()
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //入力された地点を表示する
        model.moveToPlace(name: myView.searchBar.text!, mapView: myView.mapView)
    }
}
    
extension SetAddressFromMapViewController: GMSMapViewDelegate {
    
    //POI地点をタップした時
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        mapView.clear()
        //POI上にInfoWindowを表示
        let POIMarker = GMSMarker()
        let point = SetAddressFromMapModel.Point(marker: POIMarker, mapView: mapView, coordinate: location, placeID: placeID, infoWindow: infoWindow)
        model.showPOIinfoWindow(point: point)
        
    }
    //地図上をタップした時
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        //タップした場所にマーカーを表示
        let point = SetAddressFromMapModel.Point(marker: marker, mapView: mapView, coordinate: coordinate, placeID: nil, infoWindow: infoWindow)
        let info = SetAddressFromMapModel.Info(name: "\(coordinate.latitude),\(coordinate.longitude)")
        model.setMarkerOnMap(point: point, info: info)
    }
    
    //アラートを表示
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        let alert = model.showAlert(tag: tag, infoWindow: infoWindow)
        print(infoWindow.nameLabel.text!)
        present(alert, animated: true, completion: nil)
    }
    
    //InfoWindowにCustomViewを設定する
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        infoWindow.frame.size.width = myView.frame.size.width/1.5
        infoWindow.frame.size.height = myView.frame.size.height/4
        infoWindow.addressLabel.frame.size = CGSize(width: infoWindow.frame.size.width-10, height: infoWindow.frame.size.height/9)
        infoWindow.nameLabel.frame.size = CGSize(width: infoWindow.addressLabel.frame.size.width, height: infoWindow.addressLabel.frame.size.height*2)
        infoWindow.photoImageView.frame.size = CGSize(width: infoWindow.frame.size.width-20, height: infoWindow.addressLabel.frame.size.height*7)
        
        return infoWindow
        
    }
}

extension SetAddressFromMapViewController: SetAddressFromMapViewDelegate{
    //出発地/到着地の名前をSearchViewに渡して画面を閉じる
    func closeViewController(address:String, tag:Int) {
        let preVC = self.presentingViewController as! SearchViewController
        if tag == 1{
            preVC.startAddress = address
        }else if tag == 2{
            preVC.goalAddress = address
        }
        dismiss(animated: true, completion: nil)
    }
}

