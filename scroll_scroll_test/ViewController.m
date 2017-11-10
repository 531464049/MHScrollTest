//
//  ViewController.m
//  scroll_scroll_test
//
//  Created by 马浩 on 2017/11/10.
//  Copyright © 2017年 HuZhang. All rights reserved.
//

#import "ViewController.h"
#import "ContentScrollView.h"   //整体容器
#import "PageSliderContentView.h"   //底部滑动容器

#define kTopViewHeight   200    //顶部view高度
#define kSliderHeight    44    //顶部slider高度

@interface ViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)ContentScrollView * contentScrollView;//整体容器
@property(nonatomic,strong)UIView * headerView;//顶部头视图
@property(nonatomic,strong)PageSliderContentView * sliderContentView;//底部滑动容器

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self buildUI];
    [self addBottomBtn];
}
-(void)buildUI
{
    [self.view addSubview:self.contentScrollView];
    [self.contentScrollView addSubview:self.headerView];
    [self.contentScrollView addSubview:self.sliderContentView];
    self.sliderContentView.listCanScroll = NO;
}
#pragma mark - scrollview代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.contentScrollView) {
        if (scrollView.contentOffset.y >= kTopViewHeight) {
            self.sliderContentView.listCanScroll = YES;
            scrollView.scrollEnabled = NO;
            [scrollView setContentOffset:CGPointMake(0, kTopViewHeight)];
        }else{
            self.sliderContentView.listCanScroll = NO;
        }
    }
}
#pragma mark - scrollview代理方法 手指停止拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {//拖动结束，且不滑动
        if (scrollView == self.contentScrollView) {
            if (scrollView.contentOffset.y <=  kTopViewHeight/2) {
                [scrollView setContentOffset:CGPointZero animated:YES];
            }else if (scrollView.contentOffset.y <=  kTopViewHeight) {
                [scrollView setContentOffset:CGPointMake(0, kTopViewHeight) animated:YES];
            }
        }
    }
}
#pragma mark - scrollview代理方法 滑动停止
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.contentScrollView) {
        if (scrollView == self.contentScrollView) {
            if (scrollView.contentOffset.y <=  kTopViewHeight/2) {
                [scrollView setContentOffset:CGPointZero animated:YES];
            }else if (scrollView.contentOffset.y <=  kTopViewHeight) {
                [scrollView setContentOffset:CGPointMake(0, kTopViewHeight) animated:YES];
            }
        }
    }
}
#pragma mark - 返回顶部
-(void)tap_backToTop
{
    NSLog(@"返回顶部");
    //    self.sliderContentView.listCanScroll = NO;
    self.contentScrollView.scrollEnabled = YES;
    [self.contentScrollView setContentOffset:CGPointZero animated:YES];
}
-(ContentScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[ContentScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-40)];
        _contentScrollView.backgroundColor = [UIColor purpleColor];
        _contentScrollView.delegate = self;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        [_contentScrollView setContentSize:CGSizeMake(self.view.frame.size.width, kTopViewHeight+_contentScrollView.frame.size.height)];
    }
    return _contentScrollView;
}
-(UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kTopViewHeight)];
        _headerView.backgroundColor = [UIColor redColor];
    }
    return _headerView;
}
-(PageSliderContentView *)sliderContentView
{
    if (!_sliderContentView) {
        _sliderContentView = [[PageSliderContentView alloc] initWithFrame:CGRectMake(0, kTopViewHeight, self.contentScrollView.frame.size.width, self.contentScrollView.frame.size.height)];
        _sliderContentView.backgroundColor = [UIColor orangeColor];
    }
    return _sliderContentView;
}
#pragma mark - 底部按钮
-(void)addBottomBtn
{
    UIButton * btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40);
    [btn setTitle:@"点击-返回顶部" forState:0];
    [btn setTitleColor:[UIColor blackColor] forState:0];
    [btn addTarget:self action:@selector(tap_backToTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
