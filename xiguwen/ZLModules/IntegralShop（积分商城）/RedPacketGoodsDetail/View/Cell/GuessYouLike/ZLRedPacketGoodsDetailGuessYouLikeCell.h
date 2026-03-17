//
//  ZLGuessYouLikeGoodsGuessYouLikeCell.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/22.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLRedPacketGoodsDetailCell.h"

@protocol ZLRedPacketGoodsDetailGuessYouLikeCellDelgate

///查看详情
- (void)lookDetailWithModel:(ZLRedPacketGoodsDetailModel *)model;

@end

@interface ZLRedPacketGoodsDetailGuessYouLikeCell : ZLRedPacketGoodsDetailCell

@end
