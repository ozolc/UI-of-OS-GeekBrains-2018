//
//  GetGroupsByRequest.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 09/02/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation
import Alamofire

protocol GetGroupsByRequestDelegate: class {
    func searchGroup(query: String)
}

class GetGroupsByRequest {
    
    public weak var delegate: GetGroupsByRequestDelegate?
    
//    static func sendRequest(query: String) {
//
//
//    }
    
    public func searchGroup(query: String) {
        let baseUrl = Data.baseUrl
        let path = "/method/groups.search"
        let url = baseUrl+path
        
        let parameters: Parameters = [
            "access_token": Session.shared.token,
            "q": query,
            "v": Data.versionAPI
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            guard let value = response.value else { return }
            print("Список групп по запросу \"\(query)\":", value)
            
//            guard let value = response.value else { return }
//            print("Список групп по запросу \"\(query)\":")
        }
    }
}
