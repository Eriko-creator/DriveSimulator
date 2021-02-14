//
//  historyTableViewDataSource.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/08.
//

import Foundation
import UIKit
import RealmSwift

class HistoryTableViewDataSource: NSObject, UITableViewDataSource{
    
    override init(){
        print("historyModel生成")
    }
    deinit {
        print("historyModel解放")
    }
    
    
    //realmデータの数だけセルを表示する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getObjectCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Cell()
        cell.imageIcon.image = UIImage(named: "historyCell")
        //realmデータのplaceNameをラベルに表示する
        cell.placeNameLabel.text = getPlaceName()
        return cell
    }
    
    private func getObjectCount()->Int{
        
        do{
            let realm = try Realm()
            let history = realm.objects(History.self)
            return history.count
            
        }catch{
            print(error)
        }
        return 0
    }
    
    private func getPlaceName()->String{
        
        do{
            let realm = try Realm()
            let histories = realm.objects(History.self)
            for history in histories {
                print(history.placeName)
                return history.placeName
            }
        }catch{
            print(error)
        }
        return ""
    }
}
