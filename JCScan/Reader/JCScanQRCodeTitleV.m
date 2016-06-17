//
//  JCScanQRCodeTitleV.m
//  JCScan
//
//  Created by Jayce on 16/5/16.
//  Copyright © 2016年 Jayce. All rights reserved.
//

#import "JCScanQRCodeTitleV.h"


#define JCScreenWidth          (CGRectGetWidth([[UIScreen mainScreen] bounds]))
#define JCScreenHeight         (CGRectGetHeight([[UIScreen mainScreen] bounds]))

#define JCStatusBarHeight      (20.0f)
#define JCNavigationBarHeight  (44.0f)
#define JCGetMethodReturnObjc(objc) if (objc) return objc
#define kTopTitle @"Scan"
@interface JCScanQRCodeTitleV (){}

@property (nonatomic, strong) UILabel  *scanQRCodeTitleLabel;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation JCScanQRCodeTitleV

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, JCScreenWidth, JCStatusBarHeight + JCNavigationBarHeight);
        self.layer.zPosition = INT_MAX;
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.scanQRCodeTitleLabel];
       // [self addSubview:self.backButton];
    }
    
    return self;
}

#pragma mark - Set Title String
- (UILabel *)scanQRCodeTitleLabel {
    
    JCGetMethodReturnObjc(_scanQRCodeTitleLabel);
    
    _scanQRCodeTitleLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(self.backButton.frame.size.width, JCStatusBarHeight, JCScreenWidth - (self.backButton.frame.size.width * 2), JCNavigationBarHeight)];
    _scanQRCodeTitleLabel.text            = kTopTitle;
    _scanQRCodeTitleLabel.textAlignment   = NSTextAlignmentCenter;
    _scanQRCodeTitleLabel.font            = [UIFont systemFontOfSize:18];
    
    return _scanQRCodeTitleLabel;
}

#pragma mark - Set Back Button
- (UIButton *)backButton {
    
    JCGetMethodReturnObjc(_backButton);
    
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, JCStatusBarHeight, 40, JCNavigationBarHeight)];
    
    [_backButton setImage:[UIImage imageNamed:@"black_Button_Image"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return _backButton;
}

#pragma mark - Set Back Button Action
- (void)backButtonAction:(UIButton *)sender {
    
    self.JCScanQRCodeTitleViewBackButtonBlock(sender);
}

#pragma mark - Set Self BackgroundColor
- (void)setTitleViewBackgroundColor:(UIColor *)titleViewBackgroundColor {
    
    self.backgroundColor = titleViewBackgroundColor;
}

#pragma mark - Set Back Button Image
- (void)setBackButtonImage:(UIImage *)backButtonImage {
    
    [self.backButton setImage:backButtonImage forState:UIControlStateNormal];
}

#pragma mark - Set Scan QRCode Title Label Text Color
- (void)setScanQRCodeTitleColor:(UIColor *)scanQRCodeTitleColor {
    
    self.scanQRCodeTitleLabel.textColor = scanQRCodeTitleColor;
}

#pragma mark - Set Scan QRCode Title
- (void)setScanQRCodeTitle:(NSString *)scanQRCodeTitle {
    
    self.scanQRCodeTitleLabel.text = scanQRCodeTitle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
