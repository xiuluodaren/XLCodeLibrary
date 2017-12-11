//
//  XLRegionPicker.m
//  paopaoche
//
//  Created by 十度 on 2017/11/2.
//  Copyright © 2017年 十度. All rights reserved.
//

#import "XLRegionPicker.h"

@interface XLRegionPicker () <UIPickerViewDelegate,UIPickerViewDataSource>

/** 底部视图 */
@property (nonatomic,strong) UIView *bottomView;

/** 省数组 */
@property (nonatomic,strong) NSArray *shengArray;

/** 市数组 */
@property (nonatomic,strong) NSArray *shiArray;

/** 县数组 */
@property (nonatomic,strong) NSArray *xianArray;

/** pickerView */
@property (nonatomic,strong) UIPickerView *pickerView;

@end

@implementation XLRegionPicker

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self layoutView];
    }
    return self;
}

#pragma mark - 布局
- (void)layoutView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    self.frame = window.bounds;
    self.y = window.height;
    self.hidden = YES;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [window addSubview:self];
    
    //底部视图
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 200)];
    _bottomView.y = self.height - 200;
    _bottomView.backgroundColor = XLColor(100, 100, 100);
    [self addSubview:_bottomView];
    
    //完成按钮
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setFrame:CGRectMake(_bottomView.width - 60, 0, 60, 50)];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:doneBtn];
    
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(20, 0, 60, 50)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:cancelBtn];
    
    //pickerView
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(cancelBtn.frame), _bottomView.width, 0)];
    _pickerView.height = _bottomView.height - _pickerView.y;
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [_bottomView addSubview:_pickerView];
    
    //获取省
    [self getRegionSheng];
}

- (void)cancel
{
    [UIView animateWithDuration:1.0 animations:^{
        self.y = self.window.height;
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)done
{
    [self cancel];
    
    XLRegionModel *sheng = _shengArray[[_pickerView selectedRowInComponent:0]];
    XLRegionModel *shi = _shiArray[[_pickerView selectedRowInComponent:1]];
    XLRegionModel *xian = _xianArray[[_pickerView selectedRowInComponent:2]];
    
    if (_block) _block(sheng,shi,xian);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    if (!CGRectContainsPoint(_bottomView.frame, point)) {
        [self cancel];
    }
    
}

- (void)show
{
    self.hidden = NO;
    [UIView animateWithDuration:1.0 animations:^{
        self.y = 0;
    }];
}

#pragma mark - UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return _shengArray.count ? _shengArray.count : 0;
    }else if (component == 1){
        return _shiArray.count ? _shiArray.count : 0;
    }else{
        return _xianArray.count ? _xianArray.count : 0;
    }
    
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            return ((XLRegionModel *)_shengArray[row]).title;
            break;
        }
        case 1:
        {
            return ((XLRegionModel *)_shiArray[row]).title;
            break;
        }
        case 2:
        {
            return ((XLRegionModel *)_xianArray[row]).title;
            break;
        }
        default:
            break;
    }
    
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            NSString *fid = ((XLRegionModel *)_shengArray[row]).id;
            [self getRegionShi:fid];
            break;
        }
        case 1:
        {
            NSString *fid = ((XLRegionModel *)_shiArray[row]).id;
            [self getRegionXian:fid];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 获取省市县三级联动
- (void)getRegionSheng
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/shengs.html",SERVICE_DOMAIN];
    
    [XLHttpTool post:requestURL params:nil success:^(id json) {
        
        if ([json[@"code"] isEqualToString:@"000"]) {
            NSDictionary *dict = json[@"data"];
            if (dict != nil)
            {
                _shengArray = [XLRegionModel mj_objectArrayWithKeyValuesArray:dict];
                XLRegionModel *regionModel = [_shengArray[0] copy];
                regionModel.title = @"不限";
                
                [_shengArray performSelector:@selector(insertObject:atIndex:) withObject:regionModel withObject:0];
                [_pickerView reloadComponent:0];
                [self pickerView:_pickerView didSelectRow:0 inComponent:0];
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)getRegionShi:(NSString *)fid
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/shis.html",SERVICE_DOMAIN];
    
    [XLHttpTool post:requestURL params:@{@"fid" : fid} success:^(id json) {
        
        if ([json[@"code"] isEqualToString:@"000"]) {
            NSDictionary *dict = json[@"data"];
            if (dict != nil)
            {
                _shiArray = [XLRegionModel mj_objectArrayWithKeyValuesArray:dict];
                XLRegionModel *regionModel = [_shiArray[0] copy];
                regionModel.title = @"全部";
                
                [_shiArray performSelector:@selector(insertObject:atIndex:) withObject:regionModel withObject:0];
                
                [_pickerView reloadComponent:1];
                [_pickerView selectRow:0 inComponent:1 animated:NO];
                [self pickerView:_pickerView didSelectRow:0 inComponent:1];
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)getRegionXian:(NSString *)fid
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/xians.html",SERVICE_DOMAIN];
    
    [XLHttpTool post:requestURL params:@{@"fid" : fid} success:^(id json) {
        
        if ([json[@"code"] isEqualToString:@"000"]) {
            NSDictionary *dict = json[@"data"];
            if (dict != nil)
            {
                _xianArray = [XLRegionModel mj_objectArrayWithKeyValuesArray:dict];
                
                XLRegionModel *regionModel = [_xianArray[0] copy];
                regionModel.title = @"全部";
                [_xianArray performSelector:@selector(insertObject:atIndex:) withObject:regionModel withObject:0];
                
                [_pickerView reloadComponent:2];
                [_pickerView selectRow:0 inComponent:2 animated:NO];
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
