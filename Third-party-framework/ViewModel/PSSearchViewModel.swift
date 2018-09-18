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
class PSSearchViewModel: NSObject {
    
    var searchUrl = "https://newapi.meishi.cc/search/recipe"
    var searchDict: [String :Any]{
        return["cid": "0","keyword": "豆腐", "page": "1"]
    }
    var manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        configuration.timeoutIntervalForResource = 120
        let man = SessionManager(configuration: configuration)
        return man
    }()
    func fetchSearchDataList(){
        let request = Alamofire.request("https://newapi.meishi.cc/search/recipe")
        
        print(request)
        manager.request(searchUrl, method: .post, parameters: searchDict, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
            print("lpzhhhhhh----\(response.result)")
        }
    }
}
