//
//  XLBaseViewController.m
//  YaJunWei
//
//  Created by 十度 on 2017/11/14.
//  Copyright © 2017年 十度. All rights reserved.
//

#import "XLBaseViewController.h"

@interface XLBaseViewController ()

@end

@implementation XLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

//设置是否隐藏
- (BOOL)prefersStatusBarHidden {
    //    [super prefersStatusBarHidden];
    return NO;
}

//设置隐藏动画
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

/** 加载控制器
    如果有xib就加载xib
    没有就初始化
 */
- (UIViewController *)loadViewController:(NSString *)vcName
{
    Class class = NSClassFromString(vcName);
    
    UIViewController *vc;
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *path = [[NSBundle mainBundle] pathForResource:vcName ofType:@".nib"];
    
    if ([fileMgr fileExistsAtPath:path]) {
        vc = [[class alloc]initWithNibName:vcName bundle:[NSBundle mainBundle]];
    }else{
        vc = [[class alloc]init];
    }
    
    return vc;
}

@end
