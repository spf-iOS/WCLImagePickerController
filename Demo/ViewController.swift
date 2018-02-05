//
//  ViewController.swift
//  Demo
//
//  Created by 王崇磊 on 2017/1/10.
//  Copyright © 2017年 王崇磊. All rights reserved.
//

import UIKit
import WCLImagePickerController

class ViewController: UIViewController, WCLImagePikcerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var bottomImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        WCLImagePickerOptions.isShowLaunch = false
        WCLImagePickerOptions.navigationTintColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1)
        WCLImagePickerOptions.navigationImageColor = UIColor(red: 155.0/255.0, green: 155.0/255.0, blue: 155.0/255.0, alpha: 1)
        WCLImagePickerOptions.tintColor = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1)
        WCLImagePickerOptions.pickerSelectColor = UIColor(red: 5.0/255.0, green: 180.0/255.0, blue: 111.0/255.0, alpha: 1)
        WCLImagePickerOptions.statusBarStyle = .default
    }

    @IBAction func buttonAction(_ sender: Any) {
        /// 初始化，直接present出WCLImagePickerController
//        WCLImagePickerController.present(inVC: self, delegate: self)
        /// 或者只初始化WCLImagePickerController.init
        /// WCLImagePickerController.init(delegate: self)
//        WCLImagePickerOptions.isShowSelecView = false
        MGPhotoLib.showView(selectMaxNum: 1, inVC: self.navigationController) { (images) in
            if let firstImage = images.first {
                let cropImage = firstImage.cropImage(withSize: CGSize(width: 100, height: 100))!
                self.imageView.image = cropImage
                let cropImage1 = firstImage.cropImage(withSize: CGSize(width: 100, height: 100), withCropMode: .center)!
                self.bottomImageView.image = cropImage1
            }
        }
//        MGPhotoLib.showView(selectMaxNum: 1) { (images) in
//            print("\(images)")
//        }
    }
    
    func wclImagePickerCancel(_ picker: WCLImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func wclImagePickerComplete(_ picker: WCLImagePickerController, imageArr: [UIImage]) {
        picker.dismiss(animated: true, completion: nil)
        print(imageArr)
    }
    
    func wclImagePickerError(_ picker: WCLImagePickerController, error: WCLError) {
        let al = UIAlertController.init(title: nil, message: error.lcalizable, preferredStyle: .alert)
        let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        al.addAction(cancel)
        if error != .noMoreThanImages {
            let ok = UIAlertAction(title: "去设置", style: .default,
                                   handler: {
                                    action in
                                    guard let phoneURL = URL(string: UIApplicationOpenSettingsURLString) else {  return
                                    }
                                    UIApplication.shared.openURL(phoneURL)
            })
            al.addAction(ok)
        }
        picker.present(al, animated: true, completion: nil)
    }
    
    @IBAction func lineChange(_ sender: UISegmentedControl) {
        let line = sender.selectedSegmentIndex + 3
        WCLImagePickerOptions.photoLineNum = line
    }
    
    
    @IBAction func tintColorChange(_ sender: UISegmentedControl) {
        let color = [UIColor(red: 49/255, green: 47/255, blue: 47/255, alpha: 1), UIColor.blue, UIColor.white][sender.selectedSegmentIndex]
        WCLImagePickerOptions.tintColor = color
    }
    
    
    @IBAction func hideBottom(_ sender: UISegmentedControl) {
        let need = sender.selectedSegmentIndex == 0 ? true : false
        WCLImagePickerOptions.isShowSelecView = need
    }
    
    @IBAction func statsBarChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            WCLImagePickerOptions.statusBarStyle = .lightContent
        }else {
            WCLImagePickerOptions.statusBarStyle = .default
        }
    }
    
    @IBAction func maxSelectNum(_ sender: UISegmentedControl) {
        let max = [3, 4, 5][sender.selectedSegmentIndex]
        WCLImagePickerOptions.maxPhotoSelectNum = max
    }
    
    @IBAction func needCamare(_ sender: UISegmentedControl) {
        let need = sender.selectedSegmentIndex == 0 ? true : false
        WCLImagePickerOptions.needPickerCamera = need
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

