//
//  SetAddressFromMapViewController.swift
//  ShutokoSimulator_
//
//  Created by 肥沼英里 on 2021/01/19.
//

import UIKit
import GoogleMaps

class SetAddressFromMapViewController: UIViewController, UISearchBarDelegate{
    
    private let myView = SetAddressFromMapView()
    private let model = SetAddressFromMapModel()
    private let infoWindow = InfoWindowView()
    private let placeAction = PlaceAction.shared

    override func loadView() {
        super.loadView()
        self.view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //searchBarのデリゲートを設定
        myView.searchBar.delegate = self
        model.delegate = self
        //GMSMapViewDelegateを設定
        myView.mapView.delegate = self
        //Modelのデリゲートを設定
        model.delegate = self
        //現在地を取得する
        MapSettings.requestLocation()
        //instructionLabelを設定する
        myView.instructionLabel.text = placeAction.action.labelText
        myView.instructionLabel.isHidden = placeAction.action.isFavoriteVCPresented
        
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
        //POI上にInfoWindowを表示
        let POIMarker = GMSMarker()
        let point = SetAddressFromMapModel.Point(marker: POIMarker, mapView: mapView, coordinate: location, placeID: placeID, infoWindow: infoWindow)
        model.showPOIinfoWindow(point: point)
        
    }
    //地図上をタップした時
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        //タップした場所にマーカーを表示
        let marker = GMSMarker()
        let point = SetAddressFromMapModel.Point(marker: marker, mapView: mapView, coordinate: coordinate, placeID: nil, infoWindow: infoWindow)
        model.setMarkerOnMap(point: point)
    }
    
    //infoWindowをタップした時
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        //アラートを表示
        let alert = model.showAlert(infoWindow: infoWindow, coordinate: marker.position)
        present(alert, animated: true, completion: nil)
    }
    
    //InfoWindowにCustomViewを設定する
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        infoWindow.frame.size.width = myView.frame.size.width/1.5
        infoWindow.frame.size.height = infoWindow.frame.size.width
        infoWindow.addressLabel.frame.size = CGSize(width: infoWindow.frame.size.width-10, height: infoWindow.frame.size.height/9)
        infoWindow.nameLabel.frame.size = CGSize(width: infoWindow.addressLabel.frame.size.width, height: infoWindow.addressLabel.frame.size.height*2)
        infoWindow.photoImageView.frame.size = CGSize(width: infoWindow.frame.size.width-20, height: infoWindow.addressLabel.frame.size.height*6)
        infoWindow.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        return infoWindow
        
    }
}

extension SetAddressFromMapViewController: SetAddressFromMapViewDelegate{
  
    func closeViewController() {
        
        switch placeAction.action{
        case .select:
            //出発地、目的地を選ぶ時→画面を閉じる
            placeAction.setPlaceName{
                dismiss(animated: true, completion: nil)
            }
        case .save:
            //地点を登録する時→画面遷移
            guard let parentVC = self.parent as? PageViewController,
                  let savePointVC = self.storyboard?.instantiateViewController(withIdentifier: "savePoint")
            else {return}
            parentVC.navigationController?.pushViewController(savePointVC, animated: true)
        }
    }
}

