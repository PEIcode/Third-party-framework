//
//  PSTableViewCell.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/10/16.
//  Copyright © 2018 廖佩志. All rights reserved.
//

import UIKit

class PSTableViewCell: UITableViewCell {
    
    var titleLab: UILabel!
    var iconView: UIImageView!
    var contentLab: UILabel!
    var iconViewHeight: CGFloat?
    var contentLabHeight: CGFloat?
    let titleLabHeigt: CGFloat = 25.0
    var imgURL: String = ""
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
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    func setupUI() {
        titleLab = UILabel()
        contentView.addSubview(titleLab)
        

        iconView = UIImageView()
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        iconView.sizeToFit()
        contentView.addSubview(iconView)
        
        
        contentLab = UILabel()
        contentLab.backgroundColor = UIColor.red
        contentLab.numberOfLines = 0
        contentView.addSubview(contentLab)
    }
    func setFrameWithModel(model: DetailModel){
//        let contentFrame = self.contentLab.sizeThatFits(CGSize(width: UIScreen.main.bounds.width, height: CGFloat(MAXFLOAT)))
//        contentLabHeight = contentFrame.height
//        let imgHeight = CGFloat(model.pic_urls[0].height)
//        let imgWidth = CGFloat(model.pic_urls[0].width)
//        let iconheigt = UIScreen.main.bounds.width * imgHeight/imgWidth
//        iconViewHeight = iconheigt
//        model.cellHeight = contentFrame.height + iconheigt + 25.0
    
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.width.equalToSuperview()
            make.height.equalTo(self.titleLabHeigt)
        }
//        iconView.snp.makeConstraints { (make) in
//            make.width.equalToSuperview()
////            make.height.equalTo(self.iconViewHeight!)
//            make.top.equalTo(self.titleLab.snp.bottom).offset(5)
//            make.center.equalToSuperview()
//        }
        contentLab.snp.makeConstraints { (make) in
            make.top.equalTo(self.iconView.snp.bottom)
            make.bottom.equalToSuperview().offset(2)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
//            make.height.equalTo(self.contentLabHeight!)
        }
        
        iconView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            //            make.height.equalTo(self.iconViewHeight!)
            make.top.equalTo(self.titleLab.snp.bottom).offset(5)
            make.bottom.equalTo(self.contentLab.snp.top)
//            make.center.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
