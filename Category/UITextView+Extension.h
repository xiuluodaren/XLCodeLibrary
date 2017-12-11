//
//  UITextView+Extension.h
//  修罗微博
//
//  Created by xiuluo on 15/11/21.
//  Copyright © 2015年 chengde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
- (void)insertAttributeText:(NSAttributedString *)text settingBlock:(void(^)(NSMutableAttributedString *attributedText))settingBlock;
@end
