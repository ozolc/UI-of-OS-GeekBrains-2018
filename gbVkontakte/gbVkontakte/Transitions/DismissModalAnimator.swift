//
//  DismissModalAnimator.swift
//  gbVkontakte
//
//  Created by NosovML on 31/01/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

final class DismissModalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
//        _ = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        
        containerView.addSubview(toView)
        toView.alpha = 0.0
        
        UIView.animate(withDuration: duration,
                       animations: {
                        toView.alpha = 1.0
        },
                       completion: { _ in
                        transitionContext.completeTransition(true)
        })
    }
}

