//
//  GetPhotosVK.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 09/02/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation
import Alamofire

class GetPhotosVK {
    static func sendRequest() {
        let baseUrl = Data.baseUrl
        let path = "/method/photos.getAll"
        let url = baseUrl+path
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "photo_sizes": 1,
            "no_service_albums": 0,
            "v": Data.versionAPI
        ]
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { response in
            guard let value = response.value else { return }
            print("Список ваших фото:\n", value)
        }
        
    }
}
