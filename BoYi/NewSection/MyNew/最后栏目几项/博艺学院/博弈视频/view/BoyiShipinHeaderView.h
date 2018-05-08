//
//  BoyiShipinHeaderView.h
//  BoYi
//
//  Created by heng on 2018/1/23.
//  Copyright © 2018年 hengwu. All rights reserved.
//

typedef void(^HeaderBlock)(NSString*);
#import <UIKit/UIKit.h>
@interface BoyiShipinHeaderView : UIView
- (void)headText:(NSIndexPath*)indext;
@property(nonatomic,strong)HeaderBlock Mblock;
@end
