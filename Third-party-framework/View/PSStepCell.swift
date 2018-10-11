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
    
    var detailmodel: DetailModel? {
        didSet{
            guard let model = detailmodel else {
                return
            }
            titleLab.text = model.title
            let imgURL =  model.pic_urls[0].big
            
            iconView.sd_setImage(with: URL(string: imgURL), completed: nil)
        }
    }
    var height: Float {
        return detailmodel!.height + 33;
    }
    
//    var detaiModel: DetailModel = DetailModel()
//    var detailViewModel: DetailSearchViewModel = DetailSearchViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    func setDetailModel(detailVModel:DetailSearchViewModel) {
//        detailViewModel = detailVModel
////        titleLab.text = detailVModel.
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
