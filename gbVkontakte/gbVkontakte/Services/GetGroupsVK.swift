//
//  GetGroupsVK.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 09/02/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation
import Alamofire

class GetGroupsVK {
    static func sendRequest() {
        
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.get"
        let url = baseUrl+path
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "extended": 1,
            "v": "5.85"
        ]
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { response in
            guard let value = response.value else { return }
            print("Список ваших групп:\n", value)
        }
        
    }
}
