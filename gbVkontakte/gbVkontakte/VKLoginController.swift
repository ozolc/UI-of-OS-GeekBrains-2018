//
//  VKLoginController.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 09/02/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import FirebaseAuth
import FirebaseDatabase

class VKLoginController: UIViewController {
    
//    private var groups = [FirebaseGroups]()
    
    private let vkService = VKServices()
    private var baseRef: DatabaseReference!
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorizeOnVK()
    }
    
    private func authorizeOnVK() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Data.clientID),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.85")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
    }
    
}

extension VKLoginController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment  else {
                decisionHandler(.allow)
                return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        guard let token = params["access_token"], let userId = Int(params["user_id"]!) else {
            decisionHandler(.cancel)
            return
        }
        
        Session.shared.token = token
        Session.shared.userId = userId
        
        Auth.auth().signInAnonymously { (authResult, error) in
            if let error = error {
                self.show(error)
            } else {
                guard let authResult = authResult else { return }
                let user = authResult.user
                let isAnonymous = user.isAnonymous
                let uid = user.uid
                print(uid)
                print(isAnonymous)
            }
        }
        
        baseRef = Database.database().reference(withPath: "users")
        addDataToFirebase()
        
        performSegue(withIdentifier: "VKLogin", sender: nil)
        decisionHandler(.cancel)
    }
    
    private func addDataToFirebase() {
        vkService.getGroups() { [unowned self] groups in
            var groupsFirebaseArray = [FirebaseGroups]()
            
            let userId = String(describing: Session.shared.userId)
            let groupRef = self.baseRef.child(userId.lowercased())
            
            // Создание массива с группами
            for group in groups {
                let groupFirebase = FirebaseGroups(id: group.id, name: group.name)
                print(groupFirebase.name)
                groupsFirebaseArray.append(groupFirebase)
            }
            
            // Добавление названия групп пользователя в разрезе их ID
            for child in groupsFirebaseArray {
                let groupId = String(describing: child.id)
                let groupIDRef = groupRef.child(groupId.lowercased())
                groupIDRef.setValue(child.toAnyObject())
            }
        }
    }
    
}
