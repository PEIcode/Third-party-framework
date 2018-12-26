//
//  TestViewController.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/12/21.
//  Copyright © 2018 廖佩志. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBAction func bottomBtnClick(_ sender: UIButton) {
        print("123123")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func preferredScreenEdgesDeferringSystemGestures() -> UIRectEdge {
        return .bottom
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
