//
//  ActivityIndicatorView.swift
//  gbVkontakte
//
//  Created by NosovML on 24/01/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 1.0
        self.frame.size.width = 25
        self.frame.size.height = 25
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.size.width / 2
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
