//
//  Items.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 24/03/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//
import Foundation
import SwiftyJSON
import RealmSwift

class Items: Object, Decodable {
    
    @objc dynamic var id = 0
    @objc dynamic var reposts = 0
    @objc dynamic var likes = 0
    @objc dynamic var text = ""
    @objc dynamic var photo = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case reposts
        case likes
        case text
        case photo
    }
    
    required convenience init(json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.reposts = json["reposts"]["count"].intValue
        self.likes = json["likes"]["count"].intValue
        self.text = json["text"].stringValue
        self.photo = json["photos"]["src"].stringValue
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
}
