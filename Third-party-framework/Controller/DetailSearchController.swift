//
//  DetailSearchController.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/9/28.
//  Copyright © 2018 廖佩志. All rights reserved.
//

import UIKit
import SnapKit
import XSLPhotoBrowser

class DetailSearchController: UIViewController {

    fileprivate lazy var photoAnimation = PhotoAnimation()
    var titleLabel: UILabel?
    var str: String?
    var id: String?
    var detailViewModel = DetailSearchViewModel()
    var imageArray: Array<pic>{
//        return detailViewModel.resultSteps.map({ (a) -> T in
//            return a.pic
//        })
        let imgArray: NSMutableArray = []
        for a  in self.detailViewModel.resultSteps {
            if a.pic_urls.count != 0 {
                imgArray.add(a.pic_urls[0])
            }else{
                let p = pic()
                
                imgArray.add(p)
            }
        }
        return imgArray as! Array<pic>
    }
    var picArray: NSMutableArray{
        let imgA: NSMutableArray = []
        for a in imageArray{
            let b = a.big
            imgA.add(b)
        }
        return imgA
    }
    //UIFPSLabel
    var fpsLabel: UILabel?
    var displayLink: CADisplayLink?
    private var _lastTime: TimeInterval = 0
    private var _count:Int = 0
//    var imageH: CGFloat = 0
    let stepCellID = "stepCellID"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupFPSLabel()
        detailViewModel.delegate = self
        detailViewModel.id = id ?? "C"
        detailViewModel.fetchSearchDataList()
    }
    
    /// 设置UI
    func setupUI(){
        
        tableView.delegate = self
        tableView.dataSource = self
        // 方式二：用xib，也是用的约束
//        tableView.register(UINib(nibName: "PSStepCell", bundle: nil), forCellReuseIdentifier: stepCellID)
//        tableView.estimatedRowHeight = 300
//        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        let lab = UILabel.init()
        view.addSubview(lab)
        lab.backgroundColor = #colorLiteral(red: 1, green: 0.5115470886, blue: 0, alpha: 1)
        lab.textAlignment = .center
        titleLabel = lab
        lab.snp.makeConstraints { (make) in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.top.equalTo(50)
            //            make.left.equalTo(100)
            make.centerX.equalToSuperview()
        }
        lab.text = str!
    }
    
    /// 设置FPSLabel
    func setupFPSLabel() {
        fpsLabel = UILabel(frame: CGRect(x: 0, y: 60, width: 60, height: 20))
        fpsLabel?.alpha = 0.7
        fpsLabel?.textColor = UIColor.red
        view.addSubview(fpsLabel!)
        displayLink = CADisplayLink.init(target: self, selector: #selector(FPSlink(link:)))
        displayLink?.add(to: RunLoop.current, forMode: .commonModes)
    }
    @objc func FPSlink(link: CADisplayLink) {
        if _lastTime == 0 {
            _lastTime = link.timestamp
            return
        }
        _count += 1
        let delta = link.timestamp - _lastTime
        if delta < 1 {
            return
        }
        
        _lastTime = link.timestamp
        let fps = Double(_count) / delta
        _count = 0
        fpsLabel?.text = "\(Int(fps+0.5))FPS"
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }

}

// MARK: - delegate dataSource
extension DetailSearchController: DetailSearchViewModelDelegate,UITableViewDelegate,UITableViewDataSource{
    func fetchDataFinish() {
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return detailViewModel.resultItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let stepModel = detailViewModel.resultSteps[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: stepCellID) as? PSTableViewCell
        if cell == nil {
//            cell = Bundle.main.loadNibNamed("PSStepCell", owner: self, options: nil)?.last as! PSStepCell
            cell = PSTableViewCell.init(style: .default, reuseIdentifier: stepCellID)
        }
        cell?.detailmodel = stepModel
        cell?.setFrameWithModel()
        cell?.delegate = self
//        print(cell?.iconView.frame.height)
        return cell!
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let model = detailViewModel.resultSteps[indexPath.row]
//
//        return model.cellHeight
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(imageArray[indexPath.row])
        let cell = tableView.cellForRow(at: indexPath) as! PSTableViewCell
        let imgHeig: CGFloat = 1.0
        if cell.iconView.frame.size.height < imgHeig {
            return
        }
        /// 加载方法1
//        let BrowseVc = BrowseViewController.init(imageCounts: picArray, currentIndexP: indexPath, imageInfoArray: imageArray)
//        //设置自定义modal
//        BrowseVc.modalPresentationStyle = .custom
//        BrowseVc.transitioningDelegate = photoAnimation
//
//        photoAnimation.setProperty(indPath: indexPath, self as BrowsePresentDelegate, BrowseVc as BrowseDismissDelegate)
//        present(BrowseVc, animated: true, completion: nil)
        /// 加载方法2
//        let dataSource = XSLLocalImageDataSource(numberOfItems: { () -> Int in
//            return self.imageArray.count
//        }) { (index) -> UIImage? in
//
//        }
        /// 方案3
//        let netDataSource = XSLNetWorkImageDataSource(numberOfItems: { () -> Int in
//            return self.imageArray.count
//        }, placeholder: { (index) -> UIImage? in
//            return nil
//        }) { (index) -> String? in
//            let pic = self.imageArray[index]
//            return pic.big
//        }
//        let delegate = XSLPhotoBrowserAssembler()
//        let browser = XSLPhotoBrowser(pageIndex: indexPath.item, dataSource: netDataSource, delegate: delegate)
//        present(browser, animated: true, completion: nil)
    }
}
//
extension DetailSearchController: PSTableViewCellDelegate{
    func iconViewDidSelect() {
        //进入新的控制器
//        let imgArray: NSMutableArray = []
//        for a  in detailViewModel.resultSteps {
//            print(a)
//            if a.pic_urls.count != 0 {
//                imgArray.add(a.pic_urls[0])
//            }
//        }
//        let BrowseVc = BrowseViewController.init(imageCounts: imgArray, currentIndexP: )

    }
}
extension DetailSearchController: BrowsePresentDelegate{
    func imageForPresent(indexPath: IndexPath) -> UIImageView {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.clipsToBounds = true
        //设置图片
//        let imageIndex = imageArray[indexPath.row] as! String
//        imageV.image = UIImage(named: imageIndex)
        let imgURL = picArray[indexPath.row] as! String
        imageV.sd_setImage(with: URL.init(string: imgURL), completed: nil)
        return imageV
        
    }
    
    func startImageRectForPresent(indexPath: IndexPath) -> CGRect {
        // 1.取出cell
        guard let cell = tableView?.cellForRow(at: indexPath) else {
//            return CGRect(x: collectionView!.bounds.width * 0.5, y: kScreenHeight + 50, width: 0, height: 0)
            return CGRect(x: tableView.bounds.width * 0.5, y: kScreenHeight, width: 0, height: 0)
        }
        
        let imgW = CGFloat(imageArray[indexPath.row].width)
        let imgH = CGFloat(imageArray[indexPath.row].height)
        let imageH = kScreenWidth * imgH/imgW

        let imageVFrame = CGRect(x: 0, y: cell.frame.origin.y+25, width: kScreenWidth, height:imageH )
        return tableView!.convert( imageVFrame, to: UIApplication.shared.keyWindow)

        // 2.计算转化为UIWindow上时的frame
//        return tableView!.convert( cell.frame, to: UIApplication.shared.keyWindow)
    }
    
    func endImageRectForPresent(indexPath: IndexPath) -> CGRect {
//        let imageIndex = pic[indexPath.row]
//        let icon = UIImage(named: imageIndex as! String)
        let imgW = CGFloat(imageArray[indexPath.row].width)
        let imgH = CGFloat(imageArray[indexPath.row].height)
        let imageH = kScreenWidth * CGFloat (imgH/imgW)
        let y = imageH < kScreenHeight ? (kScreenHeight - imageH) / 2 : 0
        
        return CGRect(x: 0, y: y, width: kScreenWidth, height: imageH)
        
    }}

