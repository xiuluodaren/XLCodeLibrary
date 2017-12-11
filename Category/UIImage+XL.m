//
//  UIImage+UIImage_XL.m
//  paopaoche
//
//  Created by 十度 on 2017/10/10.
//  Copyright © 2017年 十度. All rights reserved.
//

#import "UIImage+XL.h"

@implementation UIImage (XL)

//压缩图片质量和尺寸
- (NSData *)compressImageWithScale:(CGFloat)scale width:(CGFloat)width
{
    width = width == 0 ? UI_SCREEN_WIDTH : width;
    
    CGFloat length = UIImageJPEGRepresentation(self, 1.0).length;
    NSLog(@"原图大小: %f",length);
    
    NSLog(@"压缩前图片尺寸:宽 %f 高 %f",self.size.width,self.size.height);
    UIImage *image = [self compressImageWith:width];
    NSLog(@"压缩后图片尺寸:宽 %f 高 %f",image.size.width,image.size.height);
    
    NSData *data = UIImageJPEGRepresentation(image, scale);
    
    //大于5M
    if (data.length > 5000000) {
        data = [image compressImageWithScale:scale - 0.1 width:width];
    }
    
    return data;
    
}

- (NSData *)compressImageWithScale:(CGFloat)scale
{
    NSData *data = UIImageJPEGRepresentation(self, scale);
    
    //大于5M
    if (data.length > 5000000) {
        data = [self compressImageWithScale:scale - 0.1];
    }
    
    return data;
}

//压缩图片尺寸
- (UIImage *)compressImageWith:(CGFloat)width
{
    float imageWidth = self.size.width;
    float imageHeight = self.size.height;
    float height = self.size.height/(self.size.width/width);
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    if (widthScale > heightScale) {
        [self drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }else{
        [self drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

//根据颜色和尺寸生成纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//根据view生成图片
+ (UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
