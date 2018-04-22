//
//  MGPhotoTool.swift
//  WCLImagePickerController
//
//  Created by song on 2018/1/15.
//  Copyright © 2018年 王崇磊. All rights reserved.
//

import UIKit
import SPPhotoCropEditor

public let MGPhotoLib = MGPhotoTool.share

public class MGPhotoTool {
    public static var share: MGPhotoTool = MGPhotoTool()
    
    public typealias MGPhotoImageBlock = (_ images:[UIImage]) ->()
    
    private var imageBlock: MGPhotoImageBlock?
    
    private var radioImageBlock: ((_ images: UIImage) ->())?
    
    private var isRadio: Bool = false
    private var aspectRatio: CGFloat = 0
    
    public func showView(selectMaxNum num:Int,
                         inVC: UIViewController? = nil,
                         completionBlock: @escaping MGPhotoImageBlock) {
        var vc: UIViewController? = inVC
        if vc == nil {
            vc = UIApplication.shared.keyWindow?.rootViewController
        }
        guard vc != nil else { return }
        WCLImagePickerOptions.maxPhotoSelectNum = num
        WCLImagePickerOptions.isRadio = false
        isRadio = WCLImagePickerOptions.isRadio
        imageBlock = completionBlock
        WCLImagePickerController.present(inVC: vc, delegate: self)
    }
    
    /// 选择图片单选
    ///
    /// - Parameters:
    ///   - aspectRatio: 图片要求长宽比例
    ///   - inVC: vc
    ///   - completionBlock: 回调
    public func showView(cropRatio aspect: CGFloat = 0,
                         inVC: UIViewController? = nil,
                         completionBlock: @escaping (_ images: UIImage) ->()) {
        var vc: UIViewController? = inVC
        if vc == nil {
            vc = UIApplication.shared.keyWindow?.rootViewController
        }
        guard vc != nil else { return }
        WCLImagePickerOptions.maxPhotoSelectNum = 1
        WCLImagePickerOptions.isRadio = true
        isRadio = WCLImagePickerOptions.isRadio
        aspectRatio = aspect
        radioImageBlock = completionBlock
        WCLImagePickerController.present(inVC: vc, delegate: self)
    }
    
    public func restore() {
        imageBlock = nil
        radioImageBlock = nil
        aspectRatio = 0
        WCLImagePickerOptions.isRadio = false
        isRadio = WCLImagePickerOptions.isRadio
    }
}

extension MGPhotoTool: WCLImagePikcerDelegate {
    
    public func wclImagePickerCancel(_ picker: WCLImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        restore()
    }
    
    public func wclImagePickerComplete(_ picker: WCLImagePickerController, imageArr: [UIImage]) {
        picker.dismiss(animated: true, completion: nil)
        imageBlock?(imageArr)
        restore()
    }
    public func wclRadioImageBlockImagePickerComplete(_ picker: WCLImagePickerController, image: UIImage) {
        let cropVC = CropViewController()
        cropVC.image = image
        cropVC.rotationEnabled = true
        cropVC.toolbarHidden = true
        cropVC.delegate = self
        cropVC.view.alpha = 1.0
        cropVC.view.clipsToBounds = true
        cropVC.title = "编辑"
        cropVC.navigationItem.leftBarButtonItem?.tintColor = WCLImagePickerOptions.navigationTintColor
        cropVC.navigationItem.rightBarButtonItem?.tintColor = WCLImagePickerOptions.pickerSelectColor
        picker.navigationController?.pushViewController(cropVC, animated: true)
        if aspectRatio != 0 {
            DispatchQueue.main.asyncAfter(deadline:  DispatchTime.now() + 0.05) {
                if let cropView = cropVC.view.subviews.first(where: { (subView) -> Bool in
                    return subView.isKind(of: CropView.self)
                }) as? CropView {
                    let ratio: CGFloat = self.aspectRatio
                    var cropRect = cropView.cropRect
                    let width = cropRect.width
                    let height = cropRect.height
                    cropRect.size = CGSize(width: width, height: width * ratio)
                    cropRect.origin = CGPoint(x: 0, y: height/2 - cropRect.size.height/2 + cropRect.origin.y)
                    cropView.cropRect = cropRect
                }
            }
        }
    }
}

extension MGPhotoTool: CropViewControllerDelegate {
    
    public func cropViewController(_ controller: CropViewController, didFinishCroppingImage image: UIImage) {
        controller.dismiss(animated: true, completion: nil)
        radioImageBlock?(image)
        restore()
    }
    public func cropViewController(_ controller: CropViewController, didFinishCroppingImage image: UIImage, transform: CGAffineTransform, cropRect: CGRect) {
        controller.dismiss(animated: true, completion: nil)
        radioImageBlock?(image)
        restore()
    }
    public func cropViewControllerDidCancel(_ controller: CropViewController) {
        controller.navigationController?.popViewController(animated: true)
    }
}
