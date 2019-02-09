//
//  ActionOnVKController.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 09/02/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class ActionOnVKController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func getFriendsPressed(_ sender: Any) {
        GetFriendsVK.sendRequest()
    }
    
    @IBAction func getphotosPressed(_ sender: Any) {
        GetPhotosVK.sendRequest()
    }
    
    @IBAction func getGroupsPressed(_ sender: Any) {
        GetGroupsVK.sendRequest()
    }
    
}
