//
//  SearchModel.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/9/18.
//  Copyright © 2018年 廖佩志. All rights reserved.
//

import UIKit
import SwiftyJSON
class SearchModel: NSObject {
    
    /// 这个应该是用户id
    var cid :Int = 0
    
    /// 格式
    var format :String = "json"
    
    /// 搜索关键字
    var keyword :String = ""
    
    /// 页数
    var page :Int = 0
    
    /// 每页个数
    var per_page :Int = 10
    
    /// 顶部配菜列表（这里不需要）
    var about_ingredient: String = "about_ingredient"
    var dict: [String :Any]{
        return ["keyword":keyword,"page":page,"per_page":per_page]
    }
    init?(json:JSON){
        if json.isEmpty {
            return nil
        }
        self.keyword = json["keyword"].stringValue
        self.page = json["page"].intValue
        self.per_page = json["per_page"].intValue
    }
//    init(keyword :String, page :Int = 1, per_page :Int = 10) {
//        self.keyword = keyword
//        self.page = page
//        self.per_page = per_page
//    }
}
class cellItems: NSObject {
//    "item_type" : "1",
//    "img" : "http:\/\/s1.st.meishij.net\/r\/26\/238\/1309526\/s1309526_12003.jpg?imageMogr2\/gravity\/Center\/crop\/328x328",
//    "label" : [
//    {
//    "name" : "家常菜",
//    "desc" : "天涯海角最念的味道"
//    }
//    ],
//    "id" : "602359",
//    "viewed_amount" : "379421",
//    "title" : "水煮豆腐",
//    "author" : {
//    "id" : "1309526",
//    "nickname" : "乐悠厨房",
//    "avatar_url" : "http:\/\/s1.st.meishij.net\/user\/26\/238\/st1309526_149731666855550.jpg"
//    },
//    "context" : {
//    "scene_id" : "10001",
//    "trace_id" : "ali#1111",
//    "item_type" : "recipe"
//    },
//    "rate" : "5",
//    "favor_amount" : "25397"
    
    ///目前只需要 title 和 img 和 id。结果列表可以显示（配图、点赞数、title）
    var img: String?
    var title: String?
    var id: String?
    init(jsonData:JSON){
        self.img = jsonData["img"].stringValue
        self.title = jsonData["title"].stringValue
    }
}
