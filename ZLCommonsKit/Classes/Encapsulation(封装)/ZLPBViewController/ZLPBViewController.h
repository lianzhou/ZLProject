//
//  ZLPBViewController.h
//  MyAPP
//
//  Created by 周连 on 16/8/20.
//  Copyright © 2016年 周连. All rights reserved.
//
//ZLPBViewController *imageBrowser = [[ZLPBViewController alloc] initWithFrame:SCREEN_BOUNDS];
//imageBrowser.currentSelectedIamge =index ;
//imageBrowser.bigImageArray = weakSelf.signimgArr;
//[imageBrowser showImages];

#import <UIKit/UIKit.h>

@interface ZLPBViewController : UIView<UIScrollViewDelegate>

//@property (nonatomic, copy) NSArray *imageViewArray;

@property (nonatomic, assign) NSInteger currentSelectedIamge;

@property (nonatomic, strong) UIScrollView *backgroundScrollView;

@property (nonatomic, strong) UILabel *pageIndexLabel;

@property (nonatomic,strong) NSMutableArray *originRects;

@property (nonatomic, copy) NSArray *bigImageArray;

- (instancetype)initWithFrame : (CGRect)rect;

- (void)showImages;






@end
