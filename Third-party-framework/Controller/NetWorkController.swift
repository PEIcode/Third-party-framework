//
//  NetWorkController.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/12/20.
//  Copyright © 2018 廖佩志. All rights reserved.
//

import UIKit
import Kingfisher
class NetWorkController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    lazy var imgArray: [String] = {
        let a = Bundle.main.path(forResource: "Photos", ofType: "plist")
        let b = NSArray(contentsOfFile: a!) as! [[String]]
        let urls = b.map({ (m) -> String in
            return m[0]
        })
        return urls
    }()
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        return layout
    }()

    lazy var collectionV: UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        v.showsVerticalScrollIndicator = false
        v.showsHorizontalScrollIndicator = false
        v.register(LocalCell.self, forCellWithReuseIdentifier: "collectionCell")
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let top = navigationController?.navigationBar.frame.origin.y
        let backBtn = UIButton(frame: CGRect(x: 0, y: top ?? 44, width: 80, height: 30))
        backBtn.backgroundColor = .gray
        backBtn.setTitle("BACK", for: .normal)
        view.addSubview(backBtn)
        backBtn.addTarget(self, action: #selector(backClick), for: .touchDown)

        collectionV.frame = CGRect(x: 0, y: 80, width: view.bounds.width, height: view.bounds.height - 30)
        collectionV.delegate = self
        collectionV.dataSource = self
        view.addSubview(collectionV)
        view.backgroundColor = .white
    }
    @objc func backClick() {
        self.dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! LocalCell
//        cell.imageView.image = UIImage.init(named: imgArray[indexPath.item])
        cell.imageView.kf.setImage(with: URL(string: imgArray[indexPath.item]))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let dataSource = XSLNetWorkImageDataSource(numberOfItems: { () -> Int in
            return self.imgArray.count
        }, placeholder: { (Int) -> UIImage? in
            let cell = collectionView.cellForItem(at: indexPath) as? XSLPhotoBrowserNetWorkCell
            return cell?.imageView.image
        }, urlCallback: { (index) -> String? in
            return self.imgArray[index]
        })
        let delegate = XSLPhotoBrowserAssembler()
//        delegate.longPressedCallback
        delegate.longPressedCallback = { (browser, index, image, gesture) in
            print(index)
        }
        delegate.cellIsDraging = {
            delegate.bottomView.isHidden = true
            delegate.headerView.isHidden = true
        }
        delegate.cellEndDrag = {
            delegate.bottomView.isHidden = false
            delegate.headerView.isHidden = false
        }
        delegate.deleteBtnCallback = {
            (index) in
            self.imgArray.remove(at: index)
            self.collectionV.reloadData()
            delegate.browser?.reloadData()
        }
//        delegate.bottomView.addSubview()
        //        let transDelegate = XSLPhotoBrowserZoomtransitioning(transView: collectionView.cellForItem(at: indexPath)!)
        //需要传 对应的view对象，拿到 起始frame 结束时的frame（就是最后呈现的cell的imageView的frame）
        let transDelegate = XSLPhotoBrowserZoomtransitioning { (browser, index, view) -> UIView? in
            let indexP = IndexPath(item: index, section: 0)
            return collectionView.cellForItem(at: indexP)
        }
        let browser = XSLPhotoBrowser(pageIndex: indexPath.item, dataSource: dataSource, deledate: delegate, transDelegate: transDelegate)
        present(browser, animated: true, completion: nil) }

}
