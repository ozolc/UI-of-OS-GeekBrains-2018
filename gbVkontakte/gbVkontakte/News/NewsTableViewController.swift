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
    private var notificationToken: NotificationToken?
    private let operationQ = OperationQueue()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        synchronizeTableAndRealm()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        guard let realm = try? Realm() else { return }
        news = realm.objects(News.self)
        
        vkService.getNews() { news, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let news = news {
                RealmProvider.save(items: news)
                
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
        }
        
    }
    
    private func synchronizeTableAndRealm() {
        guard let realm = try? Realm() else { return }
        news = realm.objects(News.self)
        
        notificationToken = news?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .none)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .none)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .none)
                tableView.endUpdates()
                break
            case .error(let error):
                fatalError("\(error)")
                break
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


