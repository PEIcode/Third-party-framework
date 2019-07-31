//
//  BaseViewController.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2019/7/18.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func openAlbum(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        present(vc, animated: false, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info["UIImagePickerControllerImageURL"] as! URL)
        //key UIImagePickerControllerEditedImage
        let image = info["UIImagePickerControllerEditedImage"]
        let path = info["UIImagePickerControllerImageURL"] as! URL


//        let imgStr = try? String(contentsOf: path)
//        let img = UIImage(contentsOfFile: imgStr!)

//        let data = try? Data(contentsOf: path)
//        let img = UIImage(data: data!)
//        let img = UIImage(named: path.absoluteString)
        let img = UIImage(contentsOfFile: path.absoluteString)

        let imgV = UIImageView(frame: CGRect(x: 100, y: 400, width: 300, height: 300))
        imgV.image = image as? UIImage
        view.addSubview(imgV)
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
