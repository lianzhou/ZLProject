//
//  FontAndColorMacros.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h

#pragma mark -  字体区
//设置字体
#define KFONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]
//默认
#define KDEFAULTFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
//加粗
#define KDEFAULTBOLDFONT(FONTSIZE)  [UIFont boldSystemFontOfSize:FONTSIZE]

#pragma mark -  颜色区

//颜色
#define KClearColor [UIColor clearColor]
#define KWhiteColor [UIColor whiteColor]
#define KBlackColor [UIColor blackColor]
#define KGrayColor [UIColor grayColor]
#define KGray2Color [UIColor lightGrayColor]
#define KBlueColor [UIColor blueColor]
#define KRedColor [UIColor redColor] 

//主题色 导航栏颜色
#define KNavBgColor UIColorFromHex(00AE68)

#define KNavBgFontColor UIColorFromHex(ffffff)

//默认页面背景色
#define KViewBgColor UIColorFromHex(f2f2f2)

//分割线颜色
#define KLineColor UIColorFromHex(ededed)

//次级字色
#define KFontColor1 UIColorFromHex(1f1f1f)

//再次级字色
#define KFontColor2 UIColorFromHex(5c5c5c) 


#endif /* FontAndColorMacros_h */
