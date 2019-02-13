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

//{
//    response =     {
//        count = 11;
//        items =         (
//            {
//                id = 27168444;
//                "is_admin" = 0;
//                "is_advertiser" = 0;
//                "is_closed" = 0;
//                "is_member" = 1;
//                name = "\U042f\U043d\U0434\U0435\U043a\U0441.\U041c\U0443\U0437\U044b\U043a\U0430";
//                "photo_100" = "https://sun4-1.userapi.com/c840637/v840637995/6de18/x-es6WS-gew.jpg?ava=1";
//                "photo_200" = "https://sun4-2.userapi.com/c840637/v840637995/6de17/Kj6dPewUA6U.jpg?ava=1";
//                "photo_50" = "https://sun4-1.userapi.com/c840637/v840637995/6de19/U7lmn40YHho.jpg?ava=1";
//                "screen_name" = yandexmusic;
//                type = page;
//        },
