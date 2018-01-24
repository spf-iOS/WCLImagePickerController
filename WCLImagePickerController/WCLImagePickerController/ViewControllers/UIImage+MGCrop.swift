//
//  MGImage.swift
//  WCLImagePickerController
//
//  Created by song on 2018/1/24.
//  Copyright © 2018年 王崇磊. All rights reserved.
//

import UIKit
import CoreImage

public enum MGImageCropMode : Int {
    //自动缩放比例
    case autoScale
    //从中间按照大小裁剪
    case center
}

extension UIImage {
    
    /// 图片裁剪
    ///
    /// - Parameters:
    ///   - toSize: 裁剪大小
    ///   - cropModel: 裁剪方式
    /// - Returns: UIImage
    public func cropImage(withSize toSize: CGSize, withCropMode cropModel: MGImageCropMode = .autoScale) -> UIImage? {
        guard  toSize.width > 0 else { return nil }
        guard  toSize.height > 0 else { return nil }
        var fitSize = toSize
        var scale: CGFloat = 1
        if cropModel == .autoScale {
            let scaleX = size.width/toSize.width
            let scaleY = size.height/toSize.height
            scale = scaleX < scaleY ? scaleX : scaleY
            fitSize = CGSize(width: scale*toSize.width, height: scale*toSize.height)
        }
        let fitRect = CGRect(origin: CGPoint(x: (size.width - fitSize.width)/2, y: (size.height - fitSize.height)/2), size: fitSize)
        if let fitImage = self.cgImage?.cropping(to: fitRect) {
            let cropImage = UIImage(cgImage: fitImage, scale: scale, orientation: self.imageOrientation)
            return cropImage
        }
        return nil
    }
}
