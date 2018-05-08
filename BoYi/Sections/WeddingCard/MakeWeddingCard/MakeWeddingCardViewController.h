//
//  MakeWeddingCardViewController.h
//  BoYi
//
//  Created by Chen on 2017/9/3.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "WeddingCardModel.h"

@interface MakeWeddingCardViewController : FatherViewController

@property (assign,nonatomic) NSInteger cardId;
@property (strong,nonatomic) WeddingCardModel *model;
@end
