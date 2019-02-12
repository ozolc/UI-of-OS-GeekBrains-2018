//
//  GetAllFriendsVK.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 09/02/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GetFriendsVK {
    
    let baseUrl = Data.baseUrl
    let path = "/method/friends.get"
    
    
    static let sharedManager: SessionManager = {
        let config = URLSessionConfiguration.default
        
        config.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        config.timeoutIntervalForRequest = 40
        
        let manager = Alamofire.SessionManager(configuration: config)
        return manager
    }()
    
    public func sendRequest() {
        let url = baseUrl+path
        
        Alamofire.request(url).responseJSON { response in
            guard let value = response.value else { return }
            print("Список ваших друзей:\n", value)
        }
        
//        Alamofire.request(url, method: .get, parameters: params).responseJSON { response in
//            guard let value = response.value else { return }
//            print("Список ваших друзей:\n", value)
//        }
    }
    
    static func getFriend() {
        let baseUrl = Data.baseUrl
        let path = "/method/friends.get"
        let url = baseUrl+path
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "order": "name",
            "fields": "photo_200_orig",
            "v": Data.versionAPI
        ]
        
        GetFriendsVK.sharedManager.request(url, method: .get, parameters: params).responseJSON { response in
        
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
