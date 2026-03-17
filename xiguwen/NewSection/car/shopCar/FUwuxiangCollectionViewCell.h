//
//  FUwuxiangCollectionViewCell.h
//  BoYi
//
//  Created by apple on 2017/8/31.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fuwuModel.h"

@interface FUwuxiangCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet IB_DESIGN_View *backView;

@property (nonatomic, strong) Esarrayqw *model;

@end
