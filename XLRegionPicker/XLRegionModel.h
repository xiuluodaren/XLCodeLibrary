//
//  XLRegionModel.h
//  paopaoche
//
//  Created by 十度 on 2017/11/2.
//  Copyright © 2017年 十度. All rights reserved.
//  地区模型

#import <Foundation/Foundation.h>

@interface XLRegionModel : NSObject <NSCopying>

/** 地区id */
@property (nonatomic,strong) NSString *id;

/** 父级id */
@property (nonatomic,strong) NSString *fid;

/** 地区名 */
@property (nonatomic,strong) NSString *title;

/** 排序 */
@property (nonatomic,strong) NSString *px;

@end
