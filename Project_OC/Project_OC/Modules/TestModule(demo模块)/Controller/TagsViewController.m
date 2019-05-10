//
//  TagsViewController.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/15.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "TagsViewController.h"
#import "IMJIETagView.h"
@interface TagsViewController ()<IMJIETagViewDelegate>

@property (nonatomic,copy)    NSArray * tagslist;
@property (nonatomic,copy)    NSArray * settagslist;

@end

@implementation TagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTagsView];
}
#pragma mark -  标签View
-(void)createTagsView{
    self.view.backgroundColor = KGrayColor;
    
    self.tagslist=@[@"没效果",@"拖延时间",@"普通话不标准",@"听不懂",@"画面卡顿",@"其他"];
    
    IMJIETagFrame *frame = [[IMJIETagFrame alloc] init];
    frame.tagsMinPadding = 4;
    frame.tagsFrameWidth=kScreenW-20;
    frame.tagsMargin = 10;
    frame.tagsLineSpacing = 10;
    frame.tagsArray = _tagslist;
    
    IMJIETagView*  tagView = [[IMJIETagView alloc] initWithFrame:CGRectMake(10, 100, kScreenW-20, frame.tagsHeight)];
    tagView.tag=100;
    tagView.clickbool = YES;
    tagView.MultiControlTag=1;
    tagView.borderSize = 0.5;
    tagView.clickborderSize = 0.5;
    tagView.tagsFrame = frame;
    tagView.clickBackgroundColor = [UIColor clearColor];
    tagView.clickTitleColor =KBlackColor;
    tagView.clickStart = 1;
    tagView.clickString = @"";//单选  tagView.clickStart 为0
    //    tagView.clickArray = @[@"误解向",@"我看见的花的名字"];//多选 tagView.clickStart 为1
    tagView.delegate = self;
    tagView.selectArray=[NSArray array];
    [self.view addSubview:tagView];
    
}

-(void)IMJIETagView:(NSArray *)tagArray MultiControlTag:(NSInteger)MultiControlTag{
    if(tagArray.count>0)
    {
        self.settagslist=tagArray;
        NSLog(@"%@",tagArray);
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
