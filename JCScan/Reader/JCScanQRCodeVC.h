//
//  JCScanQRCodeVC.h
//  JCScan
//
//  Created by Jayce on 16/5/16.
//  Copyright © 2016年 Jayce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCScanQRCodeVC : UIViewController

@property (nonatomic, copy) void(^CALScanQRCodeGetMetadataObjectsBlock)(NSArray *metadataObjects);

@property (nonatomic, copy) void(^CALScanQRCodeGetMetadataStringValue)(NSString *metadataObject);

@end
