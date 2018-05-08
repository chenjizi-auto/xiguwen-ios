//
//  shangpinShopCar.m
//  BoYi
//
//  Created by heng on 2017/12/24.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "shangpinShopCar.h"
#import "shangpinCarCollectionViewCell.h"

@implementation shangpinShopCar

+ (shangpinShopCar *)showInView:(UIView *)view dic:(shangpinnewModel *)dic block:(void(^)(NSDictionary *dic))block{
    
    shangpinShopCar *alert = [[[NSBundle mainBundle]loadNibNamed:@"shangpinShopCar" owner:self options:nil]lastObject];
    alert.model = dic;
    alert.id = 0;
    alert.hotCollection.delegate = alert;
    alert.hotCollection.dataSource = alert;
    alert.dataArray = [NSMutableArray array];

    for (int i = 0; i < dic.guige.datas.count; i ++) {
        
        NSMutableArray *ar1 = [NSMutableArray array];
        NSMutableArray *cunchuErji = [NSMutableArray array];
        NSString *sku1name,*sku2name,*id;
        ar1 = dic.guige.datas[i];
        for (int j = 0; j < ar1.count; j ++) {
            sku1name = ar1[j][@"sku1name"];
            sku2name = ar1[j][@"sku2name"];
            id = ar1[j][@"id"];
            mingxi *mdoel = [[mingxi alloc] init];
            mdoel.sku1name = sku1name;
            mdoel.sku2name = sku2name;
            mdoel.isSele = NO;
            mdoel.id = id;
            [cunchuErji addObject:mdoel];
        }
  
        
        
        mashuModel *model = [[mashuModel alloc] init];
        model.array = cunchuErji;
        if (i == 0) {
            model.issele = YES;
        }else{
            model.issele = NO;
        }
        [alert.dataArray addObject:model];
    }
    [alert.hotCollection registerNib:[UINib nibWithNibName:@"shangpinCarCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"shangpinCarCollectionViewCell"];
    alert.collection.delegate = alert;
    alert.collection.dataSource = alert;
    [alert.collection registerNib:[UINib nibWithNibName:@"shangpinCarCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"shangpinCarCollectionViewCell"];
    alert.name.text = dic.shangpin.shopname;
    [alert.headerImage sd_setImageWithUrl:dic.shangpin.shopimg[0] placeHolder:[UIImage imageNamed:@"占位图片"]];
    alert.price.text = dic.shangpin.price;
    alert.priceNUmber = 1;

    NSDictionary *dicc = @{@"skuid":@"",@"number":@"1",@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
    alert.dicm = [[NSMutableDictionary alloc] initWithDictionary:dicc];
    
    alert.frame = view.frame;
    alert.block = block;
    [alert showOnView:view];
    return alert;
    
}


- (IBAction)jiajianAC:(UIButton *)sender {
    if (sender.tag == 200) {
        
        self.priceNUmber ++;
        
    }else { //减
        self.priceNUmber > 1 ? self.priceNUmber -- : self.priceNUmber;
        
    }
    self.number.text = [NSString stringWithFormat:@"%d",self.priceNUmber];
    
    [self.dicm setObject:[NSString stringWithFormat:@"%d",self.priceNUmber] forKey:@"number"];
}
//确定
- (IBAction)sureAC:(UIButton *)sender {
    sender.enabled = NO;
    if (sender.tag == 20) {
        if (self.id == 0) {
            [NavigateManager showMessage:@"请选择尺码"];
            sender.enabled = YES;
            return;
        }
        [self.dicm setObject:@(self.id) forKey:@"skuid"];
        if (self.block) {
            self.block(self.dicm);
        }
        [self hidden];
        
        
    }else {//取消
        [self hidden];
    }
    
}
- (IBAction)hiAc:(UIButton *)sender {
    [self hidden];
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
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.collection) {
      
        return self.dataArray[self.index].array.count;
    }
    return self.dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    if (collectionView == self.collection) {
        
        shangpinCarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shangpinCarCollectionViewCell" forIndexPath:indexPath];
        mingxi *mdoel = self.dataArray[self.index].array[indexPath.row];
        cell.name.text = mdoel.sku2name;
        if (mdoel.isSele) {
            cell.vieww.backgroundColor = MAINCOLOR;
            cell.name.textColor = [UIColor whiteColor];
        }else {
            cell.vieww.backgroundColor = RGBA(240, 240, 240, 1);
            cell.name.textColor = RGBA(37, 37, 37, 1);
        }
        return cell;
    }
    shangpinCarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shangpinCarCollectionViewCell" forIndexPath:indexPath];

    NSString *name = self.dataArray[indexPath.row].array[0].sku1name;
    cell.name.text = name;
    mashuModel *model = self.dataArray[indexPath.row];
    if (model.issele) {
        cell.vieww.backgroundColor = MAINCOLOR;
        cell.name.textColor = [UIColor whiteColor];
    }else {
        cell.vieww.backgroundColor = RGBA(240, 240, 240, 1);
        cell.name.textColor = RGBA(37, 37, 37, 1);
    }
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.collection) {
        
        NSString *strid = self.dataArray[self.index].array[indexPath.row].id;
        for (int i = 0; i < self.dataArray[self.index].array.count; i ++) {
            self.dataArray[self.index].array[i].isSele = NO;
        }
        self.dataArray[self.index].array[indexPath.row].isSele = YES;
        self.id = [strid integerValue];
        [self.collection reloadData];
    }else {
        self.index = indexPath.row;
        for (int i = 0; i < self.dataArray.count; i ++) {
            self.dataArray[i].issele = NO;
        }
        self.dataArray[indexPath.row].issele = YES;
        [self.hotCollection reloadData];
        [self.collection reloadData];
    }

    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.collection) {
        
        return CGSizeMake(40,30);
    }
    return CGSizeMake(60,30);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 0, 10, 10);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


@end

