//
//  XSLPhotoBrowserZoomAnimator.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/12/4.
//  Copyright © 2018 廖佩志. All rights reserved.
//

import UIKit

class XSLPhotoBrowserZoomAnimator: NSObject {
    /// 转场时做动画效果的视图
    var zoomView: () -> UIView?

    /// 动画开始位置
    var startFrame: (_ transContainer: UIView) -> CGRect?

    /// 动画结束位置
    var endFrame: (_ transContainer: UIView) -> CGRect?

    /// 初始化，三个回调中，只要有一个返回nil值，就无法执行zoom动画，将转为执行Fade动画。
    init(zoomView: @escaping () -> UIView?,
                startFrame: @escaping (_ superView: UIView) -> CGRect?,
                endFrame: @escaping (_ superView: UIView) -> CGRect?) {
        self.zoomView = zoomView
        self.startFrame = startFrame
        self.endFrame = endFrame
    }
}
