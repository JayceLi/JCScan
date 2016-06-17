//
//  JCReader.m
//  JCScan
//
//  Created by Jayce on 16/5/14.
//  Copyright © 2016年 Jayce. All rights reserved.
//

#import "JCReader.h"

@implementation JCReader

-(id)init{
    if (self == [super init]){
        [self loadBeepSound];
        return self;
    }
    else{
        return nil;
    }
}

-(void)playSound{
    //[self.audioPlayer play];
    
}

-(void)loadBeepSound{
   
    
//    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
//    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
//    NSError *error;
//    
//    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
//    if (error) {
//        NSLog(@"Could not play beep file.");
//        NSLog(@"%@", [error localizedDescription]);
//    }
//    else{
//        [_audioPlayer prepareToPlay];
//       
//
//    }
}




- (void)startRead:(UIView*)preview onCompletion:(void (^)(NSString*))complete {
    NSError *error;
    
    self.completionBlock = complete;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        _captureSession = [[AVCaptureSession alloc] init];
        [_captureSession addInput:input];
        
        AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
        [_captureSession addOutput:captureMetadataOutput];
        
        dispatch_queue_t dispatchQueue;
        dispatchQueue = dispatch_queue_create("myQueue", NULL);
        [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
        [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
        
        _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
        [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        [_videoPreviewLayer setFrame:preview.layer.bounds];
        [preview.layer addSublayer:_videoPreviewLayer];
        
        
        [_captureSession startRunning];
    }
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self playSound];
                
                self.completionBlock([metadataObj stringValue]);
                
                [_captureSession stopRunning];
                //    [_videoPreviewLayer removeFromSuperlayer];
                _captureSession = nil;
                
            });
        }
    }
}


@end
