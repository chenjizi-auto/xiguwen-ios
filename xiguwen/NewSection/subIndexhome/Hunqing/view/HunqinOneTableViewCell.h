//
//  HunqinOneTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/26.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizontalPageableLayout.h"
#import "fenLeiModel.h"
@interface HunqinOneTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

//属性
@property (weak, nonatomic) IBOutlet HorizontalPageableLayout *layout;
// xib

@property (weak, nonatomic) IBOutlet UICollectionView *collectionAddress;
@property (strong,nonatomic)NSMutableArray *fuwuArray;
@property (weak, nonatomic) IBOutlet UIPageControl *page;
@property (assign, nonatomic) NSInteger buNumber;

@property (nonatomic, strong) RACSubject *selectItemSubject;
@end
