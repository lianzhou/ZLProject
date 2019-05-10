//
//  ThirdMacros.h
//  Project_OC
//
//  Created by zhoulian on 2019/3/8.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#ifndef ThirdMacros_h
#define ThirdMacros_h

//Share化组件appkey
#define ShareAppKey     @""

//极光
#define appJPushKey @" "

//微信
#define WX_APP_ID @"wx4577d3a452def6d2"
#define WX_APP_SECERT @"5500f691ab12af9c68d6e05aff667fcb"


//苹果ID
#define applestoreid 1371351454


//苹果版本更新地址
#define APPSTOREAPPIDVERSIONCHECK [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%d",applestoreid]

#define itunesApplURL  [NSString stringWithFormat:@"http://itunes.apple.com/cn/app/id%d",applestoreid]

//评分地址
#define itunesAppReviewlURL  [NSString stringWithFormat:@"http://itunes.apple.com/cn/app/id%d?action=write-review",applestoreid]



#endif /* ThirdMacros_h */
