//
//  UIViewController+Push.m
//  网页加载
//
//  Created by yhj on 16/1/12.
//  Copyright © 2016年 QQ:1787354782. All rights reserved.
//

#import "UIViewController+Push.h"

@implementation UIViewController (Push)

-(void)push:(UIViewController *)viewController
{
    [self push:viewController animated:YES];
}

-(void)push:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav=(UINavigationController *)self;
        [nav pushViewController:viewController animated:YES];
    }
    else
    {
        // 避免多次点击进入
        if ([self.navigationController.viewControllers lastObject]==self||self.navigationController.viewControllers.lastObject==self.parentViewController) {
            [self.navigationController pushViewController:viewController animated:animated];
        }
    }
}

@end
