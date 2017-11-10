//
//  PageListVC.m
//  scroll_scroll_test
//
//  Created by 马浩 on 2017/11/10.
//  Copyright © 2017年 HuZhang. All rights reserved.
//

#import "PageListVC.h"

@interface PageListVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableview;
@property(nonatomic,copy)NSMutableArray * dataArr;
@property(nonatomic,assign)BOOL firstTime;//是否是第一次加载本页

@end

@implementation PageListVC

-(void)curentViewDidLoad
{
    if (_firstTime) {
        _firstTime = NO;
        
        //假装加载20条数据
        for (int i = 0; i < 20; i ++) {
            [_dataArr addObject:@"1"];
        }
        _tableview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [_tableview reloadData];
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _firstTime = YES;
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.tableFooterView = [UIView new];
    _tableview.showsVerticalScrollIndicator = YES;
    _tableview.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_tableview];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"xindeshouyecellid";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(void)setCanScroll:(BOOL)canScroll
{
    _canScroll = canScroll;
    _tableview.showsVerticalScrollIndicator = canScroll;
    if (!canScroll) {
        _tableview.contentOffset = CGPointZero;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.canScroll) {
        scrollView.contentOffset = CGPointZero;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
