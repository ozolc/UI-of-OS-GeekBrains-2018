//
//  VKServices.swift
//  gbVkontakte
//
//  Created by NosovML on 13/02/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class VKServices {
    
    static let sharedManager: SessionManager = {
        let config = URLSessionConfiguration.default
        
        config.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        config.timeoutIntervalForRequest = 40
        
        let manager = Alamofire.SessionManager(configuration: config)
        return manager
    }()
    
    static func getFriends() {
        let path = "/method/friends.get"
        let url = Data.baseUrl + path
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "order": "name",
            "fields": "photo_200_orig",
            "v": Data.versionAPI
        ]
        
        VKServices.sharedManager.request(url, method: .get, parameters: params).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let users = json["response"]["items"].arrayValue.map { User(json: $0) }
                
                users.forEach { print($0) }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getPhotos() {
        let path = "/method/photos.getAll"
        let url = Data.baseUrl + path
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "photo_sizes": 1,
            "no_service_albums": 0,
            "v": Data.versionAPI
        ]
        
        VKServices.sharedManager.request(url, method: .get, parameters: params).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let photos = json["response"]["items"].arrayValue.map { Photo(json: $0) }
                
                photos.forEach { print($0) }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
