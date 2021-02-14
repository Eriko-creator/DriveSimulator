//
//  FavoriteTableViewDataSource.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/09.
//

import Foundation
import UIKit
import RealmSwift

final class FavoriteTableViewDataSource: NSObject, UITableViewDataSource{
    
    override init(){
        print("favoriteModel生成")
    }
    deinit {
        print("favoriteModel解放")
    }
    
//MARK: TableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getObjectCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Cell()
        cell.imageIcon.image = UIImage(named: "favoriteCell")
        //realmデータのplaceNameをラベルに表示する
        cell.placeNameLabel.text = getPlaceName()
        return cell
    }
    
    private func getObjectCount()->Int{
        
        do{
            let realm = try Realm()
            let favorite = realm.objects(Favorite.self)
            return favorite.count
            
        }catch{
            print(error)
        }
        return 0
    }
    
    private func getPlaceName()->String{
        
        do{
            let realm = try Realm()
            let favorites = realm.objects(Favorite.self)
            for favorite in favorites {
                print(favorite.placeName)
                return favorite.placeName
            }
        }catch{
            print(error)
        }
        return ""
    }
}
