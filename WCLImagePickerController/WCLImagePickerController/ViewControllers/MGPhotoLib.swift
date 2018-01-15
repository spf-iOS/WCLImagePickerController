//
//  MGPhotoTool.swift
//  WCLImagePickerController
//
//  Created by song on 2018/1/15.
//  Copyright © 2018年 王崇磊. All rights reserved.
//

import UIKit

public let MGPhotoLib = MGPhotoTool.share

public class MGPhotoTool {
    public static var share: MGPhotoTool = MGPhotoTool()
    
    public typealias MGPhotoImageBlock = (_ images:[UIImage]) ->()
    
    private var imageBlock: MGPhotoImageBlock?
    
    public func showView(selectMaxNum num:Int,
                         completionBlock: @escaping MGPhotoImageBlock) {
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else { return }
        WCLImagePickerOptions.maxPhotoSelectNum = 3
        imageBlock = completionBlock
        WCLImagePickerController.present(inVC: vc, delegate: self)
    }
}

extension MGPhotoTool: WCLImagePikcerDelegate {
    
    public func wclImagePickerCancel(_ picker: WCLImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        imageBlock = nil
    }
    
    public func wclImagePickerComplete(_ picker: WCLImagePickerController, imageArr: [UIImage]) {
        picker.dismiss(animated: true, completion: nil)
        imageBlock?(imageArr)
        imageBlock = nil
    }
    
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
