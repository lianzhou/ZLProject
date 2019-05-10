//
//  ZLPBImageView.m
//  MyAPP
//
//  Created by 周连 on 16/8/20.
//  Copyright © 2016年 周连. All rights reserved.
//

#import "ZLPBImageView.h"

@implementation ZLPBImageView

@synthesize originRect;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        originRect = frame;
        self.clipsToBounds = YES;
        self.userInteractionEnabled  = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return self;
}

- (void)dealloc
{
    
}


@end
