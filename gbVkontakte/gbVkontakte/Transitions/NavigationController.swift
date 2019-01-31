//
//  NavigationController.swift
//  gbVkontakte
//
//  Created by NosovML on 31/01/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

import UIKit

class NavigationController: UINavigationController, UINavigationControllerDelegate {
    
    let interactiveTransition = InteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if (operation == .push) {
            interactiveTransition.viewController = toVC
            return PushAnimator()
        } else if (operation == .pop) {
            if navigationController.viewControllers.first != toVC {
                interactiveTransition.viewController = toVC
            }
            return PopAnimator()
        }
        return nil
    }
}
