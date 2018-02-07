//
//  WCLImagePikcerDelegate.swift
//  WCLImagePickrController-swift
//
// **************************************************
// *                                  _____         *
// *         __  _  __     ___        \   /         *
// *         \ \/ \/ /    / __\       /  /          *
// *          \  _  /    | (__       /  /           *
// *           \/ \/      \___/     /  /__          *
// *                               /_____/          *
// *                                                *
// **************************************************
//  Github  :https://github.com/631106979
//  HomePage:https://imwcl.com
//  CSDN    :http://blog.csdn.net/wang631106979
//
//  Created by 王崇磊 on 16/9/14.
//  Copyright © 2016年 王崇磊. All rights reserved.
//
// @class WCLImagePikcerDelegate
// @abstract WCLImagePikcerVC的Delegate
// @discussion WCLImagePikcerVC的Delegate
//

import UIKit

public class WCLImage {
    public var fullScreenImage: UIImage?
    public var thumbImage: UIImage?
    public init() {}
}

public protocol WCLImagePikcerDelegate: class {
    /// 点击取消按钮的回调方法
    func wclImagePickerCancel(_ picker: WCLImagePickerController) -> Void
    /// 选择完成后的回调方法
    func wclImagePickerComplete(_ picker: WCLImagePickerController, imageArr: [UIImage]) -> Void
    
    /// 选择完成后的回调方法
    func wclImagePickerComplete(_ picker: WCLImagePickerController, wclImages: [WCLImage]) -> Void
    /// 反馈错误信息的回调方法
    func wclImagePickerError(_ picker: WCLImagePickerController, error: WCLError) -> Void
}

extension WCLImagePikcerDelegate {
    public func wclImagePickerCancel(_ picker: WCLImagePickerController) -> Void {}
    public func wclImagePickerComplete(_ picker: WCLImagePickerController, imageArr: [UIImage]) -> Void {}
    public func wclImagePickerComplete(_ picker: WCLImagePickerController, wclImages: [WCLImage]) -> Void {}
    public func wclImagePickerError(_ picker: WCLImagePickerController, error: WCLError) {
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
}
