//
//  UIButton+ZLButton.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/14.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIButton (ZLButton)

@property(nonatomic ,copy)void(^block)(UIButton*);

-(void)addTapBlock:(void(^)(UIButton*btn))block;


@end

NS_ASSUME_NONNULL_END
