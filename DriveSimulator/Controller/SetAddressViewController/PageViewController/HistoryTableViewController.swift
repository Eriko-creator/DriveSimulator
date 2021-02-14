//
//  HistoryTableViewController.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/08.
//

import UIKit
import RealmSwift
import DZNEmptyDataSet

class HistoryTableViewController: UIViewController {

    weak var dataSource: HistoryTableViewDataSource?
    private let placeAction = PlaceAction.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpTableView(){
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        view.addSubview(tableView)
    }

}
extension HistoryTableViewController: UITableViewDelegate{
    
    //セルをタップした時setPlaceNameメソッド発動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell: Cell = tableView.cellForRow(at: indexPath) as? Cell else {return}
        let place = setPlace(placeName: cell.placeNameLabel.text ?? "")
        //placeの値を渡す
        placeAction.place = place
        placeAction.setPlaceName() {
            parent?.dismiss(animated: true, completion: nil)
        }
    }
    
    private func setPlace(placeName:String)->Place{
        
        do{
            let realm = try Realm()
            if let history = realm.objects(History.self).filter("placeName == \(placeName)").first,
               let location = history.location.first {
                
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

//履歴がない時に表示する画像
extension HistoryTableViewController:DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
 
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
