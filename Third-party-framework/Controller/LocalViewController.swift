//
//  LocalViewController.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/12/6.
//  Copyright © 2018 廖佩志. All rights reserved.
//

import UIKit
import Kingfisher
import XSLPhotoBrowser

class LocalViewController: UIViewController {

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

    lazy var imgArray: [String] = {
        var result: [String] = []
        (0..<4).forEach({ (index) in
            let str = "pic\(index + 1)"
            result.append(str)
        })
        return result
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
}
extension LocalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! LocalCell
        cell.imageView.image = UIImage.init(named: imgArray[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataSource = XSLLocalImageDataSource(numberOfItems: { () -> Int in
            return self.imgArray.count
        }) { (index) -> UIImage? in
            return UIImage(named: self.imgArray[index])
        }
        
        present(XSLPhotoBrowser(pageIndex: indexPath.item, dataSource: dataSource)
, animated: true, completion: nil)
    }

}
