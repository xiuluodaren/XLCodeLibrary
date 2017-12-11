//
//  XLRegionModel.m
//  paopaoche
//
//  Created by 十度 on 2017/11/2.
//  Copyright © 2017年 十度. All rights reserved.
//

#import "XLRegionModel.h"

@implementation XLRegionModel

- (id)copyWithZone:(NSZone *)zone
{
    XLRegionModel *model = [[XLRegionModel alloc] init];
    model.id = self.id;
    model.title = self.title;
    model.fid = self.fid;
    model.px = self.px;
    return model;
}

@end
