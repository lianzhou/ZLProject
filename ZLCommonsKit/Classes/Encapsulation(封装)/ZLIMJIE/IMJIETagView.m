//
//  IMJIETagView.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "IMJIETagView.h"

@implementation IMJIETagView

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        selectedBtnList = [[NSMutableArray alloc] init];
        self.clickBackgroundColor = [UIColor whiteColor];
        self.clickTitleColor = KGray2Color;
        self.clickArray = nil;
        self.clickbool = YES;
        self.radius=YES;
        self.borderSize = 0.5;
        self.clickborderSize =0.5;
    }
    return self;
}

-(void)setTagsFrame:(IMJIETagFrame *)tagsFrame{
    
    UIButton *btn;
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            btn = (UIButton *)obj;
            [btn removeFromSuperview];
        }
    }
    
    _tagsFrame = tagsFrame;
    
    for (NSInteger i=0; i<tagsFrame.tagsArray.count; i++) {
        
        UIButton *tagsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tagsBtn setTitle:tagsFrame.tagsArray[i] forState:UIControlStateNormal];
        [tagsBtn setTitleColor: KGray2Color  forState:UIControlStateNormal];
        [tagsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        tagsBtn.titleLabel.font = KDEFAULTFONT(14);
        tagsBtn.tag = i;
        
        
      if(_radius){
            tagsBtn.clipsToBounds = YES;
            tagsBtn.layer.cornerRadius = _clickborderSize > 0.0 ?_clickborderSize : 4/[UIScreen mainScreen].scale;
            tagsBtn.layer.borderColor = KGray2Color.CGColor;
            tagsBtn.layer.borderWidth = _borderWidth > 0.0 ? _borderWidth : 1/[UIScreen mainScreen].scale;
        } 
     
          [self makeCorner:self.borderSize view:tagsBtn color:KGray2Color ];
        tagsBtn.backgroundColor = [UIColor whiteColor];
        
        tagsBtn.frame = CGRectFromString(tagsFrame.tagsFrames[i]);
        
        [tagsBtn addTarget:self action:@selector(TagsBtn:) forControlEvents:UIControlEventTouchDown];
        
        tagsBtn.enabled = _clickbool;
        
//        if(i==tagsFrame.tagsArray.count-1){
//            tagsBtn.enabled=YES;
////            [tagsBtn setTitleColor: RD_UIColorFromHex(0x0077ce) forState:UIControlStateNormal];
//         //   [tagsBtn setTitleColor: RD_UIColorFromHex(0x0077ce) forState:UIControlStateSelected];
//
//            NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//
//            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:tagsFrame.tagsArray[i] attributes:attribtDic];
//
//            [attribtStr addAttribute:NSFontAttributeName
//                               value:KDEFAULTBOLDFONT(15)
//                               range:NSMakeRange(0,  attribtStr.length)];
//
//            [attribtStr addAttribute:NSForegroundColorAttributeName
//                               value:UIColorFromHex(0x0077ce)
//                               range:NSMakeRange(0,  attribtStr.length)];
//
//            [tagsBtn setAttributedTitle:attribtStr forState:UIControlStateNormal];
//        }
        
        [self addSubview:tagsBtn];
    }
}

#pragma mark 选中背景颜色
-(void)setClickBackgroundColor:(UIColor *)clickBackgroundColor{
    
    if (_clickBackgroundColor != clickBackgroundColor) {
        _clickBackgroundColor = clickBackgroundColor;
    }
}

#pragma makr 选中字体颜色
-(void)setClickTitleColor:(UIColor *)clickTitleColor{
    
    if (_clickTitleColor != clickTitleColor) {
        _clickTitleColor = clickTitleColor;
    }
}

#pragma makr 能否被选中
-(void)setClickbool:(BOOL)clickbool{
    
    _clickbool = clickbool;
    
}

#pragma makr 未选中边框大小
-(void)setBorderSize:(CGFloat)borderSize{
    
    if (_borderSize!=borderSize) {
        _borderSize = borderSize;
    }
}

#pragma makr 选中边框大小
-(void)setClickborderSize:(CGFloat)clickborderSize{
    
    if (_clickborderSize!= clickborderSize) {
        _clickborderSize = clickborderSize;
    }
}

#pragma makr 默认选择 单选
-(void)setClickString:(NSString *)clickString{
    
    if (_clickString != clickString) {
        _clickString = clickString;
    }
    if ([_tagsFrame.tagsArray containsObject:_clickString]) {
        
        NSInteger index = [_tagsFrame.tagsArray indexOfObject:_clickString];
        [self ClickString:index];
    }
}
#pragma makr 默认已选择的
- (void)setSelectArray:(NSArray *)selectArray
{
    [selectedBtnList addObjectsFromArray:selectArray];
    
    for (int i=0; i<selectArray.count; i++) {
        NSString *index=selectArray[i];
        UIButton *btn;
        for (id obj in self.subviews) {
            if ([obj isKindOfClass:[UIButton class]]) {
                btn = (UIButton *)obj;
                if (btn.tag == [index integerValue])
                {
                    btn.selected=YES;
                    btn.backgroundColor = KBlueColor;
                    [self makeCorner:_clickborderSize view:btn color:KBlueColor];
                }
            }
        }
    }
}

#pragma mark 默认选择 多选
-(void)setClickArray:(NSArray *)clickArray{
    
    if (_clickArray != clickArray) {
        _clickArray = clickArray;
    }
    for (NSString *string in clickArray) {
        
        if ([_tagsFrame.tagsArray containsObject:string]) {
            
            NSInteger index = [_tagsFrame.tagsArray indexOfObject:string];
            NSString *x = [[NSString alloc] initWithFormat:@"%ld",(long)index];
            [self ClickArray:x];
        }
        
    }
    
}
#pragma makr取消选择
-(void)CancelClick
{
    for(int i=0;i<selectedBtnList.count;i++)
    {
        UIButton *btn;
        for (id obj in self.subviews)
        {
            btn = (UIButton *)obj;
            btn.selected=NO;
            [self makeCorner:self.borderSize view:btn color:KGray2Color];
            btn.backgroundColor=[UIColor whiteColor];
        }
    }
    
    if(selectedBtnList.count>0)
        [selectedBtnList removeAllObjects];
}

#pragma makr 单选
-(void)ClickString:(NSInteger )index{
    
    UIButton *btn;
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            btn = (UIButton *)obj;
            if (btn.tag == index){
                
                btn.selected=YES;
                // btn.backgroundColor = BlueColor;
                
                [_delegate IMJIETagView:@[[NSString stringWithFormat:@"%ld",(long)index]]  MultiControlTag:self.MultiControlTag];
                
            }else{
                
                btn.selected=NO;
                
                //  btn.backgroundColor=[UIColor whiteColor];
                [self makeCorner:_clickborderSize view:btn color:KBlueColor];
            }
        }
    }
}


#pragma mark 多选
-(void)ClickArray:(NSString *)index{
    
    UIButton *btn;
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            btn = (UIButton *)obj;
            if (btn.tag == [index integerValue]){
                
                if ([selectedBtnList containsObject:index]) {
                    btn.selected=NO;
                    btn.backgroundColor = [UIColor whiteColor];
                    
                    [self makeCorner:_clickborderSize view:btn color:KGray2Color];
                    [selectedBtnList removeObject:index];
                }
                else
                {
                    btn.selected=YES;
                    btn.backgroundColor = KBlueColor;
                    [self makeCorner:_clickborderSize view:btn color:KBlueColor];
                    [selectedBtnList addObject:index];
                }
                [_delegate IMJIETagView:selectedBtnList  MultiControlTag:self.MultiControlTag];
            }
        }
    }
}

-(void)makeCorner:(CGFloat)corner view:(UIView *)view color:(UIColor *)color{
    
    CALayer * fileslayer = [view layer];
    fileslayer.borderColor = [color CGColor];
    fileslayer.borderWidth = corner;
}

-(void)TagsBtn:(UIButton *)sender{
    
    if (self.clickStart == 0) {
        //单选
        [self ClickString:sender.tag];
        
    }else{
        //多选
        NSString *x = [[NSString alloc] initWithFormat:@"%ld",(long)sender.tag];
        [self ClickArray:x];
    }
}

@end
