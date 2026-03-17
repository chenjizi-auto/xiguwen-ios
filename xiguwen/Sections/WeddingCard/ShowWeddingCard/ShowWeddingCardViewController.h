//
//  ShowWeddingCardViewController.h
//  BoYi
//
//  Created by Chen on 2017/9/3.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "WeddingCardModel.h"

@interface ShowWeddingCardViewController : FatherViewController

@property (assign,nonatomic) NSInteger cardId;
@property (assign,nonatomic) WeddingCardModel *model;
@end
