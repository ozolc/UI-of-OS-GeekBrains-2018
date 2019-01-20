//
//  TableViewController01.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 20/12/2018.
//  Copyright © 2018 Maksim Nosov. All rights reserved.
//

import UIKit

let friends = Friends()

@IBDesignable class FriendsViewController: UITableViewController {
    
    var friendsNames = [String](Friends.allFriends.keys).sorted()
    var searchedNames = [String]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
//    let friendsNameArray: [String] = [
//        "Казаков Андрей",
//        "Федотов Александр",
//        "Михайлова Юлия",
//        "Свиридова Оксана"
//    ]
//
//    let friendsImagesArray: [UIImage] = [
//        UIImage(named: "friend00.png")!,
//        UIImage(named: "friend01.png")!,
//        UIImage(named: "friend02.png")!,
//        UIImage(named: "friend03.png")!
//    ]
    
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
        
        setupSearchController()
    }
    
    // MARK: - Setup a Search Controller
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Names"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {        
        if isFiltering() {
            return firstLetters(in: searchedNames).count
        } else {
            return firstLetters(in: friendsNames).count
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filterNames(from: searchedNames, in: section).count
        } else {
            return filterNames(from: friendsNames, in: section).count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFiltering() {
            return firstLetters(in: searchedNames)[section]
        } else {
            return firstLetters(in: friendsNames)[section]
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
        
//        if let outerView = cell.outerView {
//            outerView.clipsToBounds = false
//            outerView.layer.shadowColor = self.shadowColor.cgColor
//            outerView.layer.shadowOpacity = self.shadowOpacity
//            outerView.layer.shadowOffset = self.shadowOffset
//            outerView.layer.shadowRadius = self.shadowRadius
//            outerView.backgroundColor = UIColor.clear
//            outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: outerView.frame.size.width / 2).cgPath
        
        
        var filteredFriendsNames = [String]()
        if isFiltering() {
            filteredFriendsNames = filterNames(from: searchedNames, in: indexPath.section)
        } else {filteredFriendsNames = filterNames(from: friendsNames, in: indexPath.section)
        }
        cell.friendNameLabel.text = filteredFriendsNames[indexPath.row]
        
        let border = UIView()
        border.frame = cell.friendImageView.bounds
        border.layer.cornerRadius = cell.friendImageView.bounds.height / 2
        border.layer.masksToBounds = true
        cell.friendImageView.addSubview(border)
        
        let newFriendAvatar = UIImageView()
        newFriendAvatar.image = UIImage(named: "\(filteredFriendsNames[indexPath.row])")        
        
        newFriendAvatar.frame = border.bounds
        border.addSubview(newFriendAvatar)
        
        return cell
        
        // Получаем список друзей для конкретной строки
//        cell.friendNameLabel.text = friendsNameArray[indexPath.row]
//        cell.friendImageView.image = friendsImagesArray[indexPath.row]
//
//
//        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if isFiltering() {
            return firstLetters(in: searchedNames)
        } else {
            return firstLetters(in: friendsNames)
        }
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "friendSeque" {
            let friendFotoController = segue.destination as! FriendCollectionViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                var filteredFriendsNames = [String]()
                if isFiltering() {
                    filteredFriendsNames = filterNames(from: searchedNames ,in: indexPath.section)
                } else {
                    filteredFriendsNames = filterNames(from: friendsNames ,in: indexPath.section)
                }
                friendFotoController.friendName = filteredFriendsNames[indexPath.row]
                if let image = UIImage(named: filteredFriendsNames[indexPath.row]) {
                    friendFotoController.friendImage = image
                }
            }
            //            let indexPath = self.tableView.indexPathForSelectedRow {
            //            let selectedFriendImage = friendsImagesArray[indexPath.row]
            //            nextScene.friendImage = selectedFriendImage
            //            let selectedFriendName = friendsNameArray[indexPath.row]
            //            nextScene.friendName = selectedFriendName
            
            
        }
    }
    
    func filterNames (from names: [String], in section: Int) -> [String] {
        let key = firstLetters(in: names)[section]
        return names.filter {$0.first! == Character(key)}
    }
    
    func firstLetters (in names: [String]) -> [String] {
        let keys = [String](names)
        var firstLetters: [String] = []
        for key in keys {
            firstLetters.append(String(key.first!))
        }
        return Array(Set(firstLetters)).sorted()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        searchedNames = friendsNames.filter({( name ) -> Bool in
            return name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
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

extension FriendsViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
