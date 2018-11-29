//
//  BrowseViewController.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/10/17.
//  Copyright © 2018 廖佩志. All rights reserved.
//

import UIKit
fileprivate let PhotoCellID = "PhotoCellID"
/// 图片间隔
let PicMargin: CGFloat = 20
class BrowseViewController: UIViewController{
    //属性
    fileprivate var currentIndex : IndexPath = []
    fileprivate var imageArray: NSArray
    fileprivate var pageCtr: BrowsePageControl?
    fileprivate var imgInfoArray: Array<pic> = []
    fileprivate var currentURL: String = ""
    var currentRow: Int = 0
    ///自定义CollectionViewlayout
    fileprivate lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: PhotoCollectionViewLayout())
    //构造方法
    init(imageCounts: NSArray, currentIndexP: IndexPath, imageInfoArray: Array<pic>) {
        currentIndex = currentIndexP
        imageArray = imageCounts
        imgInfoArray = imageInfoArray
        super.init(nibName: nil, bundle: nil)
    }
    // 通过url访问 现在要根据URL 来计算在对应数组的 下标  所有 currentIndex都要代替
//    init(imageCounts:NSArray, currectURLs: String, imageInfoArray: Array<pic>){
//        currentURL = currectURLs
//        imageArray = imageCounts
//        imgInfoArray = imageInfoArray
//
//        for (index,value) in imageCounts.enumerated() {
//            print("\(index)\(value)")
//
//            if currectURLs == String(describing: value){
//                currentIndex = [0,index]
//                print(currentIndex)
//            }
//        }
//        print(imageArray)
//        super.init(nibName: nil, bundle: nil)
//    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        //        view.frame.size.width += PicMargin
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConllectionView()
        //UIPageControl
        pageCtr = BrowsePageControl()
        pageCtr?.frame = CGRect(x: 0, y:0 , width: 100, height: 30)
        pageCtr?.center = CGPoint(x: view.frame.width * 0.5, y: view.frame.height - 50)
        pageCtr?.numberOfPages = imageArray.count
        pageCtr?.currentPage = currentIndex.row
        view.addSubview(pageCtr!)
        //
        collectionView.scrollToItem(at: currentIndex, at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
        //KVO监听collecView的bounds
        collectionView.addObserver(self, forKeyPath: "bounds", options: [.new,.old], context: nil)
    }
    deinit {
        collectionView.removeObserver(self, forKeyPath: "bounds")
        print("denintVC")
    }
}
extension BrowseViewController{
    func setupConllectionView() -> Void {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
        collectionView.frame.size.width = view.bounds.width + PicMargin
        collectionView.dataSource = self
        collectionView.register(BrowseCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCellID)
    }
}
//MARK:-UICollectionViewDataSource
extension BrowseViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCellID, for: indexPath) as? BrowseCollectionViewCell else {
            return UICollectionViewCell()
        }
        //取出对应图片的url
        let imageIndex = imageArray[indexPath.row]
//        let icon = UIImage(named: imageIndex as! String)
//        cell.imageView.image = icon
        cell.imageView.sd_setImage(with: URL.init(string: imageIndex as! String), completed: nil);
        cell.imgIndex = (imageIndex as! String)
        cell.imageInfo = imgInfoArray[indexPath.row]
        cell.delegate = self
        return cell
    }
}
//MARK:KVO(计算pageControl的currentpage)
extension BrowseViewController: UIScrollViewDelegate,UICollectionViewDelegate{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let bounds = change![NSKeyValueChangeKey.newKey] as! CGRect
        let changeX = bounds.minX
        let pageCurrent = changeX / view.frame.width
        pageCtr?.currentPage = Int(pageCurrent)
    }
}
//MARK:-BrowseDismissDelegate
extension BrowseViewController: BrowseDismissDelegate{
    func imageForDismiss() -> UIImageView {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.clipsToBounds = true
        //设置图片
        guard let cell = collectionView.visibleCells[0] as? BrowseCollectionViewCell else {
            return UIImageView()
        }
//        imageV.image = cell.imageView.image
//        let imageVFrame = CGRect(x: 0, y:cell.frame.origin.y + 25 , width: kScreenWidth, height: cell.imageView.frame.size.height)
//        imageV.frame = cell.scrollView.convert(imageVFrame, to: UIApplication.shared.keyWindow)
        imageV.frame = cell.scrollView.convert(cell.imageView.frame, to: UIApplication.shared.keyWindow)
        return imageV
    }
    
    func indexPathForDissmiss() -> IndexPath {
        return collectionView.indexPathsForVisibleItems[0]
    }
    
    
}
extension BrowseViewController: PhotoBrowserCellDelegate{
    func photoBrowserCellImageClick() {
        dismiss(animated: true, completion: nil)
    }
    
}
//MARK: -自定义flowlayout
class PhotoCollectionViewLayout: UICollectionViewFlowLayout{
    
    override func prepare() {
        super.prepare()
        //属性设置
        itemSize = collectionView!.bounds.size
        
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .horizontal
        //设置collectionView的属性
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = true
    }
}

