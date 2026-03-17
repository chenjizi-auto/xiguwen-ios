//
//  ShopCarList.m
//  BoYi
//
//  Created by apple on 2017/9/1.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShopCarList.h"
#import "ShopCarlistTableViewCell.h"
#import "ShopCarListModel.h"

@implementation ShopCarList

+ (ShopCarList *)showInView:(UIView *)view dic:(NSMutableDictionary *)dic block:(void(^)(NSDictionary *dic))block{
    
    ShopCarList *alert = [[[NSBundle mainBundle]loadNibNamed:@"ShopCarList" owner:self options:nil]lastObject];
    alert.table.delegate = alert;
    alert.table.dataSource = alert;
    alert.table.emptyDataSetDelegate = alert;
    alert.table.emptyDataSetSource   = alert;
    [alert.table registerNib:[UINib nibWithNibName:@"ShopCarlistTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShopCarlistTableViewCell"];
    alert.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    alert.dataArray = [[NSMutableArray alloc] init];
    alert.frame = view.frame;
    alert.zongDingjinStr = 0;
    alert.zongjiageStr = 0;
    alert.block = block;
    alert.dicm = [[NSMutableDictionary alloc] init];
    [alert getData];
    [alert showOnView:view];
    
    return alert;
    
}

- (void)getData{
    
    NSLog(@"%@",@([UserData sharedManager].userInfoModel.id));
    
    [[RequestManager sharedManager] requestUrl:URL_SHOPCARLIST
                                        method:POST
                                        loding:@""
                                           dic:@{@"userId":@([UserData sharedManager].userInfoModel.id)}
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
            
                                           [self.dataArray addObjectsFromArray:[ShopCarListModel mj_objectArrayWithKeyValuesArray:response[@"r"]]];
                                        
                                           for (int i = 0; i < self.dataArray.count; i ++) {
                                               ShopCarListModel *model = self.dataArray[i];
                                               
                                               model.isSele = YES;
                                           }
                                           
                                           [self fujiage];
                                           
                                           [NavigateManager hiddenLoadingMessage];
                                           [self.table reloadData];
                                           
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                           [NavigateManager showMessage:@"添加失败"];
                                           
                                       }];
}

- (void)fujiage{
    _zongjiageStr = 0;
    _zongDingjinStr = 0;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.dataArray.count; i ++) {
        
        ShopCarListModel *model = self.dataArray[i];
        if (model.isSele) {
            _zongjiageStr = model.product.currentPrice * model.amount + _zongjiageStr;
            
            _zongDingjinStr = (float)model.product.currentPrice * model.amount * model.product.deposit / 100 + _zongDingjinStr;
            [array addObject:[NSString stringWithFormat:@"%ld",(long)model.id]];
        }
    }
    NSString *string = [array componentsJoinedByString:@","];
    [self.dicm setObject:string forKey:@"id"];
    
    self.zongdingjin.text = [NSString stringWithFormat:@"¥ %.2f",_zongDingjinStr];
    self.zongjiage.text = [NSString stringWithFormat:@"¥ %ld",_zongjiageStr];
}

//确定
- (IBAction)sureAC:(UIButton *)sender {
    
    if (sender.tag == 20) {
        
        if (self.dataArray.count == 0 || !self.dataArray) {
            [NavigateManager showMessage:@"购物车空空如也"];
            return;
        }
        BOOL isXuanze = false;
        for (int i = 0; i < self.dataArray.count; i ++) {
            ShopCarListModel *model = self.dataArray[i];
            if (model.isSele) {
                isXuanze = model.isSele;
            }
        }

        if (!isXuanze) {
            [NavigateManager showMessage:@"请选择一项商品"];
            return;
        }
        
        
        if (self.block) {
            [self.dicm setObject:[NSString stringWithFormat:@"%ld",self.zongjiageStr] forKey:@"quankuan"];
            [self.dicm setObject:[NSString stringWithFormat:@"%.2f",(float)self.zongDingjinStr] forKey:@"dingjin"];
            self.block(self.dicm);
        }
        [self hidden];
    }else {//取消
        [self hidden];
    }
    
}
- (void) hidden{
    self.transform = CGAffineTransformIdentity;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 0.01;
        weakSelf.bgView.alpha = 0.01;
        //        weakSelf.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}
- (void)showOnView:(UIView *)view{
    self.alpha = 0.01;
    self.bgView.alpha = 0.01;
    self.transform = CGAffineTransformIdentity;
    self.transform = CGAffineTransformMakeScale(2.5, 2.5);
    [view addSubview:self];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 1;
        weakSelf.bgView.alpha = 1;
        weakSelf.transform = CGAffineTransformIdentity;
    }];
}



#pragma mark -  tableView 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

  return self.dataArray.count > 0 ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 105;
    
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
    
    ShopCarlistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopCarlistTableViewCell"];
    ShopCarListModel *model = self.dataArray[indexPath.row];
    
//    @weakify(self);
//    [[[cell.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        
//        @strongify(self);
//
//        model.amount ++;
//        [self fujiage];
//        [self.table reloadData];
//        
//    }];
//    [[[cell.jianBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        
//        @strongify(self);
//        if (model.amount > 1) {
//
//            model.amount --;
//            [self fujiage];
//            [self.table reloadData];
//        }
//    }];
    cell.model = model;
    return  cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        
        ShopCarListModel *model = self.dataArray[indexPath.row];
        [[RequestManager sharedManager] requestUrl:URL_DELESHOPCAR
                                            method:POST
                                            loding:@""
                                               dic:@{@"trolleyId":@(model.id)}
                                          progress:nil
                                           success:^(NSURLSessionDataTask *task, id response) {
                                               
                                                [NavigateManager hiddenLoadingMessage];
                                               [self.dataArray removeObjectAtIndex:indexPath.row];
//                                                [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationNone];

                                               [self.table reloadData];
                                               [self fujiage];
                                               
                                               self.zongdingjin.text = [NSString stringWithFormat:@"¥ %ld",_zongjiageStr];
                                               self.zongjiage.text = [NSString stringWithFormat:@"¥ %ld",_zongjiageStr];

                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                               
                                               [NavigateManager showMessage:@"删除失败"];
                                               
                                           }];
        
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self.selectItemSubject sendNext:self.dataArray[indexPath.row]];
    ShopCarListModel *model =  self.dataArray[indexPath.row];
    if (model.isSele) {
        _zongjiageStr = _zongjiageStr - model.product.currentPrice * model.amount;
        _zongDingjinStr = _zongDingjinStr - (float)model.product.currentPrice * model.amount * model.product.deposit / 100;
    }else {
        _zongjiageStr = _zongjiageStr + model.product.currentPrice * model.amount;
        _zongDingjinStr = _zongDingjinStr + (float)model.product.currentPrice * model.amount * model.product.deposit / 100;
    }
    model.isSele = !model.isSele;
    [self fujiage];
    [_table reloadData];
}
#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    
    NSString *text = @"暂无商品";
    
    
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
    return NO;
}

- (void)dealloc{
    
}

@end
