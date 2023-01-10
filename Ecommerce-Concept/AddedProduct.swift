//
//  AddedProduct.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 10.01.2023.
//

import RealmSwift

class AddedProduct: Object {
    @Persisted var title: String
    @Persisted var id: String
    @Persisted var image: String
}
