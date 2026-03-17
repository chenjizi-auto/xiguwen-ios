//
//  HunqinFourTuanduiTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/26.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunqinFourTuanduiTableViewCell.h"

@implementation HunqinFourTuanduiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.hotCollection.delegate = self;
    self.hotCollection.dataSource = self;
    [self.hotCollection registerNib:[UINib nibWithNibName:@"HotnewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HotnewCollectionViewCell"];
}
- (void)setTuandui:(Rementuandui *)tuandui{
    if (tuandui.data.count != 0) {
        self.hotArray = [NSMutableArray arrayWithArray:tuandui.data];
        [self.hotCollection reloadData];
    }
}

- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}

#pragma mark - collection

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.hotArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    HotnewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotnewCollectionViewCell" forIndexPath:indexPath];
    
    Datatwo *model = [[Datatwo alloc] init];
    model = self.hotArray[indexPath.row];
    cell.name.text = model.title;
    [cell.imagewu sd_setImageWithUrl:model.wapimg placeHolder:[UIImage imageNamed:@"占位图片"]];
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    [self.selectItemSubject sendNext:self.hotArray[indexPath.row]];
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth - 60)/3,110);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 0, 10, 8);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
