//
//  XLCollectionView.m
//  图片轮播器
//
//  Created by xiuluodaren on 16/4/3.
//  Copyright © 2016年 xiuluodaren. All rights reserved.
//

#import "PictureCollectionView.h"

@interface PictureCollectionView () <UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSInteger index;    //图片索引
    NSTimer *timer; //定时器
    BOOL isTimer;  //是否定时器滑动，NO为手动滑动
}

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation PictureCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCollectionView];
        [self setupPageControl];
    }
    return self;
}

- (void)setAdsArray:(NSArray *)adsArray
{
    _adsArray = adsArray;
    self.height = 120;
    self.pageControl.y = self.bounds.size.height - 20;
    self.pageControl.numberOfPages = _adsArray.count;
    [self.collectionView reloadData];
    
    
    //设置初始显示的是第二个cell
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];    
    timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timer) userInfo:nil repeats:YES];
}

-(void)setDuration:(CGFloat)duration
{
    _duration = duration;
    
    [timer invalidate];
    timer = nil;
    timer = [NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(timer) userInfo:nil repeats:YES];
}

#pragma mark - 初始化collectionView
- (void)setupCollectionView
{
    UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
    collectionLayout.itemSize = self.bounds.size;
    collectionLayout.minimumLineSpacing = 0;
    collectionLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:collectionLayout];
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[PictureCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:self.collectionView];
    
    self.height = 0;
}

- (void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((self.bounds.size.width - 100) / 2, self.bounds.size.height - 20, 100, 20)];
    pageControl.enabled = NO;
    [pageControl addTarget:self action:@selector(changePageNum:) forControlEvents:UIControlEventTouchUpInside];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    
    self.pageControl = pageControl;
    [self addSubview:pageControl];
}

- (void)changePageNum:(UIPageControl *)pageControl
{
    index = pageControl.currentPage;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.adsArray.count != 0)
        return 3;
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    PictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    
    NSInteger next = indexPath.item;
    NSInteger count = self.adsArray.count;
    index = index % count;
    //防止图片闪屏
    NSInteger pageNum = (index + count + next - 1) % count;
    
    NSDictionary *dict = self.adsArray[pageNum];
    
    [cell.imageView setImageWithURL:[NSURL URLWithString:dict[@"path"]] placeholderImage:[UIImage imageNamed:@"no_image"]];
    
    self.pageControl.currentPage = pageNum;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
//手动滑才执行
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger offset = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (offset == 2)
    {
        index++;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        });
    }
    if (offset == 0)
    {
        index--;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        });
    }
}

//滑动开始时停止计时器
//手动滑才执行
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [timer invalidate];
    timer = nil;
    isTimer = NO;
}

//滑动结束时开始计时器
//手动滑才执行
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    timer = [NSTimer scheduledTimerWithTimeInterval:_duration != 0 ? _duration : 3.0 target:self selector:@selector(timer) userInfo:nil repeats:YES];
}

//滑动就执行
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger offset = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (offset == 2 && isTimer)
    {
        index++;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        });
    }
}


//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = self.adsArray.count;
    NSInteger pageNum = (index + count) % count;
    
    NSDictionary *adsDict = self.adsArray[pageNum];
    
    if ([self.delegate respondsToSelector:@selector(didClick:)])
    {
        [self.delegate didClick:adsDict];
    }
}

#pragma mark - private
//定时器
- (void)timer
{
    //是否定时器滑动
    isTimer = YES;
    [self.collectionView reloadData];
    
//    [UIView animateWithDuration:1.0 animations:^{
        [self.collectionView setContentOffset:CGPointMake(self.frame.size.width * 2, 0) animated:YES];
//    }];
}

@end
