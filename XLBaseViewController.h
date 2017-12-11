//
//  XLBaseViewController.h
//  YaJunWei
//
//  Created by 十度 on 2017/11/14.
//  Copyright © 2017年 十度. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLBaseViewController : UIViewController

/** 加载控制器
 如果有xib就加载xib
 没有就初始化
 */
- (UIViewController *)loadViewController:(NSString *)vcName;

@end
