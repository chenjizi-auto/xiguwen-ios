//
//  AskSuccessViewController.h
//  BoYi
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "FindTJModel.h"

@interface AskSuccessViewController : FatherViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (strong,nonatomic) NSMutableArray <EsarraytjTJ *> *dataArrayTJ;

@property (strong,nonatomic)NSString *idString;
@end
