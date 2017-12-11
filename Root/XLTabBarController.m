//
//  XLTabBarController.m
//  修罗微博
//
//  Created by xiuluo on 15/10/31.
//  Copyright © 2015年 chengde. All rights reserved.
//

#import "XLTabBarController.h"
#import "XLNavigationController.h"

#import "XLHomeVC.h"
#import "XLMessageVC.h"
#import "XLDiscoverVC.h"
#import "XLYuemaVC.h"
#import "XLMyVC.h"

#import "XLDongTaiVC.h"

@interface XLTabBarController ()

@end

@implementation XLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XLHomeVC *homeVC = [[XLHomeVC alloc]init];
    [self addChildVc:homeVC title:@"遇见" image:@"fd_icn1" selectedImage:@"fd_icn1_on"];
    
    XLMessageVC *messageVC = [[XLMessageVC alloc]init];
    [self addChildVc:messageVC title:@"消息" image:@"fd_icn2" selectedImage:@"fd_icn2_on"];
    
    XLDiscoverVC *discoverVC = [[XLDiscoverVC alloc]init];
    [self addChildVc:discoverVC title:@"发现" image:@"fd_icn3" selectedImage:@"fd_icn3_on"];
    
    XLYuemaVC *yuemaVC = [[XLYuemaVC alloc]init];
    [self addChildVc:yuemaVC title:@"约么" image:@"fd_icn4" selectedImage:@"fd_icn4_on"];
    
    XLMyVC *myVC = [[XLMyVC alloc]init];
    [self addChildVc:myVC title:@"我的" image:@"fd_icn5" selectedImage:@"fd_icn5_on"];
    
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = XLColor(123,123,123);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    XLNavigationController *nav = [[XLNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
