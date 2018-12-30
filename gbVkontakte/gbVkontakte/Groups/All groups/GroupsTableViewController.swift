//
//  TableViewController02.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 20/12/2018.
//  Copyright © 2018 Maksim Nosov. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    lazy var groupsNameArray: [String] = [
        "Коллеги",
        "Друзья",
        "Семья",
        "Другое"
    ]
    
    lazy var notInGroupsNameArray: [String] = []
    
    lazy var groupsImagesArray: [UIImage] = [
        UIImage(named: "collegues.png")!,
        UIImage(named: "friendship.png")!,
        UIImage(named: "family.png")!,
        UIImage(named: "other.png")!
    ]
    
    lazy var notInGroupsImagesArray: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsNameArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsTableViewCell
        
        // Получаем список групп для конкретной строки
        cell.GroupImage.image = groupsImagesArray[indexPath.row]
        cell.GroupName.text = groupsNameArray[indexPath.row]
        
        return cell
    }

    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Если была нажата кнопка "Удалить"
        if editingStyle == .delete {
        
            // Дробавляем во временный массив и удаляем группу в которой не состоит пользователь
            notInGroupsNameArray.append(groupsNameArray[indexPath.row])
            groupsNameArray.remove(at: indexPath.row)
            
            notInGroupsImagesArray.append(groupsImagesArray[indexPath.row])
            groupsImagesArray.remove(at: indexPath.row)
        
            // И удаляем строку из таблицы
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "notInGroupSegue" {
            let nextScene = segue.destination as? NotInGroupTableViewController
            nextScene?.notInGroupsImagesArray = self.notInGroupsImagesArray
            nextScene?.notInGroupsNameArray = self.notInGroupsNameArray
        }
    }
    
    

}
