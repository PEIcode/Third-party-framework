//
//  ViewController.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/9/17.
//  Copyright © 2018年 廖佩志. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    var searchDict: [String :Any]{
        return["cid": "","keyword": "豆腐", "page": "1"]
    }
    var manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        configuration.timeoutIntervalForResource = 120
        let man = SessionManager(configuration: configuration)
        return man
    }()

    @IBOutlet weak var iconView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let searchUrl = "https://newapi.meishi.cc/search/recipe"
        //POST /search/recipe HTTP/1.1
//        Alamofire
//        let a = SessionManager()
        manager.request(searchUrl, method: .post, parameters: searchDict, encoding: URLEncoding.default, headers:nil ).responseJSON { (response) in
            let status = response.result
            switch status{
                case .success:
                    print("request success!!!")
                    print(response)
                case .failure(let error):
                    print("failure!!!\(error)")
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

