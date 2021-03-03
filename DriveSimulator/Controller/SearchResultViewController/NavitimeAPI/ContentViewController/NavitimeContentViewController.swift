//
//  RecommendRouteViewController.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/21.
//

import UIKit
import SegementSlide

class NavitimeContentViewController: UIViewController, SegementSlideContentScrollViewDelegate{
    
    private let myView = SearchResultView()
    private let model = SearchResultModel()
    
    override func loadView() {
        super.loadView()
        self.view = myView
    }
    
    var config: SearchResultViewConfig
    init(config: SearchResultViewConfig){
        self.config = config
        print(config)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView(){
        config.getResult(completion: { [unowned self] (direction) in
            print(direction)
            getLabelResult(direction: direction)
            getLineName(direction: direction)
        })
    }
    
    private func getLabelResult(direction: Direction){
        
        let searchQueryMaker = SearchQueryMaker.shared
        guard let items = direction.items.first,
              let carType = searchQueryMaker.carType
        else {return}
        let summary = items.summary
        let sections = items.sections
        let move = summary.move
        //ラベルに反映する
        //料金
        if let fare = move.fare{
            myView.priceLabel.text =
                "ETC\(model.getETCFare(fare: fare, carType: carType))円 (一般\(model.getCashFare(fare: fare, carType: carType))円)"
        }else{
            myView.priceLabel.text = "0円"
        }
        //総距離
        myView.totalDistanceLabel.text = "\(model.formatDistanceToKm(from: move.distance))km"
        //出発地
        myView.startPlaceLabel.text = searchQueryMaker.startPlace?.placeName
        myView.startTimeLabel.text = model.getTime(from: move.fromTime)
        //到着地
        myView.goalPlaceLabel.text = searchQueryMaker.goalPlace?.placeName
        myView.goalTimeLabel.text = model.getTime(from: move.toTime)
        //到着地前の道路情報
        let index = sections.index(before: sections.count-2)
        myView.roadNameLabel.text = sections[index].lineName ?? ""
        //総時間
        myView.timeLabel.text = "\(model.formatTime(from: move.time))"
    }
    
    private func getLineName(direction: Direction){
        
        guard let items = direction.items.first else {return}
        let sections = items.sections
        
        for i in 2..<sections.count-2{
            
            if sections[i].name != nil{
                //途中の道路名をplaceDetailViewに反映して挿入する
                let placeDetailView = PlaceDetailView()
                placeDetailView.placeNameLabel.text = sections[i].name
                placeDetailView.loadNameLabel.text = sections[i-1].lineName ?? ""
                placeDetailView.timeLabel.text = model.getTime(from: sections[i-1].toTime ?? "")
                let stackIndex = myView.routeStackView.arrangedSubviews.count
                myView.routeStackView.insertArrangedSubview(placeDetailView, at: stackIndex-1)
            }
        }
    }
    
    @objc var scrollView: UIScrollView {
        return myView
    }
}
