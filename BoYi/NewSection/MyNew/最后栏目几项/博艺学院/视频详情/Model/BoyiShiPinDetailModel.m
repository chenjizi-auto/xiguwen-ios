//
//  BoyiShiPinDetailModel.m
//  BoYi
//
//  Created by zhoumeineng on 3/21/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "BoyiShiPinDetailModel.h"

@implementation BoyiShiPinDetailModel
- (void)setCommentlist:(NSArray *)commentlist
{
    self.commentModelist = [BoyiShiPinCommentDetailModel mj_objectArrayWithKeyValuesArray:commentlist];
    
}
@end


@implementation BoyiShiPinXiaJiCommentDetailModel

@end

@implementation BoyiShiPinCommentDetailModel 
 - (void)setXiaji:(NSArray *)xiaji
{
    self.XiaJiCommentModelList = [BoyiShiPinXiaJiCommentDetailModel mj_objectArrayWithKeyValuesArray:xiaji];
    
    __block CGFloat cellHeight = 0;
    [self.XiaJiCommentModelList enumerateObjectsUsingBlock:^(BoyiShiPinXiaJiCommentDetailModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        /**
         * 10 头像左侧间距
         * 10 头像右侧Table间距
         * 40 头像大小
         * 10 Table  右侧间距
         * 8  Tbale 中 cell 中文字 左侧间距
         * 8 Tbale 中 cell 中文字 右侧间距
         */
      CGSize size = [obj.comm boundingRectWithSize:CGSizeMake(ScreenWidth - 86, LONG_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        obj.CellCommenHeight = size.height+16;
        cellHeight =  cellHeight + obj.CellCommenHeight;
    }];
    self.CellCommenOnCommenListHeight = cellHeight;
}

- (void)setComm:(NSString *)comm{
    
    _comm = comm;
    /**
     * 10 头像左侧间距
     * 10 头像右侧Table间距
     * 40 头像大小
     * 10 评论  右侧间距
     */
    CGSize size = [comm boundingRectWithSize:CGSizeMake(ScreenWidth - 70, LONG_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    /**
     * 10 头像上间距
     * 40 头像大小
     * 10 头像距离 评论 间距
     * 10 评论 距离 评论我的评论 间距
     * 5  评论我的评论 距离视图底部的距离
     */
    self.CellCommenAndHeadHeight = size.height + 10+ 40+10+10+5;
}

@end
