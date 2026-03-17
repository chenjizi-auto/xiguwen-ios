//
//  GGListViewController.h
//  BoYi
//
//  Created by apple on 2017/9/6.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGListModel.h"

@interface GGListViewController : FatherViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (strong,nonatomic) NSString *parentId;
@property (strong,nonatomic) NSString *titleName;
@property (strong,nonatomic) NSMutableArray *dataArray;
@end
