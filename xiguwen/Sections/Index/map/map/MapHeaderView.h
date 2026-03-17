//
//  MapHeaderView.h
//  BoYi
//
//  Created by apple on 2017/8/17.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapHeaderView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)NSMutableArray *array;

@property (strong, nonatomic) RACSubject *gotoNextVc;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;

- (void)refreshData:(NSMutableArray *)array;
@end
