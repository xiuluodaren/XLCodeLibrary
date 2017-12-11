//
//  UIImage+UIImage_XL.h
//  paopaoche
//
//  Created by 十度 on 2017/10/10.
//  Copyright © 2017年 十度. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XL)

/** 压缩图片质量 */
- (NSData *)compressImageWithScale:(CGFloat)scale width:(CGFloat)width;

/** 压缩图片质量 */
- (NSData *)compressImageWithScale:(CGFloat)scale;

/** 压缩图片尺寸 */
- (UIImage *)compressImageWith:(CGFloat)width;

/** 生成纯色图片 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/** 根据view生成图片 */
+ (UIImage *)imageWithView:(UIView *)view;

@end
