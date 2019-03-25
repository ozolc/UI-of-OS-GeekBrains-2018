//
//  NewsTableViewController.swift
//  gbVkontakte
//
//  Created by NosovML on 21/01/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class NewsTableViewController: UITableViewController {
    
    private let vkService = VKServices()
    var items: Results<Items>?
    
    let newsTexts = [String](News.news.keys)
    let newsImages = [String](News.news.values)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        do {
            let realm = try Realm(configuration: config)
            self.items = realm.objects(Items.self)
        } catch {
            print(error)
        }
        
//        items = RealmProvider.get(Items.self)
        
        vkService.getNews() { [weak self] items in
            RealmProvider.save(items: items)
            
            DispatchQueue.main.async {
                self?.tableView?.reloadData()
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //        return newsTexts.count
        return items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        
        if let items = items {
            cell.configure(with: items[indexPath.row])
        }
        
        return cell
    }
    
    @IBAction func back() {
        Data.clearCookies()
        self.dismiss(animated: true, completion: nil)
    }
    
}


