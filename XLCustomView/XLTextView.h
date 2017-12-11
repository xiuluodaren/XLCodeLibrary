//
//  XLTextView.h
//  修罗微博
//
//  Created by xiuluo on 15/11/16.
//  Copyright © 2015年 chengde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
