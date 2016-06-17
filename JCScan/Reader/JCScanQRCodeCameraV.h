//
//  JCScanQRCodeCameraV.h
//  JCScan
//
//  Created by Jayce on 16/5/16.
//  Copyright © 2016年 Jayce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCScanQRCodeCameraV : UIView


@property (nonatomic, strong) UIImage *scanQRCodePickBackgroundImage;
@property (nonatomic, strong) UIImage *scanQRCodeLineImage;

@property (nonatomic, copy) NSString *tipsLabelText;

- (void)stopAnimation;

- (void)startAnimation;

@end
