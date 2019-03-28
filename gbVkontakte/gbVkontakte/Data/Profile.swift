//
//  Profile.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 28/03/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Profile: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var first_name = ""
    @objc dynamic var last_name = ""
    @objc dynamic var photo_50 = ""
    
    required convenience init(json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.first_name = json["first_name"].stringValue
        self.last_name = json["last_name"].stringValue
        self.photo_50 = json["photo_50"].stringValue
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
}

