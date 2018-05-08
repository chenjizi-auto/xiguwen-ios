//
//  ShangchengsjNewDetilViewModel.m
//  BoYi
//
//  Created by heng on 2018/2/10.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShangchengsjNewDetilViewModel.h"
#import "ShangchengsjNewDetilTableViewCell.h"
#import "ShangjiaNewthreeTableViewCell.h"
#import "DongtaiNewViewTableViewCell.h"
@implementation ShangchengsjNewDetilViewModel

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
        [self.hotDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshUISubject sendNext:x];
        }];
        [self.indexDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshUISubject sendNext:x];
        }];
        [self.pinglunDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.pinglunSubject sendNext:x];
        }];
        [self.dongtaiDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.dongtaiSubject sendNext:x];
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
    
    [self.dataArray addObjectsFromArray:[Shopshangchengsj mj_objectArrayWithKeyValuesArray:object[@"shop"]]];
    
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
- (RACSubject *)hotSubject {
    
    if (!_hotSubject) _hotSubject = [RACSubject subject];
    
    return _hotSubject;
}
- (RACSubject *)indexSubject {
    
    if (!_indexSubject) _indexSubject = [RACSubject subject];
    
    return _indexSubject;
}

- (RACSubject *)pinglunSubject {
    
    if (!_pinglunSubject) _pinglunSubject = [RACSubject subject];
    
    return _pinglunSubject;
}
- (RACSubject *)dongtaiSubject {
    
    if (!_dongtaiSubject) _dongtaiSubject = [RACSubject subject];
    
    return _dongtaiSubject;
}
- (RACCommand *)pinglunDataCommand {
    
    if (!_pinglunDataCommand) {
        @weakify(self);
        _pinglunDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/shoppingmall/businesscomment"]
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _pinglunDataCommand;
}
- (RACCommand *)dongtaiDataCommand {
    
    if (!_dongtaiDataCommand) {
        @weakify(self);
        _dongtaiDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/Shoppingmall/dongtai"]
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _dongtaiDataCommand;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_shangchengshangjiaDetial
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _refreshDataCommand;
}
- (RACCommand *)indexDataCommand {
    
    if (!_indexDataCommand) {
        @weakify(self);
        _indexDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_shangchengshangjiazhuyelist
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _indexDataCommand;
}
- (RACCommand *)hotDataCommand {
    
    if (!_hotDataCommand) {
        @weakify(self);
        _hotDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_shangchengshangjiarenmenlist
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _hotDataCommand;
}
#pragma mark -  tableView 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.type == 3) {
        return self.dataArrayPingjia.count > 0 ? 1 : 0;
    }else {
        return self.dataArrayDongtai.count > 0 ? 1 : 0;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.type == 3) {
        return self.dataArrayPingjia.count;
    }else {
        return self.dataArrayDongtai.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.type == 3) {
        CGFloat cellWidth = ScreenWidth - 32;
        NSString *content = self.dataArrayPingjia[indexPath.row].content;
        CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:15] Size:CGSizeMake(cellWidth, CGFLOAT_MAX)];
        
        NSString *content1 = self.dataArrayPingjia[indexPath.row].replay_content;
        CGSize size1 = [content1 sizeWithFont:[UIFont systemFontOfSize:14] Size:CGSizeMake(cellWidth, CGFLOAT_MAX)];
        int i = 0;
        if (self.dataArrayPingjia[indexPath.row].pictures.count == 0) {
            i = 110 * 0;
        }else if (self.dataArrayPingjia[indexPath.row].pictures.count > 0 && self.dataArrayPingjia[indexPath.row].pictures.count < 4) {
            i = 110 * 1;
            
        }else if (self.dataArrayPingjia[indexPath.row].pictures.count > 3 && self.dataArrayPingjia[indexPath.row].pictures.count < 7) {
            i = 110 * 2;
        }else {
            i = 110 * 3;
        }
        return 93 + size1.height + size.height + i;
    }else {
        CGFloat cellWidth = ScreenWidth - 32;
        NSLog(@"%@",self.dataArrayDongtai[indexPath.row].content);
        NSString *content = [NSString stringWithFormat:@"%@",self.dataArrayDongtai[indexPath.row].content];
        CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:14] Size:CGSizeMake(cellWidth, CGFLOAT_MAX)];
        int i = 0;
        if (self.dataArrayDongtai[indexPath.row].photourl.count == 0) {
            i = 110 * 0;
        }else if (self.dataArrayDongtai[indexPath.row].photourl.count > 0 && self.dataArrayDongtai[indexPath.row].photourl.count < 4) {
            i = 110 * 1;
            
        }else if (self.dataArrayDongtai[indexPath.row].photourl.count > 3 && self.dataArrayDongtai[indexPath.row].photourl.count < 7) {
            i = 110 * 2;
        }else {
            i = 110 * 3;
        }
        return 102 + 20 + size.height + i;
    }
    

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
    if (self.type == 3) {
        ShangjiaNewthreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShangjiaNewthreeTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ShangjiaNewthreeTableViewCell" owner:nil options:nil].firstObject;
        }
        cell.model = self.dataArrayPingjia[indexPath.row];
        return  cell;
    }else {
        DongtaiNewViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DongtaiNewViewTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"DongtaiNewViewTableViewCell" owner:nil options:nil].firstObject;
        }
        @weakify(self);
        [[[cell.dianzanBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self);
//            [self.dianzanUISubject sendNext:self.dataArrayDongtai[indexPath.row]];
//            self.index = indexPath.row;
        }];
//        [[[cell.pinglunBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
//
//            @strongify(self);
////            [self.pinglunseleUISubject sendNext:self.dataArrayDongtai[indexPath.row - 1]];
////            self.index = indexPath.row;
//        }];
        [[cell.selectItemSubject takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.selectItemSubject sendNext:@(indexPath.row)];
        }];
        cell.model = self.dataArrayDongtai[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }

    
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
    if (self.type == 3) {
        return self.dataArrayPingjia.count == 0  && self.dataArrayPingjia;
    }else {
        return self.dataArray.count == 0  && self.dataArray;
    }
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
