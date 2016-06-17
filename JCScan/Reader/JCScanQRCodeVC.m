//
//  JCScanQRCodeVC.m
//  JCScan
//
//  Created by Jayce on 16/5/16.
//  Copyright © 2016年 Jayce. All rights reserved.
//

#import "JCScanQRCodeVC.h"
#import "JCScanQRCodeTitleV.h"
#import "JCScanQRCodeCameraV.h"
#import <AVFoundation/AVFoundation.h>
#import "Masonry.h"
#import "TOWebViewController.h"
#import "UIViewController+Push.h"
#import "AppDelegate.h"

#define JCScreenWidth          (CGRectGetWidth([[UIScreen mainScreen]  bounds]))
#define JCScreenHeight         (CGRectGetHeight([[UIScreen mainScreen] bounds]))

#define JCStatusBarHeight     (20.0f)
#define JCNavigationBarHeight (44.0f)
#define JCGetMethodReturnObjc(objc) if (objc) return objc
#define JCWeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self

#define kScanQRCodeUrl @"http://pay.magiccompass.co.nz/merchant/scanTransaction?barcode="

#define kTopTitle @"Scan"

#define kNotificationOrientationChange          @"kNotificationOrientationChange"

@interface JCScanQRCodeVC ()<AVCaptureMetadataOutputObjectsDelegate>
{
    BOOL isScanQRCode;
    UIButton *reoadBtn;
}


@property (nonatomic, strong) AVCaptureDevice            *captureDevice;
@property (nonatomic, strong) AVCaptureDeviceInput       *captureDeviceInput;
@property (nonatomic, strong) AVCaptureMetadataOutput    *captureMetadataOutPut;
@property (nonatomic, strong) AVCaptureSession           *capturesession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@property (nonatomic, strong) JCScanQRCodeTitleV  *scanQRCodeTitleView;
@property (nonatomic, strong) JCScanQRCodeCameraV *cameraView;
@property (nonatomic, strong)UILabel *topTitle;

@property (nonatomic) CGAffineTransform transform ;

@end

@implementation JCScanQRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    
#if TARGET_IPHONE_SIMULATOR
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"模拟器没有摄像头功能" message:@"请使用真机测试" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
    
    [alertView show];
    
#elif TARGET_OS_IPHONE
    
    [self authorityJudgment];
    
#endif

}

#pragma mark - is ScanQRCode
-(void)authorityJudgment{
    
    AVAuthorizationStatus cameraStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (cameraStatus == AVAuthorizationStatusDenied || cameraStatus == AVAuthorizationStatusRestricted) {
        UIAlertView *alter=[[UIAlertView alloc] initWithTitle:nil message:@"检测到您的手机未开启相机服务，暂不可扫描。您可在手机设置中开启服务。（设置-隐私-相机-开启-相集服务）" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
        
        [self roading];
        return;
    }else{
        
        [self initScanQRCode];
    }
}

#pragma mark - reload ScanQRCode
-(void)roading{
    
    reoadBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    reoadBtn.backgroundColor=[UIColor lightGrayColor];
    [reoadBtn setTitle:@"重新加载" forState:normal];
    reoadBtn.titleLabel.textColor=[UIColor blueColor];
    reoadBtn.titleLabel.font=[UIFont systemFontOfSize:15.0f];
    reoadBtn.layer.masksToBounds=YES;
    reoadBtn.layer.cornerRadius=2.0f;
    [reoadBtn addTarget:self action:@selector(authorityJudgment) forControlEvents:UIControlEventTouchUpInside];
    reoadBtn.center=self.view.center;
    [self.view addSubview:reoadBtn];
    
}

#pragma mark - Init ScanQRCode
- (void)initScanQRCode {
    
    //[self.view setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.cameraView];
  //  [self.view addSubview:self.scanQRCodeTitleView];
    [self addTopTitles];
    
//    
    _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    _captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:nil];
    
    _captureMetadataOutPut                = [[AVCaptureMetadataOutput alloc] init];
    _captureMetadataOutPut.rectOfInterest = CGRectMake(0, 0, JCScreenWidth, JCScreenHeight);
    
    [_captureMetadataOutPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    _capturesession = [[AVCaptureSession alloc] init];
    
    [_capturesession setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_capturesession canAddInput:self.captureDeviceInput]) {
        [_capturesession addInput:self.captureDeviceInput];
    }
    
    if ([_capturesession canAddOutput:self.captureMetadataOutPut]) {
        [_capturesession addOutput:self.captureMetadataOutPut];
    }
    
    _captureMetadataOutPut.metadataObjectTypes = @[AVMetadataObjectTypeUPCECode,
                                                   AVMetadataObjectTypeCode39Code,
                                                   AVMetadataObjectTypeCode39Mod43Code,
                                                   AVMetadataObjectTypeEAN13Code,
                                                   AVMetadataObjectTypeEAN8Code,
                                                   AVMetadataObjectTypeCode93Code,
                                                   AVMetadataObjectTypeCode128Code,
                                                   AVMetadataObjectTypePDF417Code,
                                                   AVMetadataObjectTypeQRCode,
                                                   AVMetadataObjectTypeAztecCode];
    //这是三个type有问题。 需要支持的可以加
    //AVMetadataObjectTypeInterleaved2of5Code,
    //AVMetadataObjectTypeITF14Code,
    //AVMetadataObjectTypeDataMatrixCode
    
    _captureVideoPreviewLayer              = [AVCaptureVideoPreviewLayer layerWithSession:_capturesession];
    _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _captureVideoPreviewLayer.frame        = CGRectMake(0, 0, JCScreenWidth, JCScreenHeight);

    
    [self.view.layer insertSublayer:_captureVideoPreviewLayer atIndex:0];
    
    [_capturesession startRunning];
   
}

-(void)addTopTitles{
   UILabel *navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
    navTitleLabel.text = kTopTitle;
   navTitleLabel.textAlignment = NSTextAlignmentCenter;
   navTitleLabel.font = [UIFont systemFontOfSize:16.0f];
    navTitleLabel.textColor = [UIColor blackColor];
    navTitleLabel.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = navTitleLabel;
}


-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{

}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    [_capturesession stopRunning];
    
    if ([metadataObjects count] > 0) {
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        
        NSString *stringValue = metadataObject.stringValue;
        
//        self.CALScanQRCodeGetMetadataObjectsBlock(metadataObjects);
//        self.CALScanQRCodeGetMetadataStringValue(stringValue);
        [self ScanQRCodeGetMetadataObjects:metadataObjects dataStr:stringValue];
        
    }
    
    [_captureMetadataOutPut setMetadataObjectsDelegate:nil queue:nil];
}

#pragma mark Scan QRCode GetMetadata
-(void)ScanQRCodeGetMetadataObjects:(NSArray *)array dataStr:(NSString *)dataStr{
   // NSLog(@"array-----%@",array);
   // NSLog(@"tittle----%@",dataStr);
    
    /**
     * 一般需要在这里做一个判断，一个标准
     * 去限制不正确的字段
     */
    

    [[NSUserDefaults standardUserDefaults] setObject:@"isPresented" forKey:@"isPresented"];
    NSString *strUrl=[NSString stringWithFormat:@"%@%@",kScanQRCodeUrl,dataStr];
  //  NSString *strUrl=[NSString stringWithFormat:@"https://www.baidu.com/"];

    AudioServicesPlaySystemSound(1057);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [_topTitle removeFromSuperview];
    TOWebViewController* vc = [[TOWebViewController alloc] initWithURLString:strUrl];

     [self.navigationController pushViewController:vc animated:YES];
//    vc.showPageTitles = NO;
//    //vc.title = @"关于";
//    [self push:vc animated:YES];
    
    isScanQRCode=true;
    
   // AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
   // appDelegate.restrictRotation = YES;
   // [self.cameraView stopAnimation];
    
   
}



#pragma mark - Set ScanQRCode Title View
- (JCScanQRCodeTitleV *)scanQRCodeTitleView {
    
    JCGetMethodReturnObjc(_scanQRCodeTitleView);
    
    _scanQRCodeTitleView = [[JCScanQRCodeTitleV alloc] init];
    
    JCWeakSelf(ws);
    
    [_scanQRCodeTitleView setJCScanQRCodeTitleViewBackButtonBlock:^(UIButton *sender) {
        
        [ws popViewController];
    }];
    
    return _scanQRCodeTitleView;
}

#pragma mark - Set ScanQRCode Camera View
- (JCScanQRCodeCameraV *)cameraView {
    
    JCGetMethodReturnObjc(_cameraView);
    
    _cameraView = [[JCScanQRCodeCameraV alloc] init];
    
    return _cameraView;
}

#pragma mark - Pop View Controller
- (void)popViewController {
   
    [self.navigationController popViewControllerAnimated:true];
}

-(void)viewWillAppear:(BOOL)animated{
    
   
    
    if (isScanQRCode) {
        [self scanQRCodeTitleView];
        
        [self.captureVideoPreviewLayer removeFromSuperlayer];
        self.captureVideoPreviewLayer=nil;
        self.capturesession=nil;
         [self initScanQRCode];
         [_capturesession startRunning];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate
{
    return NO;
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
