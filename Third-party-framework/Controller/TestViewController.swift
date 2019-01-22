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
    @IBAction func quitBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //path    String    "/Users/liaopeizhi/Library/Developer/CoreSimulator/Devices/1A5C7CAD-DD5C-443A-B5F9-12DB810905A4/data/Containers/Data/Application/3A2937CE-E424-41E7-9787-A8413E966293/Documents/xingshulin/2026313/patients/534772/832741A4-69A4-4CFE-9193-167933811DEA/C4D1F49A-67DD-4ACE-B519-1D921E5F5770.jpeg"
        //"file:///Users/liaopeizhi/Library/Developer/CoreSimulator/Devices/1A5C7CAD-DD5C-443A-B5F9-12DB810905A4/data/Containers/Data/Application/8F44068C-0647-40F1-923C-9FB2B55A8D80/Documents/xingshulin/2026313/patients/534772/832741A4-69A4-4CFE-9193-167933811DEA/C4D1F49A-67DD-4ACE-B519-1D921E5F5770.jpeg"
        let path = NSHomeDirectory() + "/Documents/xingshulin/2026313/patients/534772/832741A4-69A4-4CFE-9193-167933811DEA/C4D1F49A-67DD-4ACE-B519-1D921E5F5770.jpeg"
//        let url = URL(fileURLWithPath: "file:///Users/liaopeizhi/Library/Developer/CoreSimulator/Devices/1A5C7CAD-DD5C-443A-B5F9-12DB810905A4/data/Containers/Data/Application/8F44068C-0647-40F1-923C-9FB2B55A8D80/Documents/xingshulin/2026313/patients/534772/832741A4-69A4-4CFE-9193-167933811DEA/C4D1F49A-67DD-4ACE-B519-1D921E5F5770.jpeg")
//        NSHomeDirectory()

//        let data = NSData(contentsOf: url)
        let img = UIImage(contentsOfFile: path)
        let imageV = UIImageView(image:img)
        imageV.backgroundColor = .red
        imageV.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        view.addSubview(imageV)
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
