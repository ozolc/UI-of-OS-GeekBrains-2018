//
//  FriendCollectionViewCell.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 30/12/2018.
//  Copyright © 2018 Maksim Nosov. All rights reserved.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {
//    var friends = Friends()
    
    @IBOutlet weak var friendImageView: UIImageView!
    
    public func configure(with photo: Photo) {
        friendImageView.kf.setImage(with: URL(string: photo.url))
    }
    
}
