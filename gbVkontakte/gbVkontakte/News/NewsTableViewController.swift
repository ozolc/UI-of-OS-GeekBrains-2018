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
    private var news: Results<News>?
    private var profile: Results<Profile>?
    private var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.rowHeight = 250
        
        guard let realm = try? Realm() else { return }
        news = realm.objects(News.self)
        profile = realm.objects(Profile.self)
        
        vkService.getNews() { news, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let news = news {
                RealmProvider.save(items: news)
            }
        }
        
//        vkService.getProfile(completion: { profile in
//            RealmProvider.save(items: profile)
//        })
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //        return newsTexts.count
        return news?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCellId", for: indexPath) as? NewsTableViewCell
        else { return UITableViewCell() }
        
        if let news = news {
            cell.configure(with: news[indexPath.row])
        }
        return cell
    }
    
    @IBAction func back() {
        Data.clearCookies()
        self.dismiss(animated: true, completion: nil)
    }
    
}


