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
    
    init?(json: JSON) {
        if json.isEmpty{
            return nil
        }
        self.id = json["id"].stringValue
        self.title = json["title"].stringValue
        self.pic_urls = json["pic_urls"].arrayValue.map(pic.init)
        self.content = json["content"].stringValue
    }
    init(id: String = "", title: String, pic_urls: [pic], content: String) {
        self.id = id
        self.title = title
        self.pic_urls = pic_urls
        self.content = content
    }
    var height: Float {
        
        return 200.0
    }
}
class pic: Codable {
    let big: String
    let width,height: Int
    init(big: String, width: Int, height: Int) {
        self.big = big
        self.width = width
        self.height = height
    }
    init(_ json: JSON) {
        self.big = json["big"].stringValue
        self.width = json["width"].intValue
        self.height = json["height"].intValue
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

