//
//  ViewController.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/9/17.
//  Copyright © 2018年 廖佩志. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
class ViewController: UIViewController,UISearchControllerDelegate,UISearchResultsUpdating{
    
    
    var searchViewModel = PSSearchViewModel()
    
//    var resultItems: [Any] = []
    var searchDict: [String :Any]{
        return["cid": "","keyword": "豆腐!", "page": "1"]
    }
    
    lazy var manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        configuration.timeoutIntervalForResource = 120
        let man = SessionManager(configuration: configuration)
        return man
    }()
     var ResultVc = ResultViewController()
    
    /// SearchVc
    lazy var seaechVC: UISearchController = {
        let sea = UISearchController.init(searchResultsController: ResultVc)
        sea.searchBar.placeholder = "搜索🔍"
        sea.searchBar.text = ""
        sea.hidesNavigationBarDuringPresentation = true
        sea.searchBar.sizeToFit()
        return sea
    }()
    lazy var tableView : UITableView = {
        let tab = UITableView.init(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        return tab
    }()
    @IBOutlet weak var iconView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.searchViewModel.delegate = self
//        self.searchViewModel.fetchSearchDataList()
        
        
//        UseAlamofire()
        
        seaechVC.delegate = self
        seaechVC.searchResultsUpdater = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = seaechVC.searchBar
        view.addSubview(tableView)
        
        
       
    }
    //UISearchResultsUpdating方法
    func updateSearchResults(for searchController: UISearchController) {
        let result = seaechVC.searchBar.text
        ResultVc.keySearchWord = result!
        ResultVc.changeForResult()
//        searchViewModel.fetchSearchDataList()
        
    }

    
   
}
//MARK: - tableView的数据源代理方法
extension ViewController: UITableViewDelegate,UITableViewDataSource,PSSearchViewModelDelegate{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.resultItems.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "searchCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellID)
        }
        let model = searchViewModel.resultItems[indexPath.row] as! Dictionary<String,Any>
        cell?.textLabel?.text = model["title"] as? String
        let iconStr = model["img"] as? String
        print(iconStr!)
//        let iconUrl = NSURL.init(string: iconStr!)
        let url = URL.init(string: iconStr!)
//        let data = NSData.init(contentsOfFile: )
//        let data2 = try?  Data.init(contentsOf: url!)
//        let img = UIImage.init(data:data2!)
//
//        设置cell的imageView
        cell?.imageView?.sd_setImage(with: url!, completed: nil)
        return cell!
    }
    func fetchDataFinish() {
        tableView.reloadData()
    }
}
//MARK: - 测试网络请求
extension ViewController{
    //MARK: 测试网络请求
    private func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []
        
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key] as! String
            //直接转换
            //            let encoding = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            //            components += [(key,encoding)]
            //使用方法
            components += URLEncoding.default.queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
    
    func useURLSession() {
        let searchUrl = URL.init(string: "https://newapi.meishi.cc/search/recipe")
        //        let jsondata = try! JSONSerialization.data(withJSONObject: searchDict, options: [])
        var request = URLRequest.init(url: searchUrl!)
        request.httpMethod = "POST"
        
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //        request.httpBody = jsondata
        request.httpBody = query(searchDict).data(using: .utf8, allowLossyConversion: false)
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        
        let task = session.dataTask(with: request) { (data, responce, error) in
            //            print(data ?? "NO data",responce ?? "mei" ,error ?? "请求👌")
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            //            print(json!)
            //            print(json as! Dictionary<String,Any>! as Any )
            let dict = json as! Dictionary<String,Any>!
            let dataDict = dict!["data"] as! Dictionary<String,Any>!
            //这是所有的数据
            //            print(dataDict!)
            // 推荐关键字
            //            print(dataDict!["about_ingredient"] ?? "数据不存在")
            // items
            let itemsArray = dataDict!["items"]
            print(itemsArray!)
        }
        task.resume()
    }
    
    /// 使用Alamofire请求数据
    func UseAlamofire() {
        let searchUrl = "https://newapi.meishi.cc/search/recipe"
        
        manager.request(searchUrl, method: .post, parameters: searchDict, encoding: URLEncoding.default, headers:nil ).responseJSON { (response) in
            //            try? JSONSerialization.jsonObject(with: response.data!, options: [])
            //            String(data: response.data!, encoding: String.Encoding.utf8)
            //            let status = response.result
            //            switch status{
            //            case .success:
            //                print("request success!!!")
            //                print(response)
            //            case .failure(let error):
            //                print("failure!!!\(error)")
            //            }
            if let dict = response.result.value as? Dictionary<String, Any> {
                let json = JSON(dict)
                
                //                print(json["data"].dictionary ?? "oo")
                let dataDict = json["data"].dictionary
                //当前页数的所有items
                let itemsArray = dataDict!["items"]
                //                self.resultItems = dataDict!["items"]
                //                self.resultItems = (itemsArray?.arrayObject)!
                //                print(self.resultItems.count)
                //                self.tableView.reloadData()
                //                print(itemsArray?.count ?? "没有数据")
                
            }
            
        }
    }
}

