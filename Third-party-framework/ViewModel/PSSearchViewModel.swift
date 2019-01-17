//
//  PSSearchViewModel.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/9/18.
//  Copyright © 2018年 廖佩志. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
protocol PSSearchViewModelDelegate :NSObjectProtocol{
    func fetchDataFinish() 
}
class PSSearchViewModel: NSObject {
    var delegate: PSSearchViewModelDelegate?
    var searchUrl = "https://newapi.meishi.cc/search/recipe"
    var cid: String = ""
    var keyword: String = "豆腐"
    var page: String = "1"
    var searchDict: [String :Any]{
        return["cid": cid,"keyword": keyword, "page": page]
    }
    var resultItems: [Any] = []
    var manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        configuration.timeoutIntervalForResource = 120
        let man = SessionManager(configuration: configuration)
        return man
    }()
    func fetchSearchDataList(){
        
        
            let searchUrl = "https://newapi.meishi.cc/search/recipe"
            
            manager.request(searchUrl, method: .post, parameters: searchDict, encoding: URLEncoding.default, headers:nil ).responseJSON { (response) in
                if let dict = response.result.value as? Dictionary<String, Any> {
                    let json = JSON(dict)
                    let dataDict = json["data"].dictionary
                    let itemsArray = dataDict!["items"]?.arrayObject
//                    let itemsArray = json["data"]["items"].arrayObject
//                    print(itemsArray!)
                    self.resultItems = itemsArray!
//                    print(self.resultItems.count)
                    self.delegate?.fetchDataFinish()

                }
                
            }        
    }
}
