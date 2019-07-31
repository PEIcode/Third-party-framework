//
//  HeroViewController.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2019/7/31.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit
import Hero
private let reuseIdentifier = "HeroCell"

class HeroViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private let photoSpacing: CGFloat = 8.0

    var pageCounts: Int?
    var currentIndex: Int

    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = photoSpacing
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        //        collectionV.backgroundColor = UIColor.clear
        collectionV.showsVerticalScrollIndicator = false
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.isPagingEnabled = true
        collectionV.alwaysBounceVertical = false
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.frame = view.bounds
        collectionV.frame.size.width = view.bounds.width + photoSpacing
        collectionV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: photoSpacing)
        collectionV.register(LocalCell.self, forCellWithReuseIdentifier: "HeroCell")
        return collectionV
    }()


    init(currentIndex: Int) {
        self.currentIndex = currentIndex
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        super.init(nibName: nil, bundle: nil)
        self.hero.isEnabled = true

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        collectionView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .left, animated: true)
        view.addSubview(collectionView)
        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LocalCell
        cell.imageView.image = UIImage(named: "pic\(indexPath.item+1)")
        cell.imageView.contentMode = .scaleAspectFit
        cell.imageView.hero.id = "hero\(indexPath.item)"
        cell.imageView.hero.modifiers = [.forceAnimate]
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
    }

}
