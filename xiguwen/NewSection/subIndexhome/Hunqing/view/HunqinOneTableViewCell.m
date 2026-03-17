//
//  HunqinOneTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/26.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunqinOneTableViewCell.h"
#import "BtnCollectionViewCell.h"
#import "BtnJiaCollectionViewCell.h"
@implementation HunqinOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionAddress.delegate = self;
    self.collectionAddress.dataSource = self;
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"BtnCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BtnCollectionViewCell"];
    [self.collectionAddress registerNib:[UINib nibWithNibName:@"BtnJiaCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BtnJiaCollectionViewCell"];
    
    self.collectionAddress.bounces = NO;
    self.collectionAddress.showsVerticalScrollIndicator = FALSE;
    self.collectionAddress.showsHorizontalScrollIndicator = FALSE;
    //    self.collectionAddress.contentSize = CGSizeMake(ScreenWidth * 2, 80);
    self.collectionAddress.pagingEnabled = YES;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.buNumber = 0;
    self.layout.itemCountPerRow = 5;
    self.layout.rowCount = 2;
    self.fuwuArray = [NSMutableArray array];
}
- (void)setFuwuArray:(NSMutableArray *)fuwuArray{
    _fuwuArray = fuwuArray;
    if (_fuwuArray.count == 0) {
        return;
    }
    
    if (_fuwuArray.count % 10 == 0) {
        self.buNumber =  0;
    }else {
        self.buNumber =  10 - (_fuwuArray.count % 10);
    }
    
    if (_fuwuArray.count % 10 == 0) {
        self.page.numberOfPages = _fuwuArray.count / 10;
    }else {
        self.page.numberOfPages = _fuwuArray.count / 10 + 1;
    }
    [self.collectionAddress reloadData];
}

#pragma mark - collection
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return self.fuwuArray.count + self.buNumber ;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row > self.fuwuArray.count - 1) {
        
        return ;
    }
    Fenleiarray *model = [[Fenleiarray alloc] init];
    model = self.fuwuArray[indexPath.row];
    [self.selectItemSubject sendNext:model];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > self.fuwuArray.count - 1) {
        //重用cell
        BtnJiaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BtnJiaCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
    //重用cell
    BtnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BtnCollectionViewCell" forIndexPath:indexPath];
    Fenleiarray *model = [[Fenleiarray alloc] init];
    model = self.fuwuArray[indexPath.row];
    
    if ([[NSString stringWithFormat:@"%@",model.proname] isBlankString]) {//商城
        if (model.occupationid != 10000) {
            
            [cell.imagewh sd_setImageWithUrl:model.wapimg placeHolder:[UIImage imageNamed:@"占位图片"]];
            cell.title.text = model.wapname;
        }else {
            cell.imagewh.image = [UIImage imageNamed:@"分类1"];
            cell.title.text = @"分类";
        }
    }else {
        if (model.occupationid != 10000) { //婚庆
            
            cell.title.text = model.proname;
            [cell.imagewh sd_setImageWithUrl:model.wapimg placeHolder:[UIImage imageNamed:@"占位图片"]];
            
        }else {
            cell.imagewh.image = [UIImage imageNamed:@"分类"];
            cell.title.text = @"分类";
        }
    }
    
    return cell;
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth / 5,80);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return 0;
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 修改分页控件控件当前指示
    self.page.currentPage = _collectionAddress.contentOffset.x / CGRectGetWidth(scrollView.bounds);
    NSLog(@"%f",_collectionAddress.contentOffset.x);
    NSLog(@"%ld",self.page.currentPage);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
