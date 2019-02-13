//
//  Constants.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 20/12/2018.
//  Copyright © 2018 Maksim Nosov. All rights reserved.
//

import Foundation
import UIKit
import WebKit

struct Data {
    
    static let shared = Data()
    
    static let login = ""
    static let password = ""
    static let background = UIColor(red: 51/255, green: 51/255, blue: 54/255, alpha: 0)
    static let versionAPI = "5.85"
    static let baseUrl = "https://api.vk.com"
    static let clientID = "6853611"
    
    static func clearCookies() {
//        Remove Cookie from HTTPCookieStorage
        let webView = LoginWKWebViewController()
        
//        Fetch data records from WKWebsiteDataStore and delete them.
        webView.cleanAllCookies()
        
//        Create a new WKProcessPool
        webView.refreshCookies()
        
        Session.shared.token = ""
        Session.shared.userId = 0
    }
}
