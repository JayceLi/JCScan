//
//  JCScanQRCodeCameraV.m
//  JCScan
//
//  Created by Jayce on 16/5/16.
//  Copyright © 2016年 Jayce. All rights reserved.
//

#import "JCScanQRCodeCameraV.h"

#define JCScreenWidth          (CGRectGetWidth([[UIScreen mainScreen] bounds]))
#define JCScreenHeight         (CGRectGetHeight([[UIScreen mainScreen] bounds]))

#define JCStatusBarHeight      (20.0f)
#define JCNavigationBarHeight  (44.0f)
#define JCGetMethodReturnObjc(objc) if (objc) return objc

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

@interface JCScanQRCodeCameraV (){}

@property (nonatomic, strong) UILabel          *tipsLabel;
@property (nonatomic, strong) UIImageView      *lineImageView;
@property (nonatomic, strong) UIImageView      *scanQRCodePickBackgroundImageView;
@property (nonatomic, strong) CABasicAnimation *lineImageViewAnimation;


@end

@implementation JCScanQRCodeCameraV

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, JCNavigationBarHeight + JCStatusBarHeight, JCScreenWidth, JCScreenHeight - JCStatusBarHeight - JCNavigationBarHeight);
        
        [self addSubview:self.scanQRCodePickBackgroundImageView];
        [self addSubview:self.tipsLabel];
        [self addSubview:self.lineImageView];
        
        [self startAnimation];
    }
    
    return self;
}

#pragma mark - Set ScanQRCode Pick Background Image View
- (UIImageView *)scanQRCodePickBackgroundImageView {
    
    JCGetMethodReturnObjc(_scanQRCodePickBackgroundImageView);
    
    _scanQRCodePickBackgroundImageView       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_pick_bg"]];
    
    if (IS_IPAD) {
        CGFloat widit= JCScreenWidth - 80*2-40;
        
         _scanQRCodePickBackgroundImageView.frame = CGRectMake((JCScreenWidth-widit)/2, self.center.y/4, widit, widit);
    }else{
        _scanQRCodePickBackgroundImageView.frame = CGRectMake(self.center.x / 4, self.center.y / 3.5, JCScreenWidth - 80, JCScreenWidth - 80);
    }
   
    
    return _scanQRCodePickBackgroundImageView;
}

#pragma mark - Set ScanQRCode Tips Label Text
- (UILabel *)tipsLabel {
    
    JCGetMethodReturnObjc(_tipsLabel);
    
    _tipsLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, self.center.y / 3.5 + self.scanQRCodePickBackgroundImageView.frame.size.height + 30, JCScreenWidth, 30)];
    _tipsLabel.text          = @"二维码  条形码";
    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    _tipsLabel.textColor     = [UIColor whiteColor];
    _tipsLabel.font          = [UIFont systemFontOfSize:14];
    
    return _tipsLabel;
}

#pragma mark - Set ScanQRCode Line Image View
- (UIImageView *)lineImageView {
    
    JCGetMethodReturnObjc(_lineImageView);
    
    _lineImageView       = [[UIImageView alloc] initWithFrame:CGRectMake(50, self.center.y / 3.5, JCScreenWidth - 100, 4)];
    
    _lineImageView.image = [UIImage imageNamed:@"scan_line-del"];
    
    [self.scanQRCodePickBackgroundImageView addSubview:_lineImageView];
    
    return _lineImageView;
}

#pragma mark - Set Tips Label Text
- (void)setTipsLabelText:(NSString *)tipsLabelText {
    
    self.tipsLabel.text = tipsLabelText;
}

#pragma mark - Set ScanQRCode Line Image
- (void)setScanQRCodeLineImage:(UIImage *)scanQRCodeLineImage {
    
    self.lineImageView.image = scanQRCodeLineImage;
}

#pragma mark - Set ScanQRCode ScanQRCode Pick Background Image
- (void)setScanQRCodePickBackgroundImage:(UIImage *)scanQRCodePickBackgroundImage {
    
    self.scanQRCodePickBackgroundImageView.image = scanQRCodePickBackgroundImage;
}

#pragma mark - Set ScanQRCode Line Animation
- (void)startAnimation {
    
    CABasicAnimation *lineImageViewAnimation = [CABasicAnimation animation];
    
    lineImageViewAnimation.keyPath             = @"position";
    lineImageViewAnimation.duration            = 1.5;
    lineImageViewAnimation.fillMode            = kCAMediaTimingFunctionEaseInEaseOut;
    lineImageViewAnimation.removedOnCompletion = NO;
    lineImageViewAnimation.delegate            = self;
    lineImageViewAnimation.repeatCount         = MAXFLOAT;
    lineImageViewAnimation.toValue             = [NSValue valueWithCGPoint:CGPointMake(_lineImageView.center.x,
                                                                                       _scanQRCodePickBackgroundImageView.frame.origin.y + _scanQRCodePickBackgroundImageView.frame.size.height - 2)];
    
    [self.lineImageView.layer addAnimation:lineImageViewAnimation forKey:@"LineImageViewAnimation"];
}

#pragma mark - Stop Line Animtaion
- (void)stopAnimation {
    
    [self.lineImageView.layer removeAnimationForKey:@"LineImageViewAnimation"];
    self.lineImageView.hidden = true;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
