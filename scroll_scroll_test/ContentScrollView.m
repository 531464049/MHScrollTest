//
//  ContentScrollView.m
//  scroll_scroll_test
//
//  Created by 马浩 on 2017/11/10.
//  Copyright © 2017年 HuZhang. All rights reserved.
//

#import "ContentScrollView.h"

@implementation ContentScrollView

/**
 同时识别多个手势
 
 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
