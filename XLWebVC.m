//
//  XLAgreementVC.m
//  paopaoche
//
//  Created by 十度 on 2017/9/21.
//  Copyright © 2017年 十度. All rights reserved.
//

#import "XLWebVC.h"

@interface XLWebVC ()

@end

@implementation XLWebVC

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self layoutNavi];
    
    [self layoutView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 导航栏
- (void)layoutNavi
{
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    self.navigationItem.hidesBackButton = YES;
    
    UIView *naviView = [[UIView alloc] initWithFrame:CGRectMake(-8, 0, UI_SCREEN_WIDTH + 16, 44)];
    
    UIImageView *theImageView = [[UIImageView alloc] init];
    theImageView.frame = CGRectMake(-8, -20, UI_SCREEN_WIDTH + 16, 64);
    theImageView.backgroundColor = defaultColor;
    [naviView addSubview:theImageView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:BACKBTNFRAME];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"a_return"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"a_return"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [naviView addSubview:backBtn];
    
    //titleLabel
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 7, 100, 30)];
    titleLabel.center = naviView.center;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = titleSelectedColor;
    titleLabel.text = self.title;
    NSLog(@"%@",self.title);
    [naviView addSubview:titleLabel];
    
    self.navigationItem.titleView = naviView;
    
}

- (void)layoutView
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

- (void)backBtnClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
