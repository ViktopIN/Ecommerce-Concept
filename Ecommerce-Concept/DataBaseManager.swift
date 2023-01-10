//
//  DataBaseManager.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 10.01.2023.
//

import RealmSwift

let realm = try! Realm()

class DataBaseManager {
    func save(object: AddedProduct) {
       try! realm.write {
           realm.add(object)
        }
    }
}
