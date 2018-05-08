//
//  AllWeddingCardViewModel.m
//  BoYi
//
//  Created by Chen on 2017/9/3.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "AllWeddingCardViewModel.h"
#import "AllWeddingCardTableViewCell.h"
#import "AllWeddingCardCollectionViewCell.h"

@implementation AllWeddingCardViewModel

// custom code
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        @weakify(self);
        //处理正在请求状态
        [[self.refreshDataCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
        }];
        //请求成功
        [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshUISubject sendNext:x];
        }];
        
    }
    return self;
}

#pragma mark - public
/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh {
    
    if (!self.dataArray) self.dataArray = [NSMutableArray array];
    if (isHeaderRefersh) [self.dataArray removeAllObjects];
    
    [self.dataArray addObjectsFromArray:[AllWeddingCardModel mj_objectArrayWithKeyValuesArray:object]];
    
}


#pragma mark - private

- (RACSubject *)refreshUISubject {
    
    if (!_refreshUISubject) _refreshUISubject = [RACSubject subject];
    
    return _refreshUISubject;
}

- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_findInvitation
                                                          method:GET
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _refreshDataCommand;
}



#pragma mark-DataSource的代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray ? 1 : 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    AllWeddingCardModel *model = self.dataArray[indexPath.row];
    
    AllWeddingCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AllWeddingCardCollectionViewCell" forIndexPath:indexPath];
        cell.model = model;
    
    //    @weakify(self);
    //    [[[cell.gotoDetailBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
    //        @strongify(self);
    //
    //        CrackCodeViewController *vc = [[CrackCodeViewController alloc] init];
    //        vc.CodeId = [NSString stringWithFormat:@"%lld",model.codeId];
    //        vc.userId = model.userInfo.userId;
    //        vc.hidesBottomBarWhenPushed = YES;
    //        [self.navigationController pushViewController:vc animated:YES];
    //        //        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    //        //        [self.tabBarController presentViewController:nav animated:YES completion:nil];
    //    }];
    //
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    //    [cell.headerImage addGestureRecognizer:tap];
    //    [[[tap rac_gestureSignal] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
    //        @strongify(self);
    //        NewMineDetailsViewController *vc = [[NewMineDetailsViewController alloc] init];
    //        vc.userId = model.userInfo.userId;
    //        vc.hidesBottomBarWhenPushed = YES;
    //        [self.navigationController pushViewController:vc animated:YES];
    //    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.selectItemSubject sendNext:self.dataArray[indexPath.row]];
    
}
#pragma mark -  tableView 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count > 0 ? self.dataArray.count : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 60;
//}
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
    
    AllWeddingCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllWeddingCardTableViewCell"];
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self.selectItemSubject sendNext:self.dataArray[indexPath.row]];
}
#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    
    NSString *text = @"空空如也";
    
    
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
    return self.dataArray.count == 0  && self.dataArray;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
@end
