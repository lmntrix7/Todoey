//
//  Item.swift
//  Todoey
//
//  Created by Rajat Jain on 19/04/19.
//  Copyright © 2019 Rajat Jain. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
