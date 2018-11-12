//
//  BoyiShiPinNavigatinBar.h
//  BoYi
//
//  Created by zhoumeineng on 3/20/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoyiShiPinDetailModel.h"
typedef NS_ENUM(NSInteger) {
    BackAction=1,
    downLoadAction=2,
    ShareAction=3
}BUTONACTIONTAG;
typedef void(^NavigatinBarBlock)(NSInteger INDEXT,id action);
@interface BoyiShiPinNavigatinBar : UIView
@property(nonatomic,strong)NavigatinBarBlock Mblock;
- (void)setData:(BoyiShiPinDetailModel*)model;
@end
