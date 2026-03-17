//
//  AskSuccessViewController.m
//  BoYi
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "AskSuccessViewController.h"
#import "IndexCollectionViewCell.h"
#import "NewPeopleDetilViewController.h"
@interface AskSuccessViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation AskSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"提交成功";
    
    [self addPopBackBtn];
    
//    _collection.delegate = self;
//    _collection.dataSource = self;
//    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
//    [self.collection registerNib:[UINib nibWithNibName:@"IndexCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"IndexCollectionViewCell"];
//    [self get];
    
}
- (void)popViewConDelay{
    [self popViewControllerAtLastIndex:3];
}
-  (void)get{
    NSString *string = [self.idString isBlankString] ? @"" : self.idString;
    [[RequestManager sharedManager] requestUrl:URL_ANLIE_TJ
                                        method:POST
                                        loding:nil
                                           dic:@{@"id":string}
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           
                                           if ([response[@"status"] isEqualToString:@"200"]) {
                                               if (!self.dataArrayTJ) self.dataArrayTJ = [NSMutableArray array];
                                               
                                               [self.dataArrayTJ addObjectsFromArray:[EsarraytjTJ mj_objectArrayWithKeyValuesArray:response[@"r"]]];
                                               [self.collection reloadData];
                                           }
                                           
                                           
                                           
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                           [NavigateManager showMessage:@"提交失败"];
                                           
                                       }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArrayTJ.count;
    
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
    
    EsarraytjTJ *model = self.dataArrayTJ[indexPath.row];
    
    cell.name.text = model.recommendUser.cnName;
    
    [[NSString stringWithFormat:@"%@",model.recommendUser.avatar] isBlankString] ? @"" : [cell.image sd_setImageWithUrl:String(ImageHomeURL,model.recommendUser.avatar) placeHolder:[UIImage imageNamed:@"占位图片"]];
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EsarraytjTJ *model = self.dataArrayTJ[indexPath.row];
    
    NewPeopleDetilViewController *people = [[NewPeopleDetilViewController alloc] init];
    people.userId = [NSString stringWithFormat:@"%ld",model.userId];
    [self pushToNextVCWithNextVC:people];
    
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
