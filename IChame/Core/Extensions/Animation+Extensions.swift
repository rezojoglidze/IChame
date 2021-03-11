//
//  Animation+Extensions.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/12/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import Foundation
import XCoordinator

extension Animation {
  static let fade = Animation(
    presentation: InteractiveTransitionAnimation.fade,
    dismissal: nil
  )
}

extension InteractiveTransitionAnimation {
  fileprivate static let fade = InteractiveTransitionAnimation(duration: Constants.Animation.defaultDuration) { transitionContext in
    let containerView = transitionContext.containerView
    if let toView = transitionContext.viewController(forKey: .to)?.view {
      toView.alpha = 0.0
      containerView.addSubview(toView)
      
      UIView.animate(withDuration: Constants.Animation.defaultDuration, delay: 0, options: [.curveLinear], animations: {
        toView.alpha = 1.0
      }, completion: { _ in
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      })
    }
  }
}
