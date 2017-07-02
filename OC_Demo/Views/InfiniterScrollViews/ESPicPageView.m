//
//  ESPicPageView.m
//  SLL_InfiniteScrollView
//
//  Created by work on 2017/6/28.
//  Copyright © 2017年 work. All rights reserved.
//
#define timeInterval 3.2

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)
#import "ESPicPageView.h"
//#import "UIImageView+WebCache.h"

@interface ESPicPageView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, assign) CGFloat imgW;
@property (nonatomic, assign) CGFloat imgH;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *imageViews;
@property (nonatomic, assign) NSInteger imageCount;

@end

@implementation ESPicPageView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blueColor];
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        self.scrollView = scrollView;
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:scrollView];
        self.imgW = frame.size.width;
        self.imgH = frame.size.height;
        [self setNeedsLayout];
        
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(frame.size.width - 50, frame.size.height - 10, 0, 0)];
        self.pageControl = pageControl;
        self.pageControl.numberOfPages = 1;
        [self addSubview:pageControl];
        
        [self setuPTime];
        
    }
    
    return self;
    
}
#pragma mark -- 滚动到下一页面
- (void)nextImage{
    NSInteger page = self.pageControl.currentPage;
    page = self.pageControl.currentPage + 1;
    CGPoint offset = CGPointMake((1 + page) * self.imgW, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)setupImageViews{
    
    for (int i = 0; i < self.images.count + 2; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        CGFloat imageX = i * self.imgW;
        CGFloat imageY = 0;
        CGFloat imageW = self.imgW;
        CGFloat imageH = self.imgH;
        imageView.frame = CGRectMake(imageX, imageY, imageW,imageH);
        [self.scrollView insertSubview:imageView atIndex:0];
    }
    
}


- (NSArray *)imageViews{
    
    if (_imageViews == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < self.images.count + 2; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            CGFloat imageX = i * self.imgW;
            CGFloat imageY = 0;
            CGFloat imageW = self.imgW;
            CGFloat imageH = self.imgH;
            imageView.frame = CGRectMake(imageX, imageY, imageW,imageH);
            [self.scrollView insertSubview:imageView atIndex:0];
            [arr addObject:imageView];
        }
        _imageViews = arr;
    }
    
    return _imageViews;
    
}
- (void)setImages:(NSArray *)images{
    
    _images = images;
    self.imageCount = images.count;
    self.pageControl.numberOfPages = self.imageCount;
    [self addPics];
    
}

- (void)addPics{
    
    for (int i = 0; i < self.images.count + 2; i++) {
        UIImageView *imageView = self.imageViews[i];
        if (i == 0) {
            imageView.image =[UIImage imageNamed:[self.images lastObject]] ;
        }else if(i == self.images.count + 1){
            imageView.image =[UIImage imageNamed: [self.images firstObject]];
        }else{
            imageView.image = [UIImage imageNamed:self.images[i - 1]];
        }
    }
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake((self.imageCount + 2) * self.imgW, 0);
    [self.scrollView setContentOffset:CGPointMake(self.imgW, 0) animated:NO];
    
}

#pragma mark -- Timer
- (void)setuPTime{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop ] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)reSetTimer{
    [self.timer invalidate];
    self.timer = nil;
    
}
#pragma mark --ScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self reSetTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setuPTime];
}


//实时监听滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   //避免手指滑动过快出现漏白
    if (scrollView.contentOffset.x >= self.imgW * (self.imageCount + 1)) {
        [self.scrollView setContentOffset:CGPointMake(self.imgW, 0) animated:NO];
    }else if(scrollView.contentOffset.x <= 0){
        [self.scrollView setContentOffset:CGPointMake(self.imgW * (self.imageCount), 0) animated:NO];
    }
    
    self.pageControl.currentPage = (self.scrollView.contentOffset.x + self.imgW * 0.5f) / self.imgW - 1;
}




@end
