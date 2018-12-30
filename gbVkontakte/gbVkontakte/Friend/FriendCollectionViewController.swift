//
//  FriendCollectionViewController.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 30/12/2018.
//  Copyright © 2018 Maksim Nosov. All rights reserved.
//

import UIKit

class FriendCollectionViewController: UICollectionViewController {
    
     lazy var friendImage: UIImage = UIImage()
     lazy var friendName: String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = friendName
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCell", for: indexPath) as! FriendCollectionViewCell
    
        cell.friendImageView.image = self.friendImage
        cell.friendNameLabel.text = self.friendName
    
        return cell
    }

}
