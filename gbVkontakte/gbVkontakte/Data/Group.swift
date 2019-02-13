//
//  Group.swift
//  gbVkontakte
//
//  Created by NosovML on 13/02/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Group: Codable, CustomStringConvertible {
    var description: String {
        return "\(id) \(name) \(photo)"
    }
    
    let id: Int
    let name: String
    let photo: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo = json["photo_200"].stringValue
    }
}
