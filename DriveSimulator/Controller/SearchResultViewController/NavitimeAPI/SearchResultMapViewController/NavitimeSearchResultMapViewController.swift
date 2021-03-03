//
//  SearchResultMapViewController.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/27.
//

import UIKit
import FloatingPanel
import SegementSlide
import GoogleMaps

class NavitimeSearchResultMapViewController: UIViewController, FloatingPanelControllerDelegate{
    
    private let myView = SearchResultMapView()
    var fpc: FloatingPanelController?
    
    override func loadView() {
        super.loadView()
        self.view = myView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setUpFloatingPanel()
        setUpView(config: RecommendRoute())
     
    }
    
    private func setUpFloatingPanel(){
        //FPCを設定
        fpc = FloatingPanelController()
        
        let contentVC = self.storyboard?.instantiateViewController(withIdentifier: "searchResult") as? NavitimeSearchResultViewController
        fpc?.set(contentViewController: contentVC)
        //デリゲートを設定
        contentVC?.segementSlideVC?.delegate = self
        //レイアウト設定
        fpc?.layout = MyFloatingPanelLayout()

        fpc?.addPanel(toParent: self)
    }
    
    private func setUpView(config: SearchResultViewConfig){
        
        self.navigationController?.navigationBar.isHidden = true
        myView.mapView.clear()
        
        config.getRouteShape { [unowned self] (routeShape) in
            let routePath = GMSMutablePath()
            guard let items = routeShape.items.first else {return}
            for path in items.path{
                for coords in path.coords{
                    //pathに地点情報を追加
                    routePath.add(CLLocationCoordinate2D(latitude: coords[0], longitude: coords[1]))
                }
            }
            //地点を線で結んでMap上に表示
            let polyLine = GMSPolyline(path: routePath)
            polyLine.strokeWidth = 4.0
            polyLine.map = myView.mapView
            
            //経路がおさまるようにカメラを調節する
            guard let start = items.path.first?.coords.first,
                  let goal = items.path.last?.coords.first else {return}
            let startCoord = CLLocationCoordinate2D(latitude: start[0], longitude: start[1])
            let goalCoord = CLLocationCoordinate2D(latitude: goal[0], longitude: goal[1])
            upDateCameraZoom(startCoord: startCoord, goalCoord: goalCoord)
        }
    }
    
    private func upDateCameraZoom(startCoord: CLLocationCoordinate2D, goalCoord: CLLocationCoordinate2D){
        
        let startCoordinate = startCoord
        let goalCoordinate = goalCoord
        let bounds = GMSCoordinateBounds(coordinate: startCoordinate, coordinate: goalCoordinate)
        let cameraUpdate = GMSCameraUpdate.fit(bounds, withPadding: 80.0)
        myView.mapView.moveCamera(cameraUpdate)
    }
}

extension NavitimeSearchResultMapViewController: MyNavitimeSegementSlideVCDelegate{
    
    //表示されている経路に合わせて地図を変更する
    func didChangeView(to config: SearchResultViewConfig) {
        setUpView(config: config)
    }
    func floatHalf(){
        if fpc?.state == .full{
        fpc?.move(to: .half, animated: true)
        }
    }
    func floatFull(){
        if fpc?.state == .half{
        fpc?.move(to: .full, animated: true)
        }
    }
}

class MyFloatingPanelLayout: FloatingPanelLayout{
    
    var position: FloatingPanelPosition = .bottom
    var initialState: FloatingPanelState = .tip
    var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring]{
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 10.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 180.0, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 50.0, edge: .bottom, referenceGuide: .safeArea)]
    }
}
