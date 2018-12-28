//
//  DetailModel.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/9/29.
//  Copyright © 2018 廖佩志. All rights reserved.
//

import UIKit
import SwiftyJSON
class DetailModel: NSObject {
    var id: String = ""
    var title: String = ""
    var pic_urls: [pic] = []
    var content: String = ""
    var cellHeight: CGFloat = 0
    var iconHeigt: CGFloat = 0
    var contentHeight: CGFloat = 0
    init?(json: JSON) {
        if json.isEmpty{
            return nil
        }
        self.id = json["id"].stringValue
        self.title = json["title"].stringValue
        self.pic_urls = json["pic_urls"].arrayValue.map(pic.init)
        print(pic_urls)
        self.content = json["content"].stringValue
        super.init()
        /**
         * 目前是直接约束 PStableViewCell的高度，这里cellHeight没有用到
         */
//        contentHeight = self.getNormalStrH(str: content, strFont: 17, w: UIScreen.main.bounds.size.width)
//        if self.pic_urls.count != 0 {
//            let imgHeight = CGFloat( self.pic_urls[0].height)
//            let imgWidth = CGFloat(self.pic_urls[0].width)
//            iconHeigt = UIScreen.main.bounds.width * imgHeight/imgWidth
//        }
//
//        cellHeight = contentHeight + 25 + iconHeigt
        
    }
    
//    func getNormalStrH(str: String, strFont: CGFloat, w: CGFloat) -> CGFloat {
//        return getNormalStrSize(str: str, font: strFont, w: w, h: CGFloat.greatestFiniteMagnitude).height
//    }
//
//    private func getNormalStrSize(str: String? = nil, attriStr: NSMutableAttributedString? = nil, font: CGFloat, w: CGFloat, h: CGFloat) -> CGSize {
//        if str != nil {
//            let strSize = (str! as NSString).boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: font)], context: nil).size
//            return strSize
//        }
//
//        if attriStr != nil {
//            let strSize = attriStr!.boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, context: nil).size
//            return strSize
//        }
//
//        return CGSize.zero
//    }
}
class pic {
    var big: String = ""
    var width: Int = 0
    var height: Int = 0
    init(_ json: JSON) {
        self.big = json["big"].stringValue
        self.width = json["width"].intValue
        self.height = json["height"].intValue
    }
    init(big:String = "", width: Int = 0, height: Int = 0) {
        
    }
}
/// 步骤参数
//"id":"4041611",
//"title":"步骤1",
//"duration":"0",
//"pic_urls":[
//{
//"big":"http://s1.st.meishij.net/rs/44/110/4152544/n4152544_149840171253734.jpg",
//"width":240,
//"height":160
//}
//],
//"content":"各材料",
//"tips":{
//    "title":"",
//    "content":"",
//    "pic_url":{
//
//    }
//}

