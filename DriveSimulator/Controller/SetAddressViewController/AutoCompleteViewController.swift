//
//  AutoCompleteViewController.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/01/27.
//

import UIKit
import GooglePlaces

class AutoCompleteViewController: UIViewController {

    private var tableView: UITableView?
    private var tableDataSource: GMSAutocompleteTableDataSource?
    private let placeAction = PlaceAction.shared
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //tableDataSourceのデリゲートを設定
        tableDataSource = GMSAutocompleteTableDataSource()
        tableDataSource?.delegate = self
        //tableViewの設定
        tableView = UITableView(frame: self.view.bounds)
        tableView?.delegate = tableDataSource
        tableView?.dataSource = tableDataSource
        if let tableView = tableView{
        view.addSubview(tableView)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension AutoCompleteViewController: SetAddressViewControllerDelegate{
    func startAutoComplete(text: String) {
        tableDataSource?.sourceTextHasChanged(text)
    }
}

extension AutoCompleteViewController: GMSAutocompleteTableDataSourceDelegate{
    
    func didUpdateAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        tableView?.reloadData()
    }
    
    func didRequestAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        tableView?.reloadData()
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        true
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {
        //選んだ地名に対する処理を行う
        let place = Place(placeName: place.name ?? "", lat: place.coordinate.latitude, lng: place.coordinate.longitude, address: place.formattedAddress ?? "")
        //placeの値を渡す
        placeAction.place = place
        placeAction.setPlaceName() {
            setCompletion()
        }
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    private func setCompletion(){
        guard let parentVC = parent as? SetAddressViewController else {return}
        switch placeAction.action{
        case .select:
            parentVC.dismiss(animated: true, completion: nil)
        case .save:
            guard let savePointVC = parentVC.storyboard?.instantiateViewController(withIdentifier: "savePoint") as? SavePointViewController else {return}
            parentVC.navigationController?.pushViewController(savePointVC, animated: true)
        }
    }
}
