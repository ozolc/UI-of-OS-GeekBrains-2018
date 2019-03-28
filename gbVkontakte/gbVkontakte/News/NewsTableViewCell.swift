//
//  NewsTableViewCell.swift
//  gbVkontakte
//
//  Created by NosovML on 21/01/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var commentImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var footerStackView: UIStackView!
    
    var likes = 0
    var reposts = 0
    var comments = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        setupGestureRecognizer(likeImageView)
        setupGestureRecognizer(shareImageView)
        setupGestureRecognizer(commentImageView)
        setupGestureRecognizer(newsImageView)
    }
    
    public func configure(with news: News) {
//        let isGroup = news.postSource_id < 0 ? true : false
        
//        if isGroup {
            let urlUserImage = news.titlePostPhoto
            userImageView.kf.setImage(with: URL(string: urlUserImage))
//        }
    
        userNameLabel.text = news.titlePostLabel
        newsTextLabel.text = news.postText
        
        likeLabel.text = String(news.likesCount)
        commentLabel.text = String(news.commentsCount)
        shareLabel.text = String(news.repostsCount)
        
        let date = Date(timeIntervalSince1970: news.titlePostTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        let localDate = dateFormatter.string(from: date)
        dateTimeLabel.text = localDate
        
    }
    
    private func setupGestureRecognizer(_ localSender: UIImageView) {
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(sender:)))
        localSender.isUserInteractionEnabled = true
        gestureTap.numberOfTapsRequired = 1
        localSender.addGestureRecognizer(gestureTap)
    }
    
    @objc func imageViewTapped(sender: UIGestureRecognizer) {
        switch sender.view {
        case likeImageView:
            self.likes += 1
            likeLabel.text = String(likes)
            
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = 2
            
            likeImageView.layer.add(rotationAnimation, forKey: nil)
            
        case shareImageView:
            self.reposts += 1
            shareLabel.text = String(reposts)
        case commentImageView:
            self.comments += 1
            commentLabel.text = String(comments)
        case newsImageView:
            UIView.animate(withDuration: 1,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.newsImageView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            }) { (success: Bool) in
                UIView.animate(withDuration: 1,
                               delay: 0,
                               options: .curveEaseInOut,
                               animations: {
                                self.newsImageView.transform = CGAffineTransform.identity
                })
            }
        default:
            return
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


