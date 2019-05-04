//
//  Category.swift
//  Todoey
//
//  Created by Rajat Jain on 19/04/19.
//  Copyright © 2019 Rajat Jain. All rights reserved.
//

import Foundation
import RealmSwift
class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
