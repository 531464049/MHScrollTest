//
//  HomeSliderBar.m
//  HZWebBrowser
//
//  Created by 马浩 on 2017/8/28.
//  Copyright © 2017年 HuZhang. All rights reserved.
//

#import "HomeSliderBar.h"
#define btnTag 4400

@interface HomeSliderBar ()
{
    NSArray * _titleArr;//保存标题数组
    UIView * _bottomLine;//底部分割线
    UIView * _sliderLine;//item底部白色线条
    CGFloat _l_r_margin;//底部滑动条左右间隔 默认0 当hasMargin==yes时width(15)
    
    NSInteger _titleNomFont;//普通状态字体大小
    NSInteger _titleSelectedFont;//选中状态字体大小
    BOOL _jiacu;//item字体是否加粗
    
    CGFloat _sliderLineHeight;//底部线条高度
}
@end

@implementation HomeSliderBar

-(instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _titleArr = titArr;
        _titleNomFont = 14;
        _titleSelectedFont = 16;
        _jiacu = NO;
        _l_r_margin = 0;
        _sliderLineHeight = 2.5;
        [self buildSliderPicUIwith:titArr];
    }
    return self;
}
-(void)buildSliderPicUIwith:(NSArray *)titleArr
{
    for (int i = 0; i < titleArr.count; i ++) {
        UIButton * btn = [UIButton buttonWithType:0];
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:titleArr[i] forState:0];
        [btn setTitle:titleArr[i] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor grayColor] forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:_titleNomFont];
        [btn addTarget:self action:@selector(itemBtnSlected:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = btnTag + i;
        [self addSubview:btn];
        btn.frame = CGRectMake(self.frame.size.width/titleArr.count*i, 0, self.frame.size.width/titleArr.count, self.frame.size.height);
//        btn.sd_layout.leftSpaceToView(leftV,0).centerYEqualToView(self).widthRatioToView(self,widthRatio).heightRatioToView(self,1);
        if (i == 0) {
            btn.selected = YES;
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:_titleSelectedFont];
        }
    }
    
    _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    _bottomLine.backgroundColor = [UIColor grayColor];
    _bottomLine.hidden = YES;
    [self addSubview:_bottomLine];
    
    _sliderLine = [[UIView alloc] initWithFrame:CGRectMake(_l_r_margin, self.frame.size.height-_sliderLineHeight, self.frame.size.width/titleArr.count - 2*_l_r_margin, _sliderLineHeight)];
    _sliderLine.backgroundColor = [UIColor redColor];
    [self addSubview:_sliderLine];
}
-(void)setHasMargin:(BOOL)hasMargin
{
    _hasMargin = hasMargin;
    if (hasMargin) {
        _l_r_margin = 15;
    }
    _sliderLine.frame = CGRectMake(_l_r_margin, self.frame.size.height-_sliderLineHeight, self.frame.size.width/_titleArr.count - 2*_l_r_margin, _sliderLineHeight);
}
-(void)setShowBottomLine:(BOOL)showBottomLine
{
    _showBottomLine = showBottomLine;
    _bottomLine.hidden = !showBottomLine;
}
-(void)setS_BGColor:(UIColor *)S_BGColor
{
    self.backgroundColor = S_BGColor;
}
-(void)setTitleNomColor:(UIColor *)titleNomColor
{
    for (int i = 0; i < _titleArr.count; i ++) {
        UIButton * btn = (UIButton *)[self viewWithTag:btnTag + i];
        [btn setTitleColor:titleNomColor forState:0];
    }
}
-(void)setTitleSlectedColor:(UIColor *)titleSlectedColor
{
    for (int i = 0; i < _titleArr.count; i ++) {
        UIButton * btn = (UIButton *)[self viewWithTag:btnTag + i];
        [btn setTitleColor:titleSlectedColor forState:UIControlStateSelected];
    }
}
-(void)setSliderLineColor:(UIColor *)sliderLineColor
{
    _sliderLine.backgroundColor = sliderLineColor;
}
-(void)setSliderNomFont:(NSInteger)numFont selectedFont:(NSInteger)selectedFont jiacu:(BOOL)jiacu
{
    _titleNomFont = numFont;
    _titleSelectedFont = selectedFont;
    _jiacu = jiacu;
    for (int i = 0; i < _titleArr.count; i ++) {
        UIButton * btn = (UIButton *)[self viewWithTag:btnTag + i];
        btn.titleLabel.font = jiacu ? [UIFont boldSystemFontOfSize:_titleNomFont] : [UIFont systemFontOfSize:_titleNomFont];
    }
    UIButton * btn = (UIButton *)[self viewWithTag:btnTag + 0];
    btn.titleLabel.font = jiacu ? [UIFont boldSystemFontOfSize:_titleSelectedFont] : [UIFont systemFontOfSize:_titleSelectedFont];
}
#pragma mark - 滑动后选中的选项
-(void)sliderPicSlecteditem:(NSInteger)index
{
    [self reSetItemWith:index];
    UIButton * btn = (UIButton *)[self viewWithTag:index + btnTag];
    btn.selected = YES;
    btn.titleLabel.font = _jiacu ? [UIFont boldSystemFontOfSize:_titleSelectedFont] : [UIFont systemFontOfSize:_titleSelectedFont];
}
#pragma mark - 点击按钮
-(void)itemBtnSlected:(UIButton *)sender
{
    NSInteger index = sender.tag - btnTag;
    [self reSetItemWith:index];
    sender.selected = YES;
    sender.titleLabel.font = _jiacu ? [UIFont boldSystemFontOfSize:_titleSelectedFont] : [UIFont systemFontOfSize:_titleSelectedFont];
    
}
#pragma mark - 当外界滑动时，更新底部线条位置
-(void)sliderPicViewScrollBottomLine:(CGFloat )cfl
{
    if (cfl <= 0 || cfl >= _titleArr.count - 1) {
        return;
    }
    _sliderLine.frame = CGRectMake(self.frame.size.width/_titleArr.count*cfl + _l_r_margin, self.frame.size.height-_sliderLineHeight, self.frame.size.width/_titleArr.count - 2*_l_r_margin, _sliderLineHeight);
}
#pragma mark - 重置item选中状态 滑动线条，通知外部选中状态
-(void)reSetItemWith:(NSInteger )index
{
    for (int i = 0; i < _titleArr.count; i++) {
        UIButton * btn = (UIButton *)[self viewWithTag:i + btnTag];
        btn.selected = NO;
        btn.titleLabel.font = _jiacu ? [UIFont boldSystemFontOfSize:_titleNomFont] : [UIFont systemFontOfSize:_titleNomFont];
    }
    [UIView animateWithDuration:0.1 animations:^{
        _sliderLine.frame = CGRectMake(self.frame.size.width/_titleArr.count*index + _l_r_margin, self.frame.size.height-_sliderLineHeight, self.frame.size.width/_titleArr.count - 2*_l_r_margin, _sliderLineHeight);
    }];
    if (self.delegate && [self.delegate respondsToSelector:@selector(HomeSliderBar:ItemSelected:)]) {
        [self.delegate HomeSliderBar:self ItemSelected:index];
    }
}


@end
