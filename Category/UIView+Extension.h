//
//  UIView+Extension.h
//  修罗微博
//
//  Created by xiuluo on 15/11/1.
//  Copyright © 2015年 chengde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

//UIView转UIImage
+ (UIImage*)convertViewToImage:(UIView*)view;

@end
