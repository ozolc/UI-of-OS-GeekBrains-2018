//
//  Photo.swift
//  gbVkontakte
//
//  Created by NosovML on 13/02/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Photo: Codable, CustomStringConvertible {
    var description: String {
        return "\(id) \(url)"
    }
    
    let id: Int
    let url: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.url = json["sizes"][3]["url"].stringValue
    }
}
