//
//  PageSliderContentView.m
//  scroll_scroll_test
//
//  Created by 马浩 on 2017/11/10.
//  Copyright © 2017年 HuZhang. All rights reserved.
//

#import "PageSliderContentView.h"

@interface PageSliderContentView ()<HomeSliderBarDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)HomeSliderBar * sliderBar;
@property(nonatomic,strong)UIScrollView * contentScroll;
@property(nonatomic,copy)NSArray * listVCArr;//保存列表vc

@end

@implementation PageSliderContentView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray * titleArr = @[@"item1",@"item2",@"item3",@"item4"];
        
        _sliderBar = [[HomeSliderBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44) titleArr:titleArr];
        _sliderBar.delegate = self;
        _sliderBar.hasMargin= YES;
        _sliderBar.titleNomColor = [UIColor blackColor];
        _sliderBar.titleSlectedColor = [UIColor redColor];
        [_sliderBar setSliderNomFont:17 selectedFont:17 jiacu:NO];
        _sliderBar.showBottomLine = YES;
        [self addSubview:_sliderBar];
        
        _contentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, self.frame.size.width, self.frame.size.height-44)];
        _contentScroll.delegate = self;
        _contentScroll.showsVerticalScrollIndicator = NO;
        _contentScroll.showsHorizontalScrollIndicator = NO;
        _contentScroll.pagingEnabled = YES;
        [self addSubview:_contentScroll];
        _contentScroll.contentSize = CGSizeMake(_contentScroll.frame.size.width*4, _contentScroll.frame.size.height);
        
        //添加四个vc
        NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < titleArr.count; i ++) {
            PageListVC * vc = [[PageListVC alloc] init];
            vc.view.frame = CGRectMake(_contentScroll.frame.size.width*i, 0, _contentScroll.frame.size.width, _contentScroll.frame.size.height);
            vc.canScroll = NO;
            if (i == 0) {
                [vc curentViewDidLoad];
            }
            [_contentScroll addSubview:vc.view];
            [arr addObject:vc];
        }
        self.listVCArr = [NSArray arrayWithArray:arr];
    }
    return self;
}
-(void)setListCanScroll:(BOOL)listCanScroll
{
    _listCanScroll = listCanScroll;
    for (int i = 0; i < self.listVCArr.count; i ++) {
        PageListVC * vc = (PageListVC *)self.listVCArr[i];
        vc.canScroll = listCanScroll;
    }
}
-(void)HomeSliderBar:(HomeSliderBar *)bar ItemSelected:(NSInteger)index
{
    [_contentScroll setContentOffset:CGPointMake(_contentScroll.frame.size.width * index, 0) animated:NO];
    [self.listVCArr[index] curentViewDidLoad];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrFl = (NSInteger)scrollView.contentOffset.x/_contentScroll.frame.size.width;
    [_sliderBar sliderPicViewScrollBottomLine:scrFl];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger tag = (NSInteger)scrollView.contentOffset.x/_contentScroll.frame.size.width;
    [_sliderBar sliderPicSlecteditem:tag];
}

@end
