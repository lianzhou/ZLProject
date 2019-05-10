//
//  ZLWechatShareView.h
//  Project_NWZG
//
//  Created by zhoulian on 2016/12/28.
//  Copyright © 2016年 zhoulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLWechatShareView : UIView
-(ZLWechatShareView *)initShareView:(CGRect)frame sharedic:(NSDictionary *)sharedic;
- (void)pop ;
@end


@interface ZLBtnView : UIView


/**
 分享
 
 @param frame <#frame description#>
 @param title <#title description#>
 @param imageStr <#imageStr description#>
 @return <#return value description#>
 */
-(id)initWithFrameShare:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr;

@end
