//
//  IndexTableViewCell.h
//  BoYi
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexModel.h"



@interface IndexTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

//属性
@property (strong,nonatomic) IndexModel *model;

// xib
@property (weak, nonatomic) IBOutlet UIButton *zhongBtn;
@property (weak, nonatomic) IBOutlet UIButton *hanBtn;
@property (weak, nonatomic) IBOutlet UIButton *huaBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectgionHeight;
@property (weak, nonatomic) IBOutlet UILabel *hotName;

@property (nonatomic, strong) RACSubject *selectItemSubject;


@end
