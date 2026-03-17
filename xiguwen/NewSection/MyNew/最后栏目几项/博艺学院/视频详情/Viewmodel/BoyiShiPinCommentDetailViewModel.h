//
//  BoyiShiPinCommentDetailViewModel.h
//  BoYi
//
//  Created by zhoumeineng on 3/21/18.
//  Copyright © 2018 hengwu. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "BoyiShiPinDetailModel.h"
typedef void(^ShiPinDetailModelBlock)(BoyiShiPinDetailModel * ShiPinDetailModel);
@interface BoyiShiPinCommentDetailViewModel : NSObject

-(void)Request:(NSDictionary*)param;
@property(nonatomic,strong)ShiPinDetailModelBlock Mblock;
@end
