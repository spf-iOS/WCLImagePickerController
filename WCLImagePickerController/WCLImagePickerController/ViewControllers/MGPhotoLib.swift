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
    
    public typealias MGPhotoWCLImageBlock = (_ images:[WCLImage]) ->()
    
    private var imageBlock: MGPhotoImageBlock?
    
    private var wclImageBlock: MGPhotoWCLImageBlock?
    
    public func showView(selectMaxNum num:Int,
                         inVC: UIViewController? = nil,
                         completionBlock: @escaping MGPhotoImageBlock) {
        var vc: UIViewController? = inVC
        if vc == nil {
            vc = UIApplication.shared.keyWindow?.rootViewController
        }
        guard vc != nil else { return }
        WCLImagePickerOptions.maxPhotoSelectNum = num
        imageBlock = completionBlock
        WCLImagePickerController.present(inVC: vc, delegate: self)
    }
    
    public func showWCLView(selectMaxNum num:Int,
                         inVC: UIViewController? = nil,
                         completion wclBlock: @escaping MGPhotoWCLImageBlock) {
        var vc: UIViewController? = inVC
        if vc == nil {
            vc = UIApplication.shared.keyWindow?.rootViewController
        }
        guard vc != nil else { return }
        WCLImagePickerOptions.maxPhotoSelectNum = num
        wclImageBlock = wclBlock
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
    
    public func wclImagePickerComplete(_ picker: WCLImagePickerController, wclImages: [WCLImage]) {
        picker.dismiss(animated: true, completion: nil)
        wclImageBlock?(wclImages)
        wclImageBlock = nil
    }
    
}
