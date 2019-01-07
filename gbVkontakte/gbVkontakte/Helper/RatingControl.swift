//
//  RatingControl.swift
//  gbVkontakte
//
//  Created by Maksim Nosov on 07/01/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIControl {

    var counter: Int = 0
    @IBInspectable var buttonLike = UIButton(type: .custom)
    
    private var buttons: [UIButton] = []
    
    @IBInspectable var stackView: UIStackView!
    @IBInspectable var isLiked = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    private func setupView() {
        
//        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
//        button.backgroundColor = .green
//        button.setTitle("Test Button", for: .normal)
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//
//        self.addSubview(button)
        
//        layer.masksToBounds = false
//        let button = UIButton(type: .custom)
        buttonLike.frame = CGRect(origin: .zero, size: CGSize(width: 32.0, height: 32.0))
//            CGRect(x: 100, y: 100, width: 100, height: 50)
//        buttonLike.backgroundColor = .green
//        buttonLike.setTitle("Test Button", for: .normal)

        buttonLike.setImage(UIImage(named: isLiked == true ? "liked" : "notLiked"), for: .normal)
//        buttonLike.imageView?.image?.renderingMode = .alwaysOriginal
        
        
//        if isLiked {
//            if let imageLiked = UIImage(named: "liked") {
//                buttonLike.setImage(imageLiked, for: .normal)
//                buttonLike.setTitle("Liked", for: .normal)
//                buttonLike.setTitleColor(UIColor.black, for: .selected)
//            } else {
//                if let imageNotLiked = UIImage(named: "notLiked") {
//                    buttonLike.setImage(imageNotLiked, for: .normal)
//                    buttonLike.setTitle("not liked", for: .normal)
//                    buttonLike.setTitleColor(UIColor.black, for: .selected)
//                }
//            }
//        }

        buttonLike.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
        buttons.append(buttonLike)
        self.addSubview(buttonLike)
        
//        stackView = UIStackView(arrangedSubviews: self.buttons)

//        self.addSubview(stackView)

//        stackView.spacing = 5
//        stackView.axis = .horizontal
//        stackView.alignment = .center
//        stackView.distribution = .fillEqually
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    
    @objc func likeAction() {
        
        if (counter == 0 && !isLiked) {
            counter += 1
            self.isLiked = true
        } else if (counter > 0 && isLiked){
//            counter = isLiked == true ? counter + 1 : counter - 1
            counter -= 1
            self.isLiked = false
        } else {
            counter = isLiked == true ? counter + 1 : counter - 1
        }
        self.setupView()
        print("Counter == \(counter) status = \(isLiked)")
    }
    
//    counter = isLiked == true ? counter + 1 : counter - 1

    override func layoutSubviews() {
        super.layoutSubviews()
//        stackView.frame = bounds
            // CGRect(x: 0, y: 0, width: 60, height: 60)
    }
    
    
}
