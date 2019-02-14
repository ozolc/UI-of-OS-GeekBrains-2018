//
//  FriendCollectionViewController.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 30/12/2018.
//  Copyright © 2018 Maksim Nosov. All rights reserved.
//

import UIKit

class FriendCollectionViewController: UICollectionViewController {
    
    private let vkService = VKServices()
    public var photos = [Photo]()
    
    var friendID = Session.shared.userId
    
     lazy var friendImage: UIImage = UIImage()
     lazy var friendName: String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = friendName
        
        vkService.getPhotos(for: self.friendID) { [weak self] photos, error in
            if let error = error {
                print(error)
                return
            } else if let photos = photos, let self = self {
                self.photos = photos
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
//        let numberOfItems = [String]((Friends.allFriends[friend]?.keys)!).count
//        return numberOfItems
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCell", for: indexPath) as! FriendCollectionViewCell
    
//        let foto = [String]((Friends.allFriends[friend]?.keys)!)
//        print(foto)
        
//        cell.friendImageView.image = UIImage(named: foto[indexPath.row])
        
//        cell.friendImageView.image = self.friendImage
//        cell.friendNameLabel.text = self.friendName
        cell.configure(with: photos[indexPath.row])
    
        return cell
    }

}
