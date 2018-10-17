//
//  PSTableViewCell.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/10/16.
//  Copyright © 2018 廖佩志. All rights reserved.
//

import UIKit
protocol PSTableViewCellDelegate: NSObjectProtocol{
    func iconViewDidSelect()
}

class PSTableViewCell: UITableViewCell {
    
    var titleLab: UILabel!
    var iconView: UIImageView!
    var contentLab: UILabel!
    var iconViewHeight: CGFloat = 150
    var contentLabHeight: CGFloat = 0
    let titleLabHeigt: CGFloat = 25.0
    var imgURL: String = ""
    weak var delegate: PSTableViewCellDelegate?
    var detailmodel: DetailModel? {
        didSet{
            guard let model = detailmodel else {
                return
            }
            titleLab.text = model.title
            contentLab.text = model.content
            if model.pic_urls.count != 0 {
                imgURL =  model.pic_urls[0].big
            }
            let url = URL.init(string: imgURL)
            iconView.sd_setImage(with: url, completed: nil)
            if model.pic_urls.count != 0 {
                let imgHeight = CGFloat( model.pic_urls[0].height)
                let imgWidth = CGFloat(model.pic_urls[0].width)
                iconViewHeight = UIScreen.main.bounds.width * imgHeight/imgWidth
            }

        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
        let contentSize = self.contentLab .sizeThatFits(CGSize.init(width: UIScreen.main.bounds.width, height: CGFloat(MAXFLOAT)))
        contentLabHeight = contentSize.height
//        if detailmodel.pic_urls.count != 0 {
//            let imgHeight = CGFloat( self.pic_urls[0].height)
//            let imgWidth = CGFloat(self.pic_urls[0].width)
//            iconHeigt = UIScreen.main.bounds.width * imgHeight/imgWidth
//        }
    }
    func setupUI() {
        titleLab = UILabel()
        contentView.addSubview(titleLab)
        

        iconView = UIImageView()
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        iconView.sizeToFit()
        iconView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(iconTouch))
        iconView.addGestureRecognizer(tap)
        contentView.addSubview(iconView)
        
        
        contentLab = UILabel()
        contentLab.backgroundColor = UIColor.red
        contentLab.numberOfLines = 0
        contentView.addSubview(contentLab)
    }
    /// 约束的代码 不需要后面的参数
    func setFrameWithModel(){
    
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.width.equalToSuperview()
            make.height.equalTo(self.titleLabHeigt)
        }
        
        iconView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(self.iconViewHeight)
            make.top.equalTo(self.titleLab.snp.bottom).offset(5)
            make.bottom.equalTo(self.contentLab.snp.top)
//            make.height.greaterThanOrEqualTo(self.iconViewHeight)
        }
        contentLab.snp.makeConstraints { (make) in
            make.top.equalTo(self.iconView.snp.bottom)
            make.bottom.equalToSuperview().offset(2)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
//                        make.height.equalTo(self.contentLabHeight)
        }
    }
    
    @objc func iconTouch(){
        self.delegate?.iconViewDidSelect()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
