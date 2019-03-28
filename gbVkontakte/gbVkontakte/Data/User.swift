//
//  User.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 12/02/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class User: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var first_name = ""
    @objc dynamic var last_name = ""
    @objc dynamic var fullName = ""
    @objc dynamic var avatar = ""
    var photos = List<Photo>()
    
    required convenience init(json: JSON, photos: [Photo] = []) {
        self.init()
        
        self.id = json["id"].intValue
        self.first_name = json["first_name"].stringValue
        self.fullName = json["last_name"].stringValue + " " + json["first_name"].stringValue
        self.last_name = json["last_name"].stringValue
        self.avatar = json["photo_200_orig"].stringValue
        self.photos.append(objectsIn: photos)
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
}
