//
//  TableViewController01.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 20/12/2018.
//  Copyright © 2018 Maksim Nosov. All rights reserved.
//

import UIKit

@IBDesignable class FriendsViewController: UITableViewController {
    
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
    
    // Смещение тени
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 3, height: 3)

    // Прозрачность тени
    @IBInspectable var shadowOpacity: Float = 0.3

    // Радиус блура тени
    @IBInspectable var shadowRadius: CGFloat = 5
    
    // Цвет тени
    @IBInspectable var shadowColor: UIColor = UIColor.black
    
    
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
        
        if let outerView = cell.outerView {
            outerView.clipsToBounds = false
            outerView.layer.shadowColor = self.shadowColor.cgColor
            outerView.layer.shadowOpacity = self.shadowOpacity
            outerView.layer.shadowOffset = self.shadowOffset
            outerView.layer.shadowRadius = self.shadowRadius
            outerView.backgroundColor = UIColor.clear
//            outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: outerView.frame.size.width / 2).cgPath
        }
        
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

extension OuterView {

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }

}
