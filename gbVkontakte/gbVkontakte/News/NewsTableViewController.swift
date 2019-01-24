//
//  NewsTableViewController.swift
//  gbVkontakte
//
//  Created by NosovML on 21/01/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    let newsTexts = [String](News.news.keys)
    let newsImages = [String](News.news.values)

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsTexts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        
        cell.newsTextLabel.text = newsTexts[indexPath.row]
        cell.newsImageView.image = UIImage(named: newsImages[indexPath.row])
        //tableView.rowHeight = cell.newsTextLabel.frame.size.height + cell.newsImageView.frame.size.height +  cell.footerStackView.frame.height * 1.9
        
        return cell
    }
    
    
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }

}


