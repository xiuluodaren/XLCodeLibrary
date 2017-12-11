//
//  UIWindow+Extension.m
//  修罗微博
//
//  Created by xiuluo on 15/11/3.
//  Copyright © 2015年 chengde. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "XLTabBarController.h"
#import "XLAuthVC.h"
#import "AppDelegate.h"

@implementation UIWindow (Extension)

//+(void)switchRootViewController
-(void)switchRootViewController
{
    //调试用
//    self.rootViewController = [[XLOAuthVC alloc]init];
//    return;
    
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //无更新
    if ([lastVersion floatValue] <= [currentVersion floatValue])
    {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            
        //已登陆环信
        if (appDelegate.isLoginEM == YES) {
            self.rootViewController = [[XLTabBarController alloc]init];
        }else{
        //未登录环信
            self.rootViewController = [[XLAuthVC alloc]init];
        }
        
        [self makeKeyAndVisible];
    }else{
        //此处应为新版引导控制器
        NSLog(@"新版引导");
    }
}

@end
