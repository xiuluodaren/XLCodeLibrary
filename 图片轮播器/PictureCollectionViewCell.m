//
//  CollectionViewCell.m
//  图片轮播器
//
//  Created by xiuluodaren on 16/4/2.
//  Copyright © 2016年 xiuluodaren. All rights reserved.
//

#import "PictureCollectionViewCell.h"

@interface PictureCollectionViewCell ()

@end

@implementation PictureCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        
        [self addSubview:_imageView];
    }
    return self;
}

@end
