//
//  FavoriteTableViewController.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/08.
//

import UIKit
import RealmSwift
import DZNEmptyDataSet

class FavoriteTableViewController: UIViewController {

    weak var dataSource: FavoriteTableViewDataSource?
    private let placeAction = PlaceAction.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpFavoriteTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpFavoriteTableView(){
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .plain)

        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.tableFooterView = UIView()
        
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        
        view.addSubview(tableView)
    }
}

extension FavoriteTableViewController: UITableViewDelegate{
    
    //セルをタップした時setPlaceNameメソッド発動
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell: Cell = tableView.cellForRow(at: indexPath) as? Cell else {return}
        placeAction.place = setPlace(placeName: cell.placeNameLabel.text ?? "")
        placeAction.setPlaceName {}
        
    }
    
    private func setPlace(placeName:String)->Place{
        
        do{
            let realm = try Realm()
            if let favorite = realm.objects(Favorite.self).filter("placeName == \(placeName)").first,
               let location = favorite.location.first {
                
                let place = Place(placeName: placeName, lat: location.lat, lng: location.lng)
                return place
            }
        }catch{
            print(error)
        }
        //returnしたくない
        return Place(placeName: "", lat: 0.0, lng: 0.0)
    }
}
extension FavoriteTableViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "検索履歴がありません"
        let attributes: [NSAttributedString.Key: Any] =
            [.font: UIFont.systemFont(ofSize: 20),
             .foregroundColor: UIColor.black]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "noHistory")
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor(displayP3Red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -200
    }
}
