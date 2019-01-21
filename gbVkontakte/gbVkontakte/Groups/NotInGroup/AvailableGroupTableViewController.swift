//
//  NotInGroupTableViewController.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 30/12/2018.
//  Copyright © 2018 Maksim Nosov. All rights reserved.
//

import UIKit

class AvailableGroupTableViewController: UITableViewController {
    
    //    @IBOutlet weak var searchBar: UISearchBar!
    //
    //    var notInGroupsNameArray: [String] = []
    //
    //    var notInGroupsImagesArray: [UIImage] = []
    //
    //    var searchNotInGroupNameArray = [String]()
    //    var searchNotInGroupImageArray = [UIImage]()
    //    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Доступные группы"
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableGroups.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableGroupCell", for: indexPath)
            as! AvailableGroupTableViewCell
        
        availableGroups.sort()
        let group = availableGroups[indexPath.row]
        
        cell.NotInGroupLabel.text = group
        
        let border = UIView()
        border.frame = cell.NotInGroupImageView.bounds
        border.layer.cornerRadius = cell.NotInGroupImageView.bounds.height / 2
        border.layer.masksToBounds = true
        cell.NotInGroupImageView.addSubview(border)
        
        let newGroupAvatar = UIImageView()
        newGroupAvatar.image = UIImage(named: group)
        newGroupAvatar.frame = border.bounds
        border.addSubview(newGroupAvatar)
        return cell
    }
    
}
