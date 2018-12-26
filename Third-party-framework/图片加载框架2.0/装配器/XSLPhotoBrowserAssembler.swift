//
//  XSLPhotoBrowserAssembler.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/12/26.
//  Copyright © 2018 廖佩志. All rights reserved.
//

import UIKit


class XSLPhotoBrowserAssembler: XSLPhotoBrowserDelegate {

    lazy var offsetX: CGFloat = {
        if #available(iOS 11.0, *), let window = UIApplication.shared.keyWindow {
            guard let areaBottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom else {
                return 0
            }
            return areaBottom
        }
        return 0
    }()
    func SafeTop(y: CGFloat) -> CGFloat {
        if #available(iOS 11.0, *) {
            guard let areaTop = UIApplication.shared.keyWindow?.safeAreaInsets.top else {
                return y
            }
            return y + areaTop
        }
        return y
    }

    lazy var offsetY: CGFloat = {
        if #available(iOS 11.0, *) {
            guard let areaBottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom else {
                return 0
            }
            return areaBottom
        }
        return 0
    }()

    var backButton: ((XSLPhotoBrowserAssembler) -> Void)?
    lazy var headerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: SafeTop(y: 0), width: UIScreen.main.bounds.width, height: 44))
//        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.white.cgColor
        let button = UIButton()
        button.setImage(UIImage(named: "error"), for: .normal)
        button.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(quitClick), for: .touchDown)
        view.addSubview(button)
        return view
    }()

    lazy var bottomView: UIView = {
        let heigt: CGFloat = 44.0
        let y = UIScreen.main.bounds.height - heigt - offsetY
        let view = UIView(frame: CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 44))
                view.backgroundColor = .white
        view.layer.shadowColor = UIColor.white.cgColor
//        let button = UIButton()
//        button.setImage(UIImage(named: "error"), for: .normal)
//        button.frame = CGRect(x: 10, y: 0, width: 44, height: 44)
//        button.addTarget(self, action: #selector(quitClick), for: .touchDown)
//        view.addSubview(button)
        return view
    }()

    override func photobrowser(_ browser: XSLPhotoBrowser, viewDidLoad animated: Bool) {
        super.photobrowser(browser, viewDidLoad: animated)
        browser.view.addSubview(headerView)
        browser.view.addSubview(bottomView)
    }

    @objc func quitClick() {
        self.dismiss()
    }
}
