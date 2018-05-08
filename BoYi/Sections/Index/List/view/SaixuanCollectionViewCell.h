//
//  SaixuanCollectionViewCell.h
//  BoYi
//
//  Created by apple on 2017/8/16.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaixuanCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet IB_DESIGN_View *backView;

@property (nonatomic, strong) NSDictionary *dic;

@end
