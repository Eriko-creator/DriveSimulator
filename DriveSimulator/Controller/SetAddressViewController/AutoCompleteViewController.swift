//
//  AutoCompleteViewController.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/01/27.
//

import UIKit
import GooglePlaces

class AutoCompleteViewController: UIViewController {

    private var tableView: UITableView!
    private var tableDataSource: GMSAutocompleteTableDataSource!
    private var tag: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        //tableDataSourceのデリゲートを設定
        tableDataSource = GMSAutocompleteTableDataSource()
        tableDataSource.delegate = self
        //tableViewの設定
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = tableDataSource
        tableView.dataSource = tableDataSource
        view.addSubview(tableView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //出発地か到着地かのtagを取得
        let parent = self.parent as! SetAddressViewController
        print(parent.tag)
        tag = parent.tag
    }

}
extension AutoCompleteViewController: SetAddressViewControllerDelegate{
    func startAutoComplete(text: String) {
        tableDataSource.sourceTextHasChanged(text)
    }
}

extension AutoCompleteViewController: GMSAutocompleteTableDataSourceDelegate{
    
    func didUpdateAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        tableView.reloadData()
    }
    
    func didRequestAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        tableView.reloadData()
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        true
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {
        //SearchViewのテキストラベルに反映させて画面を閉じる
        let state = SearchModel.State(rawValue: tag)
        state?.setAddress(address: place.name!, VC: self)
        dismiss(animated: true, completion: nil)
        
        print("Place name: \(place.name!)")
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
