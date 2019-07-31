//
//  XSLTransitionTool.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2019/7/23.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit

class XSLTransitionTool: NSObject {
    var cureentIndex: Int

    init(currentIndex: Int) {
        self.cureentIndex = currentIndex
    }

    //拿到当前图片的index，需要计算出，之前图片的位置，和结束时图片返回的位置
    //之前的方式：通过回调，传入当前图片对象，在计算出，他所在的位置
}
//extension UIScrollView

public protocol SwizzlingInjection: class {
    static func inject()
}

open class SwizzlingManager {

}
