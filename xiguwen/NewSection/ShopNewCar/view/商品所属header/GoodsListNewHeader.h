//
//  GoodsListNewHeader.h
//  BoYi
//
//  Created by heng on 2018/1/6.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsListNewHeader : UIView


@property (weak, nonatomic) IBOutlet UILabel *zhiwei;
@property (weak, nonatomic) IBOutlet UIImageView *isGouImage;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic) RACSubject *gotoNextVc;
@end
