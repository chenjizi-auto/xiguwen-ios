//
//  ShiPinMoreViewModel.m
//  BoYi
//
//  Created by zhoumeineng on 3/20/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "ShiPinMoreViewModel.h"
#import "BoyiShiPinCollectionViewCell.h"
#import "BoyiShiPinModel.h"
#import "BoyiShiPinDetailsViewController.h"
@interface ShiPinMoreViewModel()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation ShiPinMoreViewModel
{
    @private
    NSArray<BoyiShiPinModel*> * dataSources;
    UICollectionView * collect;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self);
        [[self.command executing] subscribeNext:^(NSNumber * _Nullable x) {
            @strongify(self);
        }];
        [self.command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            @strongify(self);
             [self.Subject sendNext:x];
        }];
    }
    return self;
}
- (RACSubject *)Subject{
    if (!_Subject) {
        _Subject = [RACSubject subject];
    }
    return _Subject;
}
- (RACCommand *)command{
    if (!_command) {
        _command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/Boyicollege/collegevideolistall"] method:POST loding:@"加载中..." dic:input];
        }];
    }
    return _command;
}

- (void)Request:(NSDictionary *)param
{
    [self.command execute:param];
    [self.Subject subscribeNext:^(id  _Nullable x) {
        dataSources = [BoyiShiPinModel mj_objectArrayWithKeyValuesArray:x];
        [collect reloadData];
    }];
    
}

#pragma  ------------------ collectView Delegate dataSource ---------------------
- (void)MesaageDelegate:(UICollectionView*)objc{
    [objc registerNib:[UINib nibWithNibName:@"BoyiShiPinCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    objc.delegate = self;
    objc.dataSource = self;
    collect = objc;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataSources.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BoyiShiPinCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BoyiShiPinCollectionViewCell" owner:self options:nil].firstObject;
    }
    [cell data:dataSources[indexPath.row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BoyiShiPinDetailsViewController*vc = [[BoyiShiPinDetailsViewController alloc]init];
    vc.model=dataSources[indexPath.row];
    [((UIViewController*)self.object).navigationController pushViewController:vc animated:YES];
    
}
@end
