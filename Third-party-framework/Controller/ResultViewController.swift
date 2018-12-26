//
//  ResultViewController.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/9/25.
//  Copyright © 2018 廖佩志. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var keySearchWord = ""
    
    ///
    var searchViewModel = PSSearchViewModel()
    
    lazy var tableView : UITableView = {
        let tab = UITableView.init(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        //        tab.separatorStyle = .none
        return tab
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120
        view.addSubview(tableView)
        
        searchViewModel.delegate = self
    }

    func changeForResult() {
        searchViewModel.keyword = keySearchWord
        searchViewModel.fetchSearchDataList()
    }
}
//MARK: - tableView的数据源代理方法
extension ResultViewController: UITableViewDelegate,UITableViewDataSource,PSSearchViewModelDelegate{
    
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
//        print(iconStr!)
        //        let iconUrl = NSURL.init(string: iconStr!)
        let url = URL.init(string: iconStr!)
        //        let data = NSData.init(contentsOfFile: )
        //        let data2 = try?  Data.init(contentsOf: url!)
        //        let img = UIImage.init(data:data2!)
        //
        //        设置cell的imageView
//        cell?.imageView?.sd_setImage(with: url!, completed: nil)
        cell?.imageView?.sd_setImage(with: url!, placeholderImage: nil, options:.cacheMemoryOnly, completed: nil)
        return cell!
    }
    func fetchDataFinish() {
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVc = DetailSearchController()
        let cell = tableView.cellForRow(at: indexPath)!
//        tableView.cellForRow(at: indexPath)
        let model = searchViewModel.resultItems[indexPath.row] as! Dictionary<String,Any>
        detailVc.str = cell.textLabel?.text
        detailVc.id = model["id"] as? String
        present(detailVc, animated: true, completion: nil)
        
    }
}
