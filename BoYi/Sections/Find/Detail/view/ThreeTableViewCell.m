//
//  ThreeTableViewCell.m
//  BoYi
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ThreeTableViewCell.h"
#import "TalkPJTableViewCell.h"

@implementation ThreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.table registerNib:[UINib nibWithNibName:@"TalkPJTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TalkPJTableViewCell"];
    _table.delegate = self;
    _table.dataSource = self;
    self.table.emptyDataSetDelegate = self;
    self.table.emptyDataSetSource   = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    //请求结束
//    [self.viewModel.refreshUISubjectPJ subscribeNext:^(id  _Nullable x) {
//        
//        @strongify(self);
//        
//        //数据处理
//        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
//        
//        //正在下啦
//        if (self.table.mj_header.isRefreshing) {
//            
//            if (!self.table.mj_footer) {
//                //上啦加载
//                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    //传入参数 进行刷新
//                    [self.viewModel.refreshDataCommand execute:@{}];
//                }];
//            }
//            [self.table.mj_header endRefreshing];
//        }
//        
//        //判断，如果item < size 显示已获取完成
//        if (self.viewModel.dataArray.count < 10) {
//            
//            [self.table.mj_footer endRefreshingWithNoMoreData];
//        } else {
//            
//            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
//            
//        }
//        
//        //刷新视图
//        [self.table reloadData];
//        
//    }];
    
}
- (void)setDataArrayPJ:(NSMutableArray<EsarraypjPJ *> *)dataArrayPJ{
    _dataArrayPJ = dataArrayPJ;
    if (_dataArrayPJ.count > 0) {
        self.PJnumber.text = [NSString stringWithFormat:@"客户评价(%lu)",(unsigned long)_dataArrayPJ.count];
    }
    
    [self.table reloadData];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -  tableView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return self.dataArrayPJ.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EsarraypjPJ *model = self.dataArrayPJ[indexPath.row];
    
    return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:NSClassFromString(@"TalkPJTableViewCell") contentViewWidth:ScreenWidth-27];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    TalkPJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TalkPJTableViewCell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TalkPJTableViewCell" owner:nil options:nil].firstObject;
    }
    
    cell.model = self.dataArrayPJ[indexPath.row];
    return cell;
    
}

#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    
    NSString *text = @"暂无评价";
    
    
    UIFont *font = [UIFont boldSystemFontOfSize:13.0];
    UIColor *textColor = RGBA(202, 202, 202, 1);
    
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}



- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return IMAGE_NAME(@"无数据 空状态");
}





- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -49.0;
}

//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return -49.0;
//}


#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return self.dataArrayPJ.count == 0  && self.dataArrayPJ;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return NO;
}

@end
