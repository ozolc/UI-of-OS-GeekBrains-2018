//
//  TableViewController01.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 20/12/2018.
//  Copyright © 2018 Maksim Nosov. All rights reserved.
//

import UIKit

class FriendsViewController: UITableViewController {
    
    let friendsNameArray: [String] = [
        "Казаков Андрей",
        "Федотов Александр",
        "Михайлова Юлия",
        "Свиридова Оксана"
    ]
    
    let friendsImagesArray: [UIImage] = [
        UIImage(named: "friend00.png")!,
        UIImage(named: "friend01.png")!,
        UIImage(named: "friend02.png")!,
        UIImage(named: "friend03.png")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friendsNameArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
        
        // Получаем список друзей для конкретной строки
        cell.friendNameLabel.text = friendsNameArray[indexPath.row]
        cell.friendImageView.image = friendsImagesArray[indexPath.row]
        return cell
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "friendSeque",
            let nextScene = segue.destination as? FriendCollectionViewController,
            let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedFriendImage = friendsImagesArray[indexPath.row]
            nextScene.friendImage = selectedFriendImage
            let selectedFriendName = friendsNameArray[indexPath.row]
            nextScene.friendName = selectedFriendName
        }
    }
    
    
}
