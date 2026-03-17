//
//  HotViewModel.m
//  BoYi
//
//  Created by heng on 2017/11/26.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "HotViewModel.h"
#import "HotContentTableViewCell.h"
#import "hotoneTableViewCell.h"
#import "HotViewheader.h"

@implementation HotViewModel

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
        //请求成功分类列表
        [self.fenleilistDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.fenleilistUISubject sendNext:x];
        }];
        [self.getquyuDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.getquyuUISubject sendNext:x];
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
    
    [self.dataArray addObjectsFromArray:[HotViewModel mj_objectArrayWithKeyValuesArray:object]];
    
}


#pragma mark - private

- (RACSubject *)shaixuanSubject {
    
    if (!_shaixuanSubject) _shaixuanSubject = [RACSubject subject];
    
    return _shaixuanSubject;
}
- (RACSubject *)refreshUISubject {
    
    if (!_refreshUISubject) _refreshUISubject = [RACSubject subject];
    
    return _refreshUISubject;
}

- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
- (RACSubject *)bannerSubject {
    
    if (!_bannerSubject) _bannerSubject = [RACSubject subject];
    
    return _bannerSubject;
}
- (RACSubject *)fenleilistUISubject {
    
    if (!_fenleilistUISubject) _fenleilistUISubject = [RACSubject subject];
    
    return _fenleilistUISubject;
}
- (RACSubject *)getquyuUISubject {
    
    if (!_getquyuUISubject) _getquyuUISubject = [RACSubject subject];
    
    return _getquyuUISubject;
}
- (RACSubject *)pushUISubject {
    
    if (!_pushUISubject) _pushUISubject = [RACSubject subject];
    
    return _pushUISubject;
}
- (RACSubject *)bannerUISubject {
    
    if (!_bannerUISubject) _bannerUISubject = [RACSubject subject];
    
    return _bannerUISubject;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_hotlist
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _refreshDataCommand;
}
- (RACCommand *)fenleilistDataCommand {
    
    if (!_fenleilistDataCommand) {
        @weakify(self);
        _fenleilistDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_indexfenleilist
                                                          method:POST
                                                          loding:nil
                                                             dic:input];
        }];
    }
    return _fenleilistDataCommand;
}
- (RACCommand *)getquyuDataCommand {
    
    if (!_getquyuDataCommand) {
        @weakify(self);
        _getquyuDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_getquyu
                                                          method:POST
                                                          loding:nil
                                                             dic:input];
        }];
    }
    return _getquyuDataCommand;
}
#pragma mark -  tableView 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return self.model.remensj.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 170;
    }else {
        return 92;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    

    if (section == 1) {
        return 82;
    }else {
        return 0.0000001;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        HotViewheader *header = [[NSBundle mainBundle]loadNibNamed:@"HotViewheader" owner:nil options:nil].firstObject;
        header.frame = CGRectMake(0, 0, ScreenWidth, 82);
       
        @weakify(self);
        [header.gotoNextVc subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            
            [self.pushUISubject sendNext:x];
        }];
        return header;
    }
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        hotoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotoneTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"hotoneTableViewCell" owner:nil options:nil].firstObject;
        }
        NSMutableArray *ay = [NSMutableArray array];
        for (int i = 0; i < self.model.guanggaolunbo.count; i ++) {
            
            Guanggaolunbohot *model = self.model.guanggaolunbo[i];
            [ay addObject: model.wapimg];
        }
        cell.photos = ay;
        @weakify(self);
        [[cell.gotoNextVc takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.bannerUISubject sendNext:x];
        }];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else {
        HotContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotContentTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"HotContentTableViewCell" owner:nil options:nil].firstObject;
        }
        cell.model = self.model.remensj[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {

    }else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.selectItemSubject sendNext:self.model.remensj[indexPath.row]];
    }
    
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
