//
//  ZLUserInfo.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLUserInfo : NSObject

///用户ID
@property (nonatomic,copy) NSString * userid;
///头像
@property (nonatomic,copy) NSString * photo;
///昵称
@property (nonatomic,copy) NSString * nickname;
///用户登录后分配的登录Token
@property (nonatomic,copy) NSString * token;

@end

NS_ASSUME_NONNULL_END
