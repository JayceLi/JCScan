//
//  UIViewController+Push.h
//  网页加载
//
//  Created by yhj on 16/1/12.
//  Copyright © 2016年 QQ:1787354782. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Push)

-(void)push:(UIViewController *)viewController;

-(void)push:(UIViewController *)viewController animated:(BOOL)animated;

@end
