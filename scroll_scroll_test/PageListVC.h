//
//  PageListVC.h
//  scroll_scroll_test
//
//  Created by 马浩 on 2017/11/10.
//  Copyright © 2017年 HuZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageListVC : UIViewController

@property(nonatomic,assign)BOOL canScroll;

/**
 代替viewDidLoad
 */
-(void)curentViewDidLoad;

@end
