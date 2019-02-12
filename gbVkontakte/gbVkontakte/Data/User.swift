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

//Список ваших друзей:
//{
//    response =     {
//        count = 10;
//        items =         (
//            {
//                "first_name" = "\U0410\U043b\U0435\U043a\U0441\U0430\U043d\U0434\U0440";
//                id = 473700777;
//                "last_name" = "\U0411\U0430\U0440\U043a\U043e\U0432";
//                nickname = "";
//                online = 0;
//                status = "";
//            }
//        );
//    };
//}

