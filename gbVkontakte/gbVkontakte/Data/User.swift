//
//  User.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 12/02/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User: Codable, CustomStringConvertible {
    var description: String {
        return "\(id) \(first_name) \(last_name) \(avatar)"
    }
    
    let id: Int
    let first_name: String
    let last_name: String
    let avatar: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.first_name = json["first_name"].stringValue
        self.last_name = json["last_name"].stringValue
        self.avatar = json["photo_200_orig"].stringValue

    }
}
