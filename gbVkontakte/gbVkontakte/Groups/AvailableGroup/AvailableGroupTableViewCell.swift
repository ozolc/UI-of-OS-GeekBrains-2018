//
//  NotInGroupTableViewCell.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 30/12/2018.
//  Copyright © 2018 Maksim Nosov. All rights reserved.
//

import UIKit

class AvailableGroupTableViewCell: UITableViewCell {

    @IBOutlet weak var NotInGroupLabel: UILabel!
    @IBOutlet weak var AvailableGroupImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with group: Group) {
        NotInGroupLabel.text = "\(group.name)"
        AvailableGroupImageView.kf.setImage(with: URL(string: group.photo))
    }

}
