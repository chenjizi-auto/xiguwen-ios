//
//  TwoTableViewCell.m
//  BoYi
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "TwoTableViewCell.h"
#import "IndexCollectionViewCell.h"

@implementation TwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _collection.delegate = self;
    _collection.dataSource = self;
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [self.collection registerNib:[UINib nibWithNibName:@"IndexCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"IndexCollectionViewCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataArrayTJ.count > 6) {
        return 6;
    }
    return self.dataArrayTJ.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //重用cell
    IndexCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IndexCollectionViewCell" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"IndexCollectionViewCell" owner:nil options:nil].firstObject;
    }
    EsarraytjTJ *model = self.dataArrayTJ[indexPath.row];
    
    cell.name.text = model.recommendUser.cnName;
    
    [[NSString stringWithFormat:@"%@",model.recommendUser.avatar] isBlankString] ? @"" : [cell.image sd_setImageWithUrl:String(ImageHomeURL,model.recommendUser.avatar) placeHolder:[UIImage imageNamed:@"占位图片"]];
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EsarraytjTJ *model = self.dataArrayTJ[indexPath.row];
    [self.selectItemSubject sendNext:@(model.userId)];
    
}

- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (ScreenWidth == 320) {
        
        return CGSizeMake(86,86 + 35);
        
    }else if (ScreenWidth == 375) {
        
        return CGSizeMake(100,100 + 35);
        
    }else {
        return CGSizeMake(110,110 + 35);
    }
    
}
////定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

@end
