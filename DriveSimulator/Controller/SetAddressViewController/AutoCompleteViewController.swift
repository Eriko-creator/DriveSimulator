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
    private let placeAction = PlaceAction.shared
    

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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        //処理を行う
        let place = Place(placeName: place.name ?? "", lat: place.coordinate.latitude, lng: place.coordinate.longitude)
        placeAction.setPlaceName(place: place)
        dismiss(animated: true, completion: nil)
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
