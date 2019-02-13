//
//  WKWebView+Extension.swift
//  gbVkontakte
//
//  Created by NosovML on 13/02/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation
import WebKit

extension WKWebView {
    
    func cleanAllCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
//        print("All cookies deleted")
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
//                print("Cookie ::: \(record) deleted")
            }
        }
    }
    
    func refreshCookies() {
        self.configuration.processPool = WKProcessPool()
    }
}
