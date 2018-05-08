//
//  MyDataNewViewModel.m
//  BoYi
//
//  Created by heng on 2018/1/9.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyDataNewViewModel.h"
#import "MyDataNewTableViewCell.h"
#import "HeaderNewTableViewCell.h"
@implementation MyDataNewViewModel

// custom code
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleArray = @[@"头像",@"昵称",@"性别",@"生日",@"年龄",@"身高",@"体重",@"城市",@"联系地址"];
        self.titleKeyArray = @[@"head",@"nickname",@"sex",@"birthday",@"age",@"height",@"weight",@"city",@"address"];
        self.cityKeyArray = @[@"provinceid",@"cityid",@"countyid"];
        self.dicInfo = [NSMutableDictionary dictionary];
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
        //请求成功
        [self.updateDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.updateRequestSubject sendNext:x];
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
    
//    [self.dataArray addObjectsFromArray:[MyDataNewViewModel mj_objectArrayWithKeyValuesArray:object]];
    NSDictionary *info = object;
    for (NSString *key in self.titleKeyArray) {
        NSString *place = @"";
        if (info[key]) {
            place = [NSString stringWithFormat:@"%@",info[key]];
        }
        [self.dicInfo setObject:place forKey:key];
    }
    
    NSMutableArray *cityArray = [NSMutableArray array];
    for (NSString *key in self.cityKeyArray) {
        NSString *place = @"";
        if (info[key]) {
            place = [NSString stringWithFormat:@"%@",info[key]];
            [cityArray addObject:place];
        }
    }
    if (cityArray.count == 3) {
        [self.dicInfo setObject:[cityArray componentsJoinedByString:@","] forKey:@"city"];
    }
    
}


#pragma mark - private

- (RACSubject *)refreshUISubject {
    
    if (!_refreshUISubject) _refreshUISubject = [RACSubject subject];
    
    return _refreshUISubject;
}
- (RACSubject *)updateRequestSubject {
    if (!_updateRequestSubject) {
        _updateRequestSubject = [RACSubject subject];
    }
    return _updateRequestSubject;
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
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/myhome/personaldata"]
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _refreshDataCommand;
}
- (RACCommand *)updateDataCommand {
    
    if (!_updateDataCommand) {
        @weakify(self);
        _updateDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/Myhome/setPersonal"]
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _updateDataCommand;
}
#pragma mark -  tableView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        return 80;
    }else {
        return 50;
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
    if (indexPath.row == 0) {
        
        HeaderNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderNewTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"HeaderNewTableViewCell" owner:nil options:nil].firstObject;
        }
        cell.title.text = self.titleArray[indexPath.row];
        id obj = self.dicInfo[self.titleKeyArray[indexPath.row]];
        if ([obj isKindOfClass:[UIImage class]]) {
            cell.headerImage.image = obj;
        } else {
//        NSString *str = self.dicInfo[self.titleKeyArray[indexPath.row]];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:obj]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else {
        MyDataNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyDataNewTableViewCell"];
        if (!cell)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"MyDataNewTableViewCell" owner:nil options:nil].firstObject;
        }
        cell.title.text = self.titleArray[indexPath.row];
        cell.content.text = self.dicInfo[self.titleKeyArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.selectItemSubject sendNext:@(indexPath.row)];
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
