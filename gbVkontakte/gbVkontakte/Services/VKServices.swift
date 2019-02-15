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
import RealmSwift

class VKServices {
    
    static let sharedManager: SessionManager = {
        let config = URLSessionConfiguration.default
        
        config.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        config.timeoutIntervalForRequest = 40
        
        let manager = Alamofire.SessionManager(configuration: config)
        return manager
    }()
    
    public func getFriends(completion: (([User]?, Error?) -> Void)? = nil) {
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
//                users.forEach { print($0) }
                completion?(users, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    public func getPhotos(for id: Int = Session.shared.userId, completion: (([Photo]?, Error?) -> Void)? = nil) {
        let path = "/method/photos.getAll"
        let url = Data.baseUrl + path
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "photo_sizes": 1,
            "no_service_albums": 0,
            "owner_id": id,
            "v": Data.versionAPI
        ]
        
        VKServices.sharedManager.request(url, method: .get, parameters: params).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let photos = json["response"]["items"].arrayValue.map { Photo(json: $0) }
//                photos.forEach { print($0) }
                completion?(photos, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    public func getGroups(completion: (([Group]?, Error?) -> Void)? = nil) {
        let path = "/method/groups.get"
        let url = Data.baseUrl + path
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "extended": 1,
            "v": Data.versionAPI
        ]
        
        VKServices.sharedManager.request(url, method: .get, parameters: params).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let groups = json["response"]["items"].arrayValue.map { Group(json: $0) }
//                groups.forEach { print($0) }
                completion?(groups, nil)
                
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    // Сохранение данных в Realm
    private func saveToRealm<T: Object>(_ data: [T]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(data)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
