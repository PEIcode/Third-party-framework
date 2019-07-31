//
//  XSLPhotoBrowserTransitioning.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/12/4.
//  Copyright © 2018 廖佩志. All rights reserved.
//

import UIKit
import Foundation
//public enum TransitionType {
//    case fade
//    case zoom
//}
open class XSLPhotoBrowserTransitioning: NSObject, XSLPhotoBrowserTransitioningDelegate {
    weak public var browser: XSLPhotoBrowser?

    public var maskAlpha: CGFloat {
        set {
            presentVC?.maskView.alpha = newValue
        }
        get {
            return presentVC?.maskView.alpha ?? 0
        }
    }
//    public var type: TransitionType = .fade
//    init(transitionType: TransitionType?) {
//        self.type = transitionType ?? .fade
//    }
    // presentd转场动画方法
    open var presentingAnimator: UIViewControllerAnimatedTransitioning?
    // dismiss转场动画方法
    open var dismissAnimator: UIViewControllerAnimatedTransitioning?
    // present转场
    private weak var presentVC: XSLPresentationController?

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentingAnimator
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimator
    }

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let vc = XSLPresentationController(presentedViewController: presented, presenting: presenting)
        presentVC = vc
        return vc
    }
}
