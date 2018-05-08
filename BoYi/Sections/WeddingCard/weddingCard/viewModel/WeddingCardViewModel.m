//
//  WeddingCardViewModel.m
//  BoYi
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "WeddingCardViewModel.h"
#import "WeddingCardTableViewCell.h"
#import "WeddingCardCollectionViewCell.h"

@implementation WeddingCardViewModel

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
    
    [self.dataArray addObjectsFromArray:[WeddingCardModel mj_objectArrayWithKeyValuesArray:object]];
    
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
            return [[RequestManager sharedManager] RACRequestUrl:URL_findUserInvitaiton
                                                          method:GET
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _refreshDataCommand;
}


#pragma mark - 网络请求
- (RACSignal *)requestSignalWithUrl:(NSString *)url
                            loading:(NSString *)loading
                      Authorization:(NSString *)Authorization
                               info:(NSDictionary *)info {
    
    
    RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        NSURLSessionDataTask *task = [[RequestManager sharedManager] requestUrl:url
                                                                         method:GET
                                                                         loding:loading
                                                                            dic:info
                                                                       progress:nil
                                                                        success:^(NSURLSessionDataTask *task, id response) {
                                                                            //                                                                        if(response) {
                                                                            // 可封装为请求正确，但是校验未通过处理
                                                                            //                                                                            if ([response[@"code"] integerValue] == 1) {
                                                                            //                                                                                [subscriber sendNext:nil];
                                                                            //                                                                                [subscriber sendError:[NSError errorWithDomain:@"com.saitjr.demo" code:1 userInfo:@{@"msg":@"没数据啦"}]];
                                                                            //                                                                                return;
                                                                            //                                                                            } else {
                                                                            [subscriber sendNext:response];
                                                                            [subscriber sendCompleted];
                                                                            //                                                                            }
                                                                            //                                                                        }
                                                                        } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                            // 如果网络请求出错，则加载数据库中的旧数据
                                                                            
                                                                            [subscriber sendError:[NSError errorWithDomain:error.domain code:error.code userInfo:error.userInfo]];
                                                                            [subscriber sendCompleted];
                                                                        }];
        // 在信号量作废时，取消网络请求
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
    //    [requestSignal throttle:1];
    return requestSignal;
}
#pragma mark-DataSource的代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  self.dataArray ? 1 : 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray ? self.dataArray.count : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    WeddingCardModel *model = self.dataArray[indexPath.row];
    
    WeddingCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WeddingCardCollectionViewCell" forIndexPath:indexPath];
    if (model.invitationimg1) {
        [cell.header sd_setImageWithUrl:ImageAppendURL(model.invitationimg1)];
    } else {
        cell.header.image = IMAGE_NAME(@"请柬32px");
    }
    if (model.invitationimg2) {
        [cell.header1 sd_setImageWithUrl:ImageAppendURL(model.invitationimg2)];
    } else {
        cell.header1.image = IMAGE_NAME(@"请柬32px");
    }
//    cell.model = model;
    
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
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    CGFloat x = targetContentOffset->x;
    CGFloat pageWidth = ScreenWidth - 50;
    CGFloat movedX = x - pageWidth * self.selectedIndex;
    //向左
    if (movedX < -pageWidth * 0.5) {
        self.selectedIndex -= 1;
    } else if (movedX > pageWidth * 0.5) {
        self.selectedIndex += 1;
    }
    if (fabs(velocity.x) >= 2) {
        targetContentOffset->x = pageWidth * self.selectedIndex;
    } else {
        targetContentOffset->x = scrollView.contentOffset.x;
        [scrollView setContentOffset:CGPointMake(pageWidth * self.selectedIndex, scrollView.contentOffset.y) animated:YES];
    }
}



#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    
    NSString *text = @"你还没有制作电子喜帖哦";
    
    
    UIFont *font = [UIFont boldSystemFontOfSize:13.0];
    UIColor *textColor = RGBA(202, 202, 202, 1);
    
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}



- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return IMAGE_NAME(@"请柬32px");
}





- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return -49.0;
//}

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
    return NO;
}
@end
