//
//  BackgroundFadeButtonLoweringAnimation.swift
//  Queue Managment
//
//  Created by WINTAA on 28.06.22.
//

import Foundation
import UIKit

final class BackgroundFadeButtonLoweringAnimator: NSObject {
    private let duration: TimeInterval = 0.4
}

extension BackgroundFadeButtonLoweringAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromController = transitionContext.viewController(forKey: .from) as? ResetPasswordController,
              let toController = transitionContext.viewController(forKey: .to) as? CheckEmailController
        else { return }
        
        let toView = toController.view!
        let fromView = fromController.view!
        let toViewContainer = toController.containerView!
        let toButton = toController.openEmailButton!
        let fromButton = fromController.nextButton!
        
        let tempButton = fromButton.copy() as! UIButton
        tempButton.setTitle("Open email app", for: .normal)
        toView.addSubview(tempButton)
        
        toView.backgroundColor = .clear
        containerView.addSubview(toView)
        fromButton.alpha = 0
        containerView.layoutIfNeeded()

        let toFrame = toButton.globalFrame!
        
        fromView.alpha = 1
        toViewContainer.alpha = 0
        toButton.alpha = 0

        UIView.animate(
          withDuration: duration,
          animations: {
              tempButton.frame = toFrame
              toViewContainer.alpha = 1
              fromView.alpha = 0
          },
          completion: { _ in
              tempButton.isHidden = true
              toButton.alpha = 1
              transitionContext.completeTransition(true)
          }
        )
        
    }
    
}
