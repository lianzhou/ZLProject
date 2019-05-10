//
//  ZLWechatShareView.m
//  Project_NWZG
//
//  Created by zhoulian on 2016/12/28.
//  Copyright © 2016年 zhoulian. All rights reserved.
//

#import "ZLWechatShareView.h"
#import "ZLWechatSDK.h"

@interface  ZLWechatShareView ()

@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) NSDictionary *kSharedic;

@end
@implementation ZLWechatShareView


-(ZLWechatShareView *)initShareView:(CGRect)frame sharedic:(NSDictionary *)sharedic {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
        
        [self cearteView];
        
        self.kSharedic=sharedic;
    }
    return self;
}

-(void)cearteView{
    
    self.infoView=[[UIView alloc]init ];
    self.infoView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.infoView];
    
    NSArray *titles=@[@"好友",@"朋友圈"];
    
    NSArray *imgalls=@[@"share_icon_1",@"share_icon_2"];
    
    for(int i=0;i<titles.count;i++) {
        
        CGRect frame = CGRectMake(i*kScreenW/titles.count, 0, kScreenW/titles.count, 100);
        NSString *title =titles [i] ;
        NSString *imageStr = imgalls[i] ;
        ZLBtnView *btnView = [[ZLBtnView alloc] initWithFrameShare:frame title:title imageStr:imageStr];
        btnView.tag = 10+i;
        [self.infoView addSubview:btnView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
        [btnView addGestureRecognizer:tap];
        
    }
    self.infoView.frame=CGRectMake(0,kScreenH, kScreenW,120+ZLSafeHeight);
}

-(void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    
    
    NSInteger type=sender.view.tag-10;
    
    if(type==0)
    {
        [self Share:ZLWechatShareSceneSession];
    }
    else
        [self Share:ZLWechatShareSceneTimeLine];
    
}

-(void)Share:(ZLWechatShareScene)ShareType{
    //分享
    ZLWechatShareObject *shareObj = [[ ZLWechatShareObject alloc] init];
    shareObj.title = [_kSharedic objectForKey:@"shareTitle"];
    shareObj.shareContent =[_kSharedic objectForKey:@"shareDesc"];
    shareObj.shareUrl = [_kSharedic objectForKey:@"shareUrl"];
    shareObj.thumbImageData =  UIImagePNGRepresentation(ZL_IMAGE_NAMED([_kSharedic objectForKey:@"sharelogo"]));
    
    shareObj.scene =  ShareType;
    [[ZLWechatSDK shareSDK] wechatshare:shareObj  result:^( ZLWechatResult *result) {
        
        if(result.result){
            [ZLAlertHUD showTipTitle:@"分享成功"];
            [self dismiss];
        }
        else{
            [ZLAlertHUD showTipTitle:@"分享失败"];
        }
    }];
}


- (void)pop {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    [UIView animateWithDuration:.35 animations:^{
        self.infoView.transform = CGAffineTransformMakeTranslation(0, -120-ZLSafeHeight);
    }];
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.infoView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end

@implementation ZLBtnView

-(id)initWithFrameShare:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr{
    self = [super initWithFrame:frame];
    if (self) {
        //
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-29, 15, 58, 58)];
        imageView.image = [UIImage imageNamed:imageStr];
        
        [self addSubview:imageView];
        
        UILabel *Label=[UILabel new] ;
        Label.frame=CGRectMake(0, 15+58, frame.size.width, 20);
        Label.font=KDEFAULTFONT(13);
        Label.textColor=UIColorHex(333333);
        Label.text = title;
        Label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:Label];
    }
    return self;
}



@end
