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
    init(keyword :String, page :Int = 1, per_page :Int = 10) {
        self.keyword = keyword
        self.page = page
        self.per_page = per_page
    }
}
