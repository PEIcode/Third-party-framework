//
//  DetailSearchViewModel.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/9/29.
//  Copyright © 2018 廖佩志. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol DetailSearchViewModelDelegate :NSObjectProtocol{
    func fetchDataFinish()
    
}

class DetailSearchViewModel: NSObject {
    weak var delegate: DetailSearchViewModelDelegate?
    var cellHeight: CGFloat = 0
    var detailModel: DetailModel!
//    var detailURL = "https://newapi.meishi.cc/recipe/detail"
    var id: String = ""
    var type: String = "2"
    var searchDict: [String :Any]{
        return["id":id,"type":type]
    }
    var resultItems: [Any] = []
    var resultSteps = Array<DetailModel>()
    var manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        configuration.timeoutIntervalForResource = 120
        let man = SessionManager(configuration: configuration)
        return man
    }()
    func fetchSearchDataList(){
        
        
        let detailURL = "https://newapi.meishi.cc/recipe/detail"
        
        manager.request(detailURL, method: .post, parameters: searchDict, encoding: URLEncoding.default, headers:nil ).responseJSON { (response) in
                        if let dict = response.result.value as? Dictionary<String, Any> {
                let json = JSON(dict)
//                                    print(json)
                //                print(json["data"].dictionary ?? "oo")
                let dataDict = json["data"].dictionary
                let itemsArray = dataDict?["cook_steps"]?.arrayObject
//                            print(itemsArray!)
                            
                let detailMS = json["data"]["cook_steps"].arrayValue.flatMap(DetailModel.init)
                            
                for detailM in detailMS{
                    self.resultSteps.append(detailM)
                }
                
//                print(self.resultSteps)
//                detailModel = itemsArray.map(DetailModel.init)
                //                    let itemsArray = json["data"]["items"].arrayObject
                //                    print(itemsArray!)
                guard let items = itemsArray else {
                    
                    return
                    
                }
                self.resultItems = items
//                print(self.resultItems)
                self.delegate?.fetchDataFinish()
                
                
                
            }
            
        }
    }
//    func setDetailModel(model: DetailModel) {
//        detailModel = model
//        detailModel.content = self.resultItems["content"] as? String
//        detailModel.title = self.resultItems[""]
        
//    }
}
