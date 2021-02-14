//
//  MyLocationViewController.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/08.
//

import UIKit
import GoogleMaps

class MyLocationViewController: UIViewController {
    
    private let myView = MyLocationView()
    private var mapView: GMSMapView?
    private let placeAction = PlaceAction.shared
    private var lat: Double = 0.0
    private var lng: Double = 0.0
    
    override func loadView() {
        super.loadView()
        self.view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMyLocationVC()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
   
    private func setUpMyLocationVC(){
        
        mapView = GMSMapView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        mapView?.isMyLocationEnabled = true
        //mapViewを監視対象にする
        mapView?.addObserver(self, forKeyPath: "myLocation", options: .new, context: nil)
        //ボタンを押した時の処理
        myView.instructionButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
       
    }
    
    @objc func buttonAction(){
        let place = Place(placeName: myView.labelText, lat: lat, lng: lng, address: myView.labelText)
        placeAction.place = place
        placeAction.setPlaceName {
            parent?.dismiss(animated: true, completion: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let myLocation: CLLocation = change?[NSKeyValueChangeKey.newKey] as? CLLocation else {return}
        
        mapView?.removeObserver(self, forKeyPath: "myLocation")
        
        let coordinate = myLocation.coordinate
        self.lat = coordinate.latitude
        self.lng = coordinate.longitude
        
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { [unowned self] (response, error) in
            if let response = response, let result = response.firstResult(), let address = result.lines?[0]{
                myView.labelText = address
            }else {
                myView.labelText = "現在地を取得できません。"
                print(error?.localizedDescription as Any)
            }
        }
    }
}
