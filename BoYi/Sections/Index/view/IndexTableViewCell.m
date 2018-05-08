//
//  IndexTableViewCell.m
//  BoYi
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "IndexTableViewCell.h"
#import "IndexCollectionViewCell.h"
@implementation IndexTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _collection.delegate = self;
    _collection.dataSource = self;
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [self.collection registerNib:[UINib nibWithNibName:@"IndexCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"IndexCollectionViewCell"];
   
}

//点击行数
- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}

- (void)zhong{
    [self.zhongBtn setTitleColor:RGBA(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.zhongBtn setBackgroundColor:RGBA(255, 110, 149, 1)];
    [self.hanBtn setTitleColor:RGBA(201, 205, 210, 1) forState:UIControlStateNormal];
    [self.hanBtn setBackgroundColor:RGBA(255, 255, 255, 1)];
    [self.huaBtn setTitleColor:RGBA(201, 205, 210, 1) forState:UIControlStateNormal];
    [self.huaBtn setBackgroundColor:RGBA(255, 255, 255, 1)];
}
- (void)han{
    [self.hanBtn setTitleColor:RGBA(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.hanBtn setBackgroundColor:RGBA(255, 110, 149, 1)];
    [self.zhongBtn setTitleColor:RGBA(201, 205, 210, 1) forState:UIControlStateNormal];
    [self.zhongBtn setBackgroundColor:RGBA(255, 255, 255, 1)];
    [self.huaBtn setTitleColor:RGBA(201, 205, 210, 1) forState:UIControlStateNormal];
    [self.huaBtn setBackgroundColor:RGBA(255, 255, 255, 1)];
}
- (void)hua{
    [self.huaBtn setTitleColor:RGBA(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.huaBtn setBackgroundColor:RGBA(255, 110, 149, 1)];
    [self.zhongBtn setTitleColor:RGBA(201, 205, 210, 1) forState:UIControlStateNormal];
    [self.zhongBtn setBackgroundColor:RGBA(255, 255, 255, 1)];
    [self.hanBtn setTitleColor:RGBA(201, 205, 210, 1) forState:UIControlStateNormal];
    [self.hanBtn setBackgroundColor:RGBA(255, 255, 255, 1)];
}
- (void)setModel:(IndexModel *)model{
    _model = model;
    
    if (model.children.count == 0) {
        self.collectgionHeight.constant = 0;
    }else if (model.children.count < 4) {
        self.collectgionHeight.constant = 150;
    }else {
        self.collectgionHeight.constant = 300;
    }
    if (model.children.count > 0) {
        
        if ([[UserData UserDefaults:@"index_mark_indexRow"] isEqualToString:@"0"]) {
            
            if ([[UserData UserDefaults:@"index_one"] isEqualToString:@"2"]) {
                [self han];
                
            }else if ([[UserData UserDefaults:@"index_one"] isEqualToString:@"3"]) {
                
                [self hua];
            }else {
                [self zhong];
            }
            
        }else if ([[UserData UserDefaults:@"index_mark_indexRow"] isEqualToString:@"1"]) {
            
            if ([[UserData UserDefaults:@"index_two"] isEqualToString:@"2"]) {
                [self han];
                
            }else if ([[UserData UserDefaults:@"index_two"] isEqualToString:@"3"]) {
                
                [self hua];
            }else {
                [self zhong];
            }
            
        }else if ([[UserData UserDefaults:@"index_mark_indexRow"] isEqualToString:@"2"]) {
            
            if ([[UserData UserDefaults:@"index_three"] isEqualToString:@"2"]) {
                [self han];
                
            }else if ([[UserData UserDefaults:@"index_three"] isEqualToString:@"3"]) {
                
                [self hua];
            }else {
                [self zhong];
            }
            
        }else if ([[UserData UserDefaults:@"index_mark_indexRow"] isEqualToString:@"3"]) {
            
            if ([[UserData UserDefaults:@"index_four"] isEqualToString:@"2"]) {
                [self han];
                
            }else if ([[UserData UserDefaults:@"index_four"] isEqualToString:@"3"]) {
                
                [self hua];
            }else {
                [self zhong];
            }
            
        }else {
            
            if ([[UserData UserDefaults:@"index_five"] isEqualToString:@"2"]) {
                [self han];
                
            }else if ([[UserData UserDefaults:@"index_five"] isEqualToString:@"3"]) {
                
                [self hua];
            }else {
                [self zhong];
            }
            
        }
  
    }
    
    [UserData ClearUserDefaults:@"index_mark_indexRow"];
    [self.collection reloadData];
}

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.model.children) {
        if (self.model.children.count > 6) {
            return 6;
        }
        return self.model.children.count;
    }else {
        return 0;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //重用cell
    IndexCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IndexCollectionViewCell" forIndexPath:indexPath];
    
    if (ScreenWidth == 320) {
        
        cell.imageWidth.constant = 86;
        
    }else if (ScreenWidth == 375) {
        
        cell.imageWidth.constant = 100;
        
    }else {
        cell.imageWidth.constant = 110;
    }
    

    cell.name.text = self.model.children[indexPath.row].name;
    
//    [cell.image sd_setImageWithURL:URL(model.avatar)];
    [cell.image sd_setImageWithURL:URL(String(ImageHomeURL,self.model.children[indexPath.row].imgUrl))];
    
    
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    [self.selectItemSubject sendNext:self.model.children[indexPath.row]];
    
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
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
//}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
@end
