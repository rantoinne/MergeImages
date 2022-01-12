//
//  OverlayImage.swift
//  SwiftBridgeImageOverlay
//
//  Created by Mac on 12/01/22.
//

import Foundation
import UIKit
import React

@objc(MergeImages)

class MergeImages: NSObject, RCTBridgeModule{
  static func moduleName() -> String! {
    return "MergeImages";
  }

  static func requiresMainQueueSetup() -> Bool {
    return true;
  }
  
  @objc public func applyOverlay(_ capturedImage: NSString, overlayImage: NSString, resolver callback: RCTResponseSenderBlock ) {
    let capturedImageData = Data(base64Encoded: capturedImage as String, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
    let overlayImageData = Data(base64Encoded: overlayImage as String, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
    let capturedImageView = UIImage(data: capturedImageData)
    let overlayImageDataView = UIImage(data: overlayImageData)
  
    let guestImage: UIImage! = capturedImageView
    let selectedOverlay: UIImage! = overlayImageDataView
    let bottomImage = guestImage
    let topImage = selectedOverlay
    let size : CGSize! = bottomImage?.size
    UIGraphicsBeginImageContext(size)
    let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    bottomImage?.draw(in: areaSize)
    topImage!.draw(in: areaSize, blendMode: .normal, alpha: 1)
    let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    let imageData = newImage.pngData()!
    return callback( [ imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters) as NSString ] )
  }
}
