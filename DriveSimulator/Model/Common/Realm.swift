//
//  Realm.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/01/28.
//

import Foundation
import RealmSwift

class History: Object {
    @objc dynamic var placeName = ""
    let location = List<Location>()
}

class Favorite: Object {
    @objc dynamic var placeName = ""
    let location = List<Location>()
}

class Location: Object {
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var lng: Double = 0.0
}
