//
//  XLRegionPicker.h
//  paopaoche
//
//  Created by 十度 on 2017/11/2.
//  Copyright © 2017年 十度. All rights reserved.
//  省市县三级联动

#import <UIKit/UIKit.h>
#import "XLRegionModel.h"

@interface XLRegionPicker : UIView

/** 显示 */
- (void)show;

/** 回调 */
@property (nonatomic,strong) void(^block)(XLRegionModel *sheng,XLRegionModel *shi,XLRegionModel *xian);

@end
