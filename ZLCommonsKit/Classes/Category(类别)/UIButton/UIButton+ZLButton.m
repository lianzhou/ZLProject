//
//  UIButton+ZLButton.m
//  Project_OC
//
//  Created by zhoulian on 2019/3/14.
//  Copyright © 2019 zhoulian. All rights reserved.
//

#import "UIButton+ZLButton.h"

@implementation UIButton (ZLButton)

-(void)setBlock:(void(^)(UIButton*))block
{
    
    objc_setAssociatedObject(self,@selector(block), block,OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self addTarget:self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
    
}

-(void(^)(UIButton*))block
{
    
    return objc_getAssociatedObject(self,@selector(block));
    
}

-(void)addTapBlock:(void(^)(UIButton*))block
{
    
    self.block= block;
    
    [self addTarget:self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)click:(UIButton*)btn
{
    
    if(self.block) {
        
        self.block(btn);
        
    }
    
}

@end
