//
//  ZLPBViewController.m
//  MyAPP
//
//  Created by 周连 on 16/8/20.
//  Copyright © 2016年 周连. All rights reserved.
//

#import "ZLPBViewController.h"
#import "ZLPBImageView.h"
#import "SDImageCache.h"      //缓存相关
#import "SDWebImageCompat.h"  //组件相关
//#import "SDWebImageDecoder.h" //解码相关

//图片下载以及下载管理器
#import "SDWebImageDownloader.h"
#import "SDWebImageManager.h"
#import "SDWebImageDownloaderOperation.h"

#define UISCREEN_WIDTH [UIScreen mainScreen ].bounds.size.width

#define UISCREEN_HEIGHT [UIScreen mainScreen ].bounds.size.height

@implementation ZLPBViewController

//@synthesize imageViewArray;

@synthesize currentSelectedIamge;

@synthesize bigImageArray;


- (instancetype)initWithFrame : (CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self) {
        [self addSubview:self.pageIndexLabel];
        self.backgroundColor = [UIColor blackColor];
        [self initBackgroundScrollView];
    }
    return self;
}

- (UIScrollView *)backgroundScrollView
{
    if (!_backgroundScrollView) {
        _backgroundScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        _backgroundScrollView.pagingEnabled = YES;
    }
    return _backgroundScrollView;
}

- (NSMutableArray *)originRects
{
    if (!_originRects) {
        _originRects = [NSMutableArray array];
    }
    return _originRects;
}

- (UILabel *)pageIndexLabel{
    if (!_pageIndexLabel) {
        _pageIndexLabel = [[UILabel alloc]initWithFrame:CGRectMake((UISCREEN_WIDTH - 100) / 2, UISCREEN_HEIGHT - 50, 100, 25)];
        _pageIndexLabel.textAlignment = NSTextAlignmentCenter;
        _pageIndexLabel.textColor = [UIColor whiteColor];
        _pageIndexLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 20];
    }
    return _pageIndexLabel;
}

- (void)initBackgroundScrollView
{
    self.backgroundScrollView.contentSize = CGSizeMake([self.bigImageArray count] * UISCREEN_WIDTH, UISCREEN_HEIGHT);
    self.backgroundScrollView.delegate = self;
    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.backgroundScrollView];
}

- (void)initImageScrollViews {
    self.backgroundScrollView.contentSize = CGSizeMake([self.bigImageArray count] * UISCREEN_WIDTH, 0);
    self.backgroundScrollView.contentOffset = CGPointMake(currentSelectedIamge * UISCREEN_WIDTH, 0);
    for (int i = 0; i < [self.bigImageArray count]; i++) {
        //
        
        UIScrollView *iamgeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH * i, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        ZLPBImageView *weibImageView = [[ZLPBImageView alloc]init];
        
        id urlimg=[self.bigImageArray objectAtIndex:i];
      
        if([urlimg isKindOfClass:[NSString class]]){
            
            [weibImageView sd_setImageWithURL:[NSURL URLWithString: urlimg] placeholderImage:[UIImage imageNamed:kplaceholderImage]];
        }
        else  if([urlimg isKindOfClass:[UIImage class]]){
            weibImageView.image=urlimg;
        }
        
        
        //  weibImageView.image = image;
        CGFloat ratio = (double)weibImageView.image.size.height / (double)weibImageView.image.size.width;
        weibImageView.bounds = CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_WIDTH * ratio);
        weibImageView.center = CGPointMake(UISCREEN_WIDTH / 2, UISCREEN_HEIGHT / 2);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        [weibImageView addGestureRecognizer:tap];
        [iamgeScrollView addSubview:weibImageView];
        [self.backgroundScrollView addSubview:iamgeScrollView];
        
    }
    NSString *stringPage = [NSString stringWithFormat:@"%ld/%lu",currentSelectedIamge + 1, (unsigned long)[self.bigImageArray count]];
    self.pageIndexLabel.text = stringPage;
    [self bringSubviewToFront:self.pageIndexLabel];
}

- (void)showImages
{
    [self initImageScrollViews];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}


-(void)imageTap:(UITapGestureRecognizer *)tap{
    [self removeFromSuperview];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int nCurrentPage = scrollView.contentOffset.x / UISCREEN_WIDTH;
    currentSelectedIamge = nCurrentPage;
    NSString *stringPage = [NSString stringWithFormat:@"%d/%lu",nCurrentPage + 1, (unsigned long)[self.bigImageArray count]];
    self.pageIndexLabel.text = stringPage;
    [self bringSubviewToFront:self.pageIndexLabel];
}


@end
