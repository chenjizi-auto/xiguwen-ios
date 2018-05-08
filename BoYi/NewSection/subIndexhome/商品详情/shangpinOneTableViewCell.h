//
//  shangpinOneTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/4/13.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shangpinnewModel.h"


@interface shangpinOneTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (strong, nonatomic) shangpinnewModel *model;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionAddress;
@end
