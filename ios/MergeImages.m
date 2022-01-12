//
//  MergeImages.m
//  SwiftBridgeImageOverlay
//
//  Created by Mac on 12/01/22.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <UIKit/UIKit.h>
#import <React/RCTBridge.h>

@interface RCT_EXTERN_MODULE(MergeImages, NSObject)
  RCT_EXTERN_METHOD(applyOverlay: (NSString) capturedImage
                    overlayImage: (NSString *)overlayImage
                    resolver: (RCTResponseSenderBlock)callback)
@end
