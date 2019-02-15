//
//  Group.swift
//  gbVkontakte
//
//  Created by NosovML on 13/02/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Group: Object, Codable {
    override var description: String {
        return "\(id) \(name) \(photo)"
    }
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var photo = ""
    
    required convenience init(json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo = json["photo_200"].stringValue
    }
}
