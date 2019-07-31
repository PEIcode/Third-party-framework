//
//  BrowserController.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2019/7/24.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit

class BrowserController: UIViewController {

    weak var sourceObject: AnyObject?
    var startFrame: CGRect?
    var endFrame: CGRect?
    var currentIndex: Int
    var imageView: UIImageView?
    init(currentIndex: Int, ob: AnyObject?) {
        self.sourceObject = ob
        self.currentIndex = currentIndex
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view.addSubview(imageView!)
//        print(sourceObject)
        if sourceObject?.isKind(of: UIScrollView.self) ?? false {
            let a = sourceObject as! UICollectionView
            print(a)
            let cell = a.cellForItem(at: IndexPath(item: currentIndex, section: 0))
            for v in cell?.contentView.subviews ?? [] {
                if v.isKind(of: UIImageView.self) {
                    let d = v as? UIImageView
                    imageView!.image = d?.image
                    self.startFrame = imageForFrame(oriView: imageView!, toView: a)
                }
            }

//            view.addSubview(cell!)
        }
        // Do any additional setup after loading the view.
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: {
//            UIView.animate(withDuration: 0.25, animations: {
//                self.imageView?.frame = self.startFrame!
//            })
            print(self.startFrame)
        })
    }

    deinit {
        self.sourceObject = nil
        self.view = nil
        print("BrowserController-dealloc")
        print(self.sourceObject)
    }

    func imageForFrame(oriView: UIView, toView: UIView) -> CGRect {
        let rect = oriView.convert(oriView.bounds, to: toView)
        return rect
    }
}
