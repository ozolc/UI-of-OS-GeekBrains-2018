//
//  ActionOnVKController.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 09/02/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class ActionOnVKController: UIViewController {

    @IBOutlet weak var searchGroupTextField: UITextField!
    let groupsByRequest = GetGroupsByRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupsByRequest.delegate = self
        self.searchGroupTextField.delegate = self
    }
    
    @IBAction func getFriendsPressed(_ sender: Any) {
//        GetFriendsVK.sendRequest()
        GetFriendsVK.getFriend()
    }
    
    @IBAction func getphotosPressed(_ sender: Any) {
        GetPhotosVK.sendRequest()
    }
    
    @IBAction func getGroupsPressed(_ sender: Any) {
        GetGroupsVK.sendRequest()
    }
    
    @IBAction func searchGroupByRequestPressed(_ sender: Any) {
        searchButtonPressed()
        searchGroupTextField.text = ""
    }
    
}

extension ActionOnVKController {
    // Алерт для сообщения об ошибке
    public func showErrorMessage(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        // Добавляем кнопку на UIAlertController
        alert.addAction(action)
        
        // Отображаем UIAlertController
        present(alert, animated: true)
        
        DispatchQueue.main.async {
            self.searchGroupTextField.becomeFirstResponder()
        }
    }
}

extension ActionOnVKController: GetGroupsByRequestDelegate {
    func searchGroup(query: String) {}
}

extension ActionOnVKController: UITextFieldDelegate {
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButtonPressed()
        textField.text = ""
        return true
    }
    
    private func searchButtonPressed() {
        guard let text = searchGroupTextField.text else { return }
        
        if searchGroupTextField.text != "" {
            groupsByRequest.searchGroup(query: text)
        } else {
            showErrorMessage(title: "Ошибка", message: "Неверные данные для запроса")
        }
    }
}
