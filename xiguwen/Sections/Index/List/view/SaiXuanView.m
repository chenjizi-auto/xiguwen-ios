//
//  SaiXuanView.m
//  BoYi
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "SaiXuanView.h"
#import "SaixuanCollectionViewCell.h"
#import "CwDatePiker.h"
@implementation SaiXuanView


- (void)drawRect:(CGRect)rect {
    if (ScreenWidth == 320) {
        
        [self.moneyBtnOne.titleLabel setFont:[UIFont systemFontOfSize: 12.0]];
        [self.moneyBtnTwo.titleLabel setFont:[UIFont systemFontOfSize: 12.0]];
        [self.moneyBtnThree.titleLabel setFont:[UIFont systemFontOfSize: 12.0]];
        [self.moneyBtnFour.titleLabel setFont:[UIFont systemFontOfSize: 12.0]];
        [self.moneyBtnFive.titleLabel setFont:[UIFont systemFontOfSize: 12.0]];
        [self.moneyBtnSix.titleLabel setFont:[UIFont systemFontOfSize: 12.0]];
    }
}


- (IBAction)action:(UIButton *)sender {
    //时间
    self.timeBtnMark.selected = NO;
    sender.selected = YES;
    self.timeBtnMark = sender;
    
    if (sender.tag == 10) {
        [self.dicm setObject:@"" forKey:@"time"];
    }else{
        
        
        __weak typeof(self) weakSelf = self;
        
        [CwDatePiker showInView:weakSelf issele:NO block:^(NSDate *date) {
            
            
            NSString *dateString = [date fs_stringWithFormat:@"yyyy-MM-dd"];
          
            [weakSelf.timeBtn setTitle:dateString forState:UIControlStateNormal];
            [weakSelf.dicm setObject:dateString forKey:@"time"];
        }];
        
    }
}

- (IBAction)piaceAC:(UIButton *)sender {
    //
    self.priceBtnMark.selected = NO;
    sender.selected = YES;
    self.priceBtnMark = sender;
    
    if (sender.tag == 100) {
        [self.dicm setObject:@"1" forKey:@"price"];
    }else if (sender.tag == 101) {
        [self.dicm setObject:@"2" forKey:@"price"];
    }else if (sender.tag == 102) {
        [self.dicm setObject:@"3" forKey:@"price"];
    }else if (sender.tag == 103) {
        [self.dicm setObject:@"4" forKey:@"price"];
    }else if (sender.tag == 104) {
        [self.dicm setObject:@"5" forKey:@"price"];
    }
    
}



+ (SaiXuanView *)showInView:(UIView *)view array:(NSMutableArray *)array block:(void(^)(NSDictionary *dic))block{
    
    SaiXuanView *alert = [[[NSBundle mainBundle]loadNibNamed:@"SaiXuanView" owner:self options:nil]lastObject];
    alert.collection.delegate = alert;
    alert.collection.dataSource = alert;
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [alert.collection registerNib:[UINib nibWithNibName:@"SaixuanCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SaixuanCollectionViewCell"];
    NSDictionary *dic = @{@"time":@"",@"price":@"",@"address":@""};
    alert.dicm = [[NSMutableDictionary alloc] initWithDictionary:dic];
    alert.array = array;
    alert.frame = view.frame;
    alert.block = block;
    [alert showOnView:view];
    [alert.collection reloadData];
    return alert;
    
}


- (IBAction)cancle:(UIButton *)sender {
    [self hidden];
    
}
- (IBAction)sure:(UIButton *)sender {
    if (self.block) {
        self.block(self.dicm);
    }
    [self hidden];
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

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count > 0 ? self.array.count : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //重用cell
    SaixuanCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SaixuanCollectionViewCell" forIndexPath:indexPath];
    cell.dic = self.array[indexPath.row];
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    for (int i = 0; i < self.array.count; i ++) {
        
        if ([self.array[i][@"isSele"] isEqualToString:@"1"]) {
            
            self.array[i][@"isSele"] = @"0";
            
        }
        
        
    }
    
    self.array[indexPath.row][@"isSele"] = @"1";
    
    [self.dicm setObject:_array[indexPath.row][@"area"] forKey:@"address"];
    [self.collection reloadData];
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((ScreenWidth - 47 - 30) / 3  ,40);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (void)dealloc{
    NSLog(@"销毁");
}

@end
