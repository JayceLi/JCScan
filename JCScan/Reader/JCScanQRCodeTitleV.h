//
//  JCScanQRCodeTitleV.h
//  JCScan
//
//  Created by Jayce on 16/5/16.
//  Copyright © 2016年 Jayce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCScanQRCodeTitleV : UIView

@property (nonatomic, strong) NSString *scanQRCodeTitle;
@property (nonatomic, strong) UIColor  *scanQRCodeTitleColor;
@property (nonatomic, strong) UIColor  *titleViewBackgroundColor;
@property (nonatomic, strong) UIImage  *backButtonImage;

@property (nonatomic, copy) void(^JCScanQRCodeTitleViewBackButtonBlock)(UIButton *backButton);

@end
