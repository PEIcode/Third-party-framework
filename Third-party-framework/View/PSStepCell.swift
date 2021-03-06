//
//  PSStepCell.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/9/29.
//  Copyright © 2018 廖佩志. All rights reserved.
//

import UIKit
import SDWebImage
class PSStepCell: UITableViewCell {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var iconHeigtConstraint: NSLayoutConstraint!
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
            iconView.contentMode = .scaleAspectFill
            iconView.clipsToBounds = true
            iconView.sd_setImage(with: url, completed: nil)
            // 计算高度
//            let contentFrame = self.contentLab.sizeThatFits(CGSize(width: self.contentLab.frame.width, height: CGFloat(MAXFLOAT)))
//            print(contentFrame.height)
            if model.pic_urls.count != 0 {
                let imgHeight = CGFloat(model.pic_urls[0].height)
                let imgWidth = CGFloat(model.pic_urls[0].width)
                let iconheigt = UIScreen.main.bounds.width * imgHeight/imgWidth
                
                iconHeigtConstraint.constant = iconheigt
            }else {
                iconHeigtConstraint.constant = 0
            }
//            model.cellHeight = contentFrame.height + iconheigt + 25.0
        }
    }
    
    var height: CGFloat{
        return (detailmodel?.cellHeight)!
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
