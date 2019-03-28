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

class News: Object, Decodable {
    
    @objc dynamic var id = 0
    @objc dynamic var postId = 0
    @objc dynamic var text = ""
    @objc dynamic var likes = 0
    @objc dynamic var comments = 0
    @objc dynamic var reposts = 0
    @objc dynamic var views = 0
    @objc dynamic var photo = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case postId
        case text
        case likes
        case comments
        case reposts
        case views
        case photo
    }
    
    required convenience init(json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.postId = json["post_id"].intValue
        self.text = json["text"].stringValue
        self.likes = json["likes"]["count"].intValue
        self.comments = json["comments"]["count"].intValue
        self.reposts = json["reposts"]["count"].intValue
        self.views = json["views"]["count"].intValue
        self.photo = json["photos"]["src"].stringValue
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
}
