//
//  FriendsTableViewCell.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 30/12/2018.
//  Copyright © 2018 Maksim Nosov. All rights reserved.
//

import UIKit
import Kingfisher

class FriendsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var friendImageView: AvatarImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var outerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    public func configure(with user: User) {
        friendNameLabel.text = "\(user.first_name) \(user.last_name)"
        friendImageView.kf.setImage(with: URL(string: user.avatar))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    


}
