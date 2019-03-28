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
    public func getNews(completion: (([News]?, Error?) -> Void)? = nil) {
        let path = "/method/newsfeed.get"
        let url = Data.baseUrl + path
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "filters": "post",
            "count": 30,
            "v": Data.versionAPI
        ]
        
        VKServices.sharedManager.request(url, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let news = json["response"]["items"].arrayValue.map { News(json: $0) }.filter {!$0.postText.isEmpty }
                let newsProfiles = json["response"]["profiles"].arrayValue.map { User(json: $0) }
                let newsGroups = json["response"]["groups"].arrayValue.map { Group(json: $0) }
                
                for i in 0..<news.count {
                    if news[i].postSource_id < 0 {
                        for ii in 0..<newsGroups.count {
                            if news[i].postSource_id * -1 == newsGroups[ii].id {
                                news[i].titlePostId = newsGroups[ii].id
                                news[i].titlePostLabel = newsGroups[ii].name
                                news[i].titlePostPhoto = newsGroups[ii].photo
                            }
                        }
                    } else {
                        for iii in 0..<newsProfiles.count {
                            if news[i].postSource_id == newsProfiles[iii].id {
                                news[i].titlePostId = newsProfiles[iii].id
                                news[i].titlePostLabel = newsProfiles[iii].fullName
                                news[i].titlePostPhoto = newsProfiles[iii].avatar
                            }
                        }
                    }
                }
//                print(news)
                completion?(news, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
}
