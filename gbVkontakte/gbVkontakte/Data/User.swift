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

class User: Object, Codable {
    override var description: String {
        return "\(id) \(first_name) \(last_name) \(avatar)"
    }
    
    @objc dynamic var id = 0
    @objc dynamic var first_name = ""
    @objc dynamic var last_name = ""
    @objc dynamic var avatar = ""
    
    required convenience init(json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.first_name = json["first_name"].stringValue
        self.last_name = json["last_name"].stringValue
        self.avatar = json["photo_200_orig"].stringValue
    }
}
