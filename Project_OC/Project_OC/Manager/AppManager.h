//
//  AppManager.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/14.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 包含应用层的相关服务
 */
@interface AppManager : NSObject

#pragma mark ————— APP启动接口 —————
+(void)appStart;

@end

NS_ASSUME_NONNULL_END
