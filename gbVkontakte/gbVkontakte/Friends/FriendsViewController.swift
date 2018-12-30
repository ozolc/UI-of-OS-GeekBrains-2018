//
//  TableViewController01.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 20/12/2018.
//  Copyright © 2018 Maksim Nosov. All rights reserved.
//

import UIKit

class FriendsViewController: UITableViewController {

    var friends = [
        "Chief Cloud": "chiefredcloud.jpg",
        "Jeronimo": "geronimo.jpeg",
        "Sitting Bull": "sitting-bull.jpg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friends.count
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }

}
