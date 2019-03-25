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
    
    // Получение списка друзей
    public func getFriends(photos: [Photo] = [], completion: @escaping ([User]) -> Void) {
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
                let users = json["response"]["items"].arrayValue.map { User(json: $0, photos: photos) }
                completion(users)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // Получение списка фото
    public func getPhotos(for id: Int, completion: @escaping ([Photo]) -> Void) {
        //    public func getPhotos(for id: Int = Session.shared.userId, completion: @escaping ([Photo]) -> Void) {
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
                //            case .success(let value):
                //                let json = JSON(value)
                //                let photos = json["response"]["items"].arrayValue.map { Photo(json: $0) }.filter { !$0.url.isEmpty }
                //                completion(photos)
                
            case .success(let value):
                let json = JSON(value)
                var photos = json["response"]["items"].arrayValue.map { json in
                    return Photo(json: json)
                }
                var sortPhoto: [Photo] = []
                for photo in photos {
                    if photo.url != "" {
                        sortPhoto.append(photo)
                    }
                }
                photos = sortPhoto
                completion(photos)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    // Получение списка групп
    public func getGroups(completion: @escaping ([Group]) -> Void) {
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
                let groups = json["response"]["items"].arrayValue.map { json in
                    return Group(json: json)
                }
                completion(groups)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // Получение списка новостей
    public func getNews(completion: @escaping ([Items]) -> Void) {
        //    public func getNews() {
        let path = "/method/newsfeed.get"
        let url = Data.baseUrl + path
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "filters": "post",
            //            "count": 5,
            "v": Data.versionAPI
        ]
        
        VKServices.sharedManager.request(url, method: .get, parameters: params).responseJSON { response in
            
            //            let json = JSON(value)
            //            var photos = json["response"]["items"].arrayValue.map { json in
            //                return Photo(json: json)
            //            }
            //            var sortPhoto: [Photo] = []
            //            for photo in photos {
            //                if photo.url != "" {
            //                    sortPhoto.append(photo)
            //                }
            //            }
            //            photos = sortPhoto
            //            completion(photos)
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                var items = json["response"]["items"].arrayValue.map { json in
                    return Items(json: json)
                }
                
                for item in items {
                    items.append(item)
                }
                completion(items)
                
            case .failure(let error):
                print(error)
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
