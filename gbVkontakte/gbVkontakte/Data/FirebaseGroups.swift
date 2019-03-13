//
//  FirebaseGroups.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 06/03/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseGroups {
    let id: Int
    let name: String
    let ref: DatabaseReference?
    
    init(id: Int, name: String) {
        self.ref = nil
        self.id = id
        self.name = name
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? Int,
            let name = value["name"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.id = id
        self.name = name
    }
    
    func toAnyObject() -> [String: Any] {
        return [
//            "id": id,
            "name": name
        ]
    }
}
