//
//  PhotoAnimation.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/10/17.
//  Copyright © 2018 廖佩志. All rights reserved.
//


/**描述ViewController转场的 (自定义的时候，都需要设置对应的代理)
 UIViewControllerTransitioningDelegate 自定义模态转场动画时使用。
 UINavigationControllerDelegate 自定义navigation转场动画时使用
 UITabBarControllerDelegate 自定义tab转场动画时使用
 */
/**定义动画内容的
 UIViewControllerAnimatedTransitioning
 UIViewControllerInteractiveTransitioning
 */
/**表示动画上下文的
 UIViewControllerContextTransitioning
 不需要实现这个协议，但里面 有很多常用的属性和方法
 containerView 动画发生在该View中
 completeTransition 上报动画执行完毕
 */
import UIKit
protocol BrowsePresentDelegate: NSObjectProtocol{
    //提供弹出的imageView
    func imageForPresent(indexPath: IndexPath) -> UIImageView
    //提供弹出的imageView的frame
    func startImageRectForPresent(indexPath: IndexPath) -> CGRect
    //弹出后的imageView的frame
    func endImageRectForPresent(indexPath: IndexPath) -> CGRect
}

protocol BrowseDismissDelegate: class {
    //退出的imageView
    func imageForDismiss() -> UIImageView
    //退出的indexPath
    func indexPathForDissmiss() -> IndexPath
}
class PhotoAnimation: NSObject {
    var isPresent = true
    var indexPath: IndexPath?
    var presentDelegate: BrowsePresentDelegate?
    var dismissDelegate: BrowseDismissDelegate?
    
    func setProperty(indPath: IndexPath, _ preDelegate: BrowsePresentDelegate, _ disDelegate: BrowseDismissDelegate) {
        indexPath = indPath
        presentDelegate = preDelegate
        dismissDelegate = disDelegate
    }
}
//MARK:UIViewControllerTransitioningDelegate
extension PhotoAnimation: UIViewControllerTransitioningDelegate{
    // 该方法是告诉系统,弹出动画交给谁来处理
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }
    // 消失动画的处理
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        return self
    }
}

//MARk: 必须实现以下两个方法
extension PhotoAnimation: UIViewControllerAnimatedTransitioning{
    //Tells your animator object to perform the transition animations.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresent ? presentAnimation(transitionContext) : dismissAnimation(transitionContext)
    }
    //Asks your animator object for the duration (in seconds) of the transition animation.
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
}
//MARk: present 和dismiss具体实现
extension PhotoAnimation{
    fileprivate func presentAnimation(_ transitionContext:  UIViewControllerContextTransitioning) {
        guard let presentD = presentDelegate, let indexPath = indexPath else {
            return
        }
        //1.取出弹出的View
        guard let presentView = transitionContext.view(forKey: .to) else{ return
        }
        
        //2.加入到containerView中
        transitionContext.containerView.addSubview(presentView)
        //3.获取弹出的imageView
        let tempImageView = presentD.imageForPresent(indexPath: indexPath)
        tempImageView.frame = presentD.startImageRectForPresent(indexPath: indexPath)
        
        transitionContext.containerView.addSubview(tempImageView)
        //有利于后面拖拽时，设置presentView的alpha
        transitionContext.containerView.backgroundColor = .black
        //        transitionContext.containerView.endImageRectForpresent(indexPath)
        //执行动画
        presentView.alpha = 0
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            tempImageView.frame = presentD.endImageRectForPresent(indexPath: indexPath)
            //            disView?.alpha = 0 如果直接设置为0，在后面拖拽时，不好设置alpha
        }) { _ in
            transitionContext.containerView.backgroundColor = .clear
            //上报动画执行完毕
            transitionContext.completeTransition(true)
            tempImageView.removeFromSuperview()
            presentView.alpha = 1
        }
        
    }
    
    
    fileprivate func dismissAnimation(_ transitionContext:  UIViewControllerContextTransitioning) {
        guard let dismissD = dismissDelegate , let presentD = presentDelegate else {
            return
        }
        //取出消失的View
        guard let dismissView = transitionContext.view(forKey: .from) else {
            return
        }
        guard let presentVC = transitionContext.viewController(forKey: .to) else {
            print("predent !  error")
            return
        }
        let presentView = presentVC.view
        presentView?.alpha = 0.35
        
        dismissView.alpha = 0
        //获取要退出的imageView
        let tempImageV = dismissD.imageForDismiss()
        transitionContext.containerView.addSubview(tempImageV)
        //获取将要退出的indexPath
        let indexPath = dismissD.indexPathForDissmiss()
        //执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            tempImageV.frame = presentD.startImageRectForPresent(indexPath: indexPath)
            dismissView.alpha = 0
            presentView?.alpha = 1
        }) {(_) in
            
            tempImageV.removeFromSuperview()
            dismissView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
    
    
}

