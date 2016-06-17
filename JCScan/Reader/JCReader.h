//
//  JCReader.h
//  JCScan
//
//  Created by Jayce on 16/5/14.
//  Copyright © 2016年 Jayce. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface JCReader : NSObject<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (nonatomic, strong) void(^completionBlock)(NSString*);

-(void)startRead:(UIView*)preview onCompletion:(void(^)(NSString*))complete;
-(void)playSound;

@end
