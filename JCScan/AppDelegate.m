//
//  AppDelegate.m
//  JCScan
//
//  Created by Jayce on 16/5/14.
//  Copyright © 2016年 Jayce. All rights reserved.
//

#import "AppDelegate.h"
#import "JCScanQRCodeVC.h"

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

     [[NSUserDefaults standardUserDefaults] setObject:@"null" forKey:@"isPresented"];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[[JCScanQRCodeVC alloc] init]];
    self.window.rootViewController = navController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    /// 测试代码 - ->我创建了一个DEV分支
    
    /// 测试代码 - ->我在这里创建了一行测试代码


    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    NSLog(@"AAAAAAAAAAAAAAAAAA");
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isPresented"] isEqualToString:@"isPresented"])
        return UIInterfaceOrientationMaskAll;
    else return UIInterfaceOrientationMaskPortrait;
}
//
//if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
//    
//    if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)])
//    {
//        if(IS_IPHONE_4_AND_OLDER){
//            
//            printf("Device Type : iPhone 4,4s ");
//            return UIInterfaceOrientationMaskPortrait;
//        }
//        else if(IS_IPHONE_5){
//            
//            printf("Device Type : iPhone 5,5S/iPod 5 ");
//            return UIInterfaceOrientationMaskPortrait;
//        }
//        else if(IS_IPHONE_6){
//            
//            printf("Device Type : iPhone 6 ");
//            return UIInterfaceOrientationMaskPortrait;
//        }
//        else if(IS_IPHONE_6P){
//            
//            printf("Device Type : iPhone 6+ ");
//            return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortrait;
//        }
//    }
//    return UIInterfaceOrientationMaskPortrait;
//}
//else{
//    
//    printf("Device Type : iPad");
//    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortrait;
//}
//}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
