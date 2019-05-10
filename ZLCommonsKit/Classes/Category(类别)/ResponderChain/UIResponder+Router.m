//
//  UIResponder+Router.m
//  ZLCommonsKit
//
//         我有一壶酒,足以慰风尘
//         倾倒江海里,共饮天下人
//
//  Created by zhoulian on 17/7/10.
//  Copyright © 2017年 zhoulian. All rights reserved.
//

#import "UIResponder+Router.h"


@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName withObject:(id)obj withUserInfo:(id)userInfo;
{
    [[self nextResponder] routerEventWithName:eventName withObject:obj withUserInfo:userInfo];
}

@end
