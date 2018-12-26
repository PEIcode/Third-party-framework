//
//  XSLNetWorkImageDataSource.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/12/6.
//  Copyright © 2018 廖佩志. All rights reserved.
//

import UIKit

class XSLNetWorkImageDataSource: NSObject, XSLPhotoBrowserBaseDataSource {
    /// 弱引用 PhotoBrowser
    public weak var browser: XSLPhotoBrowser?
    let cellID = "XSLBaseCollectionViewCell"
    /// 共有多少项
    public var numberOfItemsCallback: () -> Int

    /// 每一项的图片对象
    public var loadURLImageCallback: (Int) -> String?

//    /// 图片加载器
//    public var photoLoader: JXPhotoLoader
//
    public init(numberOfItems: @escaping () -> Int, localImage: @escaping (Int) -> String? ) {
        self.numberOfItemsCallback = numberOfItems
        self.loadURLImageCallback = localImage
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemsCallback()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! XSLBaseCollectionViewCell
        cell.imageView.kf.setImage(with: URL(string: loadURLImageCallback(indexPath.item)!))
//        cell.imageView.kf.setImage(with: URL(string: loadURLImageCallback(indexPath.item)!), placeholder: nil, options: KingfisherOptionsInfo?, progressBlock: , completionHandler: )
        return cell
    }
    
    func registerCell(for collectionView: UICollectionView) {
        collectionView.register(XSLBaseCollectionViewCell.self, forCellWithReuseIdentifier: "XSLBaseCollectionViewCell")
    }

}
