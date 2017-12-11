//
//  XLCollectionView.h
//  图片轮播器
//
//  Created by xiuluodaren on 16/4/3.
//  Copyright © 2016年 xiuluodaren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureCollectionViewCell.h"

@protocol pictureCollectionViewDelegate <NSObject>

@optional

//点击广告
- (void)didClick:(NSDictionary *)adsDict;

@end

@interface PictureCollectionView : UIView

//广告数组
@property (strong, nonatomic) NSArray *adsArray;

//页码
@property (strong, nonatomic) UIPageControl *pageControl;

//每页停留时间
@property (assign, nonatomic) CGFloat duration;

/** 代理 */
@property (nonatomic,strong) id delegate;
@end
