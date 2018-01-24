#
#  Be sure to run `pod spec lint WCLImagePickerController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name          = "MGPhotoLib"
  s.version       = "4.0.2"
  s.summary       = "由swift实现可自定义的图片选择器。"

  s.homepage      = "https://github.com/spf-iOS/WCLImagePickerController"
  s.license       = 'MIT'
  s.author        = { "W_C__L" => "wangchonglei93@icloud.com" }
  s.platform      = :ios, "8.0"
  s.source        = { :git => "https://github.com/spf-iOS/WCLImagePickerController.git", :tag => s.version.to_s }
  s.source_files  = 'WCLImagePickerController/**/*.{swift,xib}'
  # s.public_header_files = 'WCLImagePickerController/ViewControllers/MGPhotoTool.swift'
  s.resources     = 'WCLImagePickerController/WCLImagePickerController/WCLImagePickerController.bundle'
  s.frameworks    = "UIKit", "Photos"
  s.requires_arc  = true

end
