//
//  UIScrollView+MHMH.m
//  NHZGame
//
//  Created by 马浩 on 2017/10/20.
//  Copyright © 2017年 HuZhang. All rights reserved.
//

#import "UIScrollView+MHMH.h"

@implementation UIScrollView (MHMH)

+ (void)load {
    NSLog(@"scrollView调用了load方法");
    if (@available(iOS 11.0, *)){
        //iOS11 解决SafeArea的问题，同时能解决pop时上级页面scrollView抖动的问题
        [[self appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        
    }
    
}
@end
