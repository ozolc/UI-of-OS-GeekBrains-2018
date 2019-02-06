//
//  Session.swift
//  gbVkontakte
//
//  Created by NosovML on 06/02/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation

class Session {
    
    static let shared = Session()
    
    var token: String = ""
    var userId: Int = 0
    
    private init() {}
    
}
