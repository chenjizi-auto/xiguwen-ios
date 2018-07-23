//
//  DangqiKaViewController.h
//  BoYi
//
//  Created by heng on 2018/1/19.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"

@interface DangqiKaViewController : FatherViewController
//@property (weak, nonatomic) IBOutlet UICollectionView *collection;

///YES:分享图片、NO:分享链接
@property (nonatomic,unsafe_unretained) BOOL shareImage;

@end
