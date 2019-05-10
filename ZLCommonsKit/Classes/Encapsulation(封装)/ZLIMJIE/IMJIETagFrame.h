//
//  IMJIETagFrame.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
 
@interface IMJIETagFrame : NSObject

/** 标签名字数组 */
@property (nonatomic, strong) NSArray *tagsArray;
/** 标签frame数组 */
@property (nonatomic, strong) NSMutableArray *tagsFrames;
/** 全部标签的高度 */
@property (nonatomic, assign) CGFloat tagsHeight;
/** 标签间距 default is 10*/
@property (nonatomic, assign) CGFloat tagsMargin;
/** 标签行间距 default is 10*/
@property (nonatomic, assign) CGFloat tagsLineSpacing;
/** 标签最小内边距 default is 10*/
@property (nonatomic, assign) CGFloat tagsMinPadding;

/**整个宽度*/
@property (nonatomic, assign) CGFloat tagsFrameWidth ;

@end
