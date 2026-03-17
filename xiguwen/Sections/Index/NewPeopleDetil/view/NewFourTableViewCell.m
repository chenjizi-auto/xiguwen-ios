//
//  NewFourTableViewCell.m
//  BoYi
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "NewFourTableViewCell.h"
#import "TeamCollectionViewCell.h"
@implementation NewFourTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.reamArray = [NSMutableArray array];
    
    self.teamCollection.delegate = self;
    self.teamCollection.dataSource = self;
    [self.teamCollection registerNib:[UINib nibWithNibName:@"TeamCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TeamCollectionViewCell"];
    self.teamCollection.showsVerticalScrollIndicator = FALSE;
    self.teamCollection.showsHorizontalScrollIndicator = FALSE;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(peopleDetailModel *)model{
    _model = model;
    [self.teamCollection reloadData];
}

- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
#pragma mark - collection

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.recommendUsers.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    TeamCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TeamCollectionViewCell" forIndexPath:indexPath];
    
    cell.name.text = self.model.recommendUsers[indexPath.row].recommendUser.cnName;
    cell.zhiwei.text = self.model.recommendUsers[indexPath.row].recommendUser.bizWork.name;
    [cell.image sd_setImageWithUrl:ImageAppendURL(self.model.recommendUsers[indexPath.row].recommendUser.avatar) placeHolder:[UIImage imageNamed:@"头像"]];
    
    return cell;
    
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.userId = [NSString stringWithFormat:@"%ld",self.model.recommendUsers[indexPath.row].recommendUser.id];
    [self.selectItemSubject sendNext:self.userId];
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (ScreenWidth == 320) {
        
        return CGSizeMake(90,90 + 33);
        
    }else if (ScreenWidth == 375) {
        
        return CGSizeMake(100,100 + 33);
        
    }else {
        return CGSizeMake(110,110 + 33);
    }
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

@end
