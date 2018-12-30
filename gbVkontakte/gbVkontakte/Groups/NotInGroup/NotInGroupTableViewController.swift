//
//  NotInGroupTableViewController.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 30/12/2018.
//  Copyright © 2018 Maksim Nosov. All rights reserved.
//

import UIKit

class NotInGroupTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var notInGroupsNameArray: [String] = []
    
    var notInGroupsImagesArray: [UIImage] = []
    
    var searchNotInGroupNameArray = [String]()
    var searchNotInGroupImageArray = [UIImage]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Не в группах"
        //        searchBar.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchNotInGroupNameArray.count
        } else {
            return notInGroupsNameArray.count
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchBar.text?.isEmpty ?? true
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotInGroupCell", for: indexPath)
            as! NotInGroupTableViewCell
        if searching {
            cell.NotInGroupLabel.text = searchNotInGroupNameArray[indexPath.row]
            //            cell.NotInGroupImageView.image = searchNotInGroupImageArray[indexPath.row]
        } else {
            cell.NotInGroupLabel.text = notInGroupsNameArray[indexPath.row]
            cell.NotInGroupImageView.image = notInGroupsImagesArray[indexPath.row]
        }
        return cell
    }
    
}

extension NotInGroupTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchNotInGroupNameArray = notInGroupsNameArray.filter({(text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        searching = true
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
