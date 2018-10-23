//
//  BrowseCollectionViewCell.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/10/17.
//  Copyright © 2018 廖佩志. All rights reserved.
//


import UIKit
import AVFoundation
protocol PhotoBrowserCellDelegate : NSObjectProtocol {
    /// 单击事件
    func photoBrowserCellImageClick()
    
    /// 拖拽事件
    //    func photoBrowserDragingImageClick(_:UIPanGestureRecognizer)
}
/// 屏幕的宽
let kScreenWidth = UIScreen.main.bounds.size.width
/// 屏幕的高
let kScreenHeight = UIScreen.main.bounds.size.height


class BrowseCollectionViewCell: UICollectionViewCell {
    //MARK:- 懒加载
    lazy var imageView = UIImageView()
    lazy var scrollView = UIScrollView()
    
    /// 计算服务端返回图片的大小
    var imageInfo: pic?{
        didSet{
            // 计算imageView的尺寸
            calculateImageViewFrame()
        }
    }
    
    ///
    //    let iconModel: imageModel?
    var url: String? {
        didSet{
            
        }
    }
    ///
    var avplayer: AVPlayer?
    ///
    var avPlayerLayer: AVPlayerLayer?
    /// 记录pan手势开始时imageView的位置
    private var beganFrame = CGRect.zero
    /// 判断距离屏幕顶部的高度
    var topInsetForScr: CGFloat = kScreenHeight > 800 ? 44 : 20
    /// 记录pan手势开始时，手势位置
    private var beganTouch = CGPoint.zero
    /// 传入的图片名字
    var imgIndex: String? {
        didSet{
//            let image = UIImage(named: imgIndex!)
//            calculateImageFrame(image: image!)
            
        }
    }
    /// 代理属性
    var delegate : PhotoBrowserCellDelegate?
    
    
    /// 取图片适屏size
    private var fitSize: CGSize {
        guard let image = imageView.image else {
            return CGSize.zero
        }
        let width = kScreenWidth
        let scale = image.size.height / image.size.width
        return CGSize(width: width, height: scale * width)
    }
    
    /// 取图片适屏frame
    private var fitFrame: CGRect {
        let size = fitSize
        let y = (scrollView.bounds.height - size.height) > 0 ? (scrollView.bounds.height - size.height) * 0.5 : 0
        return CGRect(x: 0, y: y, width: size.width, height: size.height)
    }
    /// 计算contentSize应处于的中心位置
    private var centerOfContentSize: CGPoint {
        let deltaWidth = bounds.width - scrollView.contentSize.width - PicMargin
        let offsetX = deltaWidth > 0 ? deltaWidth * 0.5 : 0
        let deltaHeight = bounds.height - scrollView.contentSize.height
        let offsetY = deltaHeight > 0 ? deltaHeight * 0.5 : 0
        return CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX,
                       y: scrollView.contentSize.height * 0.5 + offsetY)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializationViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension BrowseCollectionViewCell{
    func initializationViews () {
        contentView.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.frame = contentView.bounds
        // 1.设置imageView的contentMode
        imageView.contentMode = .scaleAspectFill
        
        // 2.设置scrollView的代理
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 2.0
        
        // 3.给contentView添加手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePhototBrowser))
        contentView.addGestureRecognizer(tap)
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleClick(_:)))
        doubleTap.numberOfTapsRequired = 2
        tap.require(toFail: doubleTap)
        contentView.addGestureRecognizer(doubleTap)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panPhotoBrowser(_:)))
        pan.delegate = self as UIGestureRecognizerDelegate
        scrollView.addGestureRecognizer(pan)
        
        
    }
    func calculateImageViewFrame(){
        let imageH = CGFloat((imageInfo?.height)!)/CGFloat((imageInfo?.width)!) * kScreenWidth
        imageView.bounds = CGRect(x: 0, y: 0, width: kScreenWidth, height: imageH)
        scrollView.contentSize = CGSize(width: kScreenWidth, height: imageH)
        //判断是长图还是短图
        if imageH < kScreenHeight {
            imageView.center = CGPoint(x: kScreenWidth * 0.5, y: kScreenHeight * 0.5)
        }else{
            
            imageView.center = CGPoint(x: kScreenWidth * 0.5, y: imageH * 0.5-topInsetForScr)
        }
        
    }
    /// 计算imageView的尺寸
    ///
    /// - Parameter image: 传入的图片
    fileprivate func calculateImageFrame(image: UIImage) {
        let imageH = image.size.height / image.size.width * kScreenWidth
        imageView.bounds = CGRect(x: 0, y: 0, width: kScreenWidth, height: imageH)
        scrollView.contentSize = CGSize(width: kScreenWidth, height: imageH)
        //判断是长图还是短图
        if imageH < kScreenHeight {
            imageView.center = CGPoint(x: kScreenWidth * 0.5, y: kScreenHeight * 0.5)
        }else{
            
            imageView.center = CGPoint(x: kScreenWidth * 0.5, y: imageH * 0.5-topInsetForScr)
        }
    }
    @objc fileprivate func closePhototBrowser(){
        delegate?.photoBrowserCellImageClick()
    }
    @objc fileprivate func doubleClick(_ dbTap: UITapGestureRecognizer) {
        // 如果当前没有任何缩放，则放大到目标比例
        let scale = scrollView.maximumZoomScale
        print(scale)
        // 否则重置到原比例
        if scrollView.zoomScale == 1.0 {
            // 以点击的位置为中心，放大
            let pointInView = dbTap.location(in: imageView)
            let w = scrollView.bounds.size.width / scale
            let h = scrollView.bounds.size.height / scale
            let x = pointInView.x - (w / 2.0)
            let y = pointInView.y - (h / 2.0)
            let rect = CGRect(x: x, y: y, width: w, height: h)
            print(rect)
            scrollView.zoom(to: CGRect(x: x, y: y, width: w, height: h), animated: true)
        } else {
            scrollView.setZoomScale(1.0, animated: true)
        }
    }
    @objc fileprivate func panPhotoBrowser(_ pan:UIPanGestureRecognizer){
        guard imageView.image != nil else {
            return
        }
        switch pan.state {
        case .began:
            beganFrame = imageView.frame
            beganTouch = pan.location(in: scrollView)
        case .changed:
            let result = panResult(pan)
            imageView.frame = result.0
            let alphaz: CGFloat = result.1 * result.1
            self.superview?.alpha = alphaz
        case .ended, .cancelled:
            imageView.frame = panResult(pan).0
            if pan.velocity(in: self).y > 0 {
                delegate?.photoBrowserCellImageClick()
            } else {
                // 取消dismiss
                endPan()
            }
        default:
            endPan()
        }
        
    }
    
    /// 返回拖拽的结果（包括：image的frame和透明度）
    private func panResult(_ pan: UIPanGestureRecognizer) -> (CGRect, CGFloat) {
        
        //表示拖拽点在scrollView中的位置，即拖拽的位置
        let currentTouch = pan.location(in: scrollView)
        
        //        print(currentTouch)
        // 拖动偏移量（距离）
        //在指定视图的坐标系中平移手势的转换。
        //x和y值表示随时间推移的总平移量。它们不是上次报告转换时的delta值。在首次识别手势时，将转换值应用于视图的状态——不要在每次调用处理程序时将值连接起来。
        let translation = pan.translation(in: scrollView)
        //        print("This is a test\(translation)")
        
        
        // 由下拉的偏移值决定缩放比例，越往下偏移，缩得越小。scale值区间[0.3, 1.0]
        let scale = min(1.0, max(0.3, 1 - translation.y / bounds.height))
        
        let width = beganFrame.size.width * scale
        let height = beganFrame.size.height * scale
        
        // 计算x和y。保持手指在图片上的相对位置不变。
        let xRate = (beganTouch.x - beganFrame.origin.x) / beganFrame.size.width
        let currentTouchDeltaX = xRate * width
        let x = currentTouch.x - currentTouchDeltaX
        
        let yRate = (beganTouch.y - beganFrame.origin.y) / beganFrame.size.height
        let currentTouchDeltaY = yRate * height
        let y = currentTouch.y - currentTouchDeltaY
        
        return (CGRect(x: x.isNaN ? 0 : x, y: y.isNaN ? 0 : y, width: width, height: height), scale)
    }
    private func endPan() {
        self.superview?.alpha = 1.0
//        let image = UIImage(named: imgIndex!)
//        let scale = (image?.size.height)! / (image?.size.width)!
        
        let scale = CGFloat((imageInfo?.height)!) / CGFloat((imageInfo?.width)!)
        let width = scrollView.bounds.size.width - PicMargin
        let size = CGSize(width: width, height: width * scale)
        let needResetSize = imageView.bounds.size.width < size.width || imageView.bounds.size.height < size.height
        UIView.animate(withDuration: 0.25) {
            self.imageView.center = CGPoint(x: width * 0.5, y: self.scrollView.bounds.height * 0.5)
            if needResetSize {
                self.imageView.bounds.size = size
            }
        }
    }
}
//MARK: -UIScrollViewDelegate
extension BrowseCollectionViewCell: UIScrollViewDelegate{
    //将要缩放的UIView对象
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    /// 需要在缩放的时候调用
    ///
    /// - Parameter scrollView:
    open func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        let imageH = (imageView.image?.size.height)! / (imageView.image?.size.width)! * kScreenWidth
        if imageH < kScreenHeight {
            imageView.center = centerOfContentSize
        }
        
    }
}
//MARK: 对pan手势的处理
extension BrowseCollectionViewCell: UIGestureRecognizerDelegate{
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let pan = gestureRecognizer as? UIPanGestureRecognizer else{
            return true
        }
        //在指定视图的坐标系中平移手势的速度。
        let velocity = pan.velocity(in: self)
        //向上滑动，不响应手势
        if velocity.y < 0 {
            return false
        }
        //横向滑动时，不响应Pan手势
        if abs(Int(velocity.x)) > Int(velocity.y){
            return false
        }
        //向下滑动，如果图片顶部超出可视范围，不响应
        if scrollView.contentOffset.y > 0 {
            return false
        }
        return true
    }
}

