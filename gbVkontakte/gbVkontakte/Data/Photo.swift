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

//{
//    response =     {
//        count = 223;
//        items =         (
//            {
//                "album_id" = "-7";
//                date = 1543944669;
//                id = 456239685;
//                "owner_id" = 1805234;
//                sizes =                 (
//                    {
//                        height = 96;
//                        type = m;
//                        url = "https://pp.userapi.com/c846121/v846121042/148ecb/G_qmVMAS1z0.jpg";
//                        width = 130;
//                }
//                );
//                text = "";
