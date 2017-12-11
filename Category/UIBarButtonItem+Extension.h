//
//  UIBarButtonItem+Extension.h
//  修罗微博
//
//  Created by xiuluo on 15/11/1.
//  Copyright © 2015年 chengde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

@end
