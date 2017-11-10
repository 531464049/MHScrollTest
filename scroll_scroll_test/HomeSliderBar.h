//
//  HomeSliderBar.h
//  HZWebBrowser
//
//  Created by 马浩 on 2017/8/28.
//  Copyright © 2017年 HuZhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HomeSliderBarDelegate;

@interface HomeSliderBar : UIView

@property(nonatomic,weak)id <HomeSliderBarDelegate> delegate;
@property(nonatomic,strong)UIColor * S_BGColor;//设置背景颜色
@property(nonatomic,strong)UIColor * titleNomColor;//设置item未选中时的颜色，默认grayColor
@property(nonatomic,strong)UIColor * titleSlectedColor;//设置item选中时的颜色，默认whiteColor
@property(nonatomic,strong)UIColor * sliderLineColor;//设置底部滑动条颜色，默认whiteColor
@property(nonatomic,assign)BOOL showBottomLine;//是否显示底部分割线
@property(nonatomic,assign)BOOL hasMargin;//底部滑动条左右是否有间隔


/**
 设置选项条字体 是否加粗

 @param numFont 未选中时的字体大小
 @param selectedFont 选中的大小
 @param jiacu 是否加粗
 */
-(void)setSliderNomFont:(NSInteger)numFont selectedFont:(NSInteger)selectedFont jiacu:(BOOL)jiacu;

/**
 * 初始化选项卡
 * @param frame opopop
 * @param titArr 标题数组
 */
-(instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titArr;
/**
 * 当前选中项
 * @param index 选中项标记
 */
-(void)sliderPicSlecteditem:(NSInteger )index;
/**
 * 当外界滑动时通知slider，更新底部线条位置
 * @param cfl 外界滑动比例
 */
-(void)sliderPicViewScrollBottomLine:(CGFloat )cfl;


@end


@protocol HomeSliderBarDelegate <NSObject>
/**
 * 当选项卡最终选中某项之后，返回选中的项
 * @param index 选中的第几项
 */
-(void)HomeSliderBar:(HomeSliderBar *)bar ItemSelected:(NSInteger)index;

@end
