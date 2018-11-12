//
//  BoyiShiPinDetailModel.h
//  BoYi
//
//  Created by zhoumeineng on 3/21/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface BoyiShiPinXiaJiCommentDetailModel : NSObject

/**
 * 评论
 */
@property(nonatomic,copy)NSString * comm;


@property(nonatomic,copy)NSString * nickname;


@property(nonatomic,assign)NSInteger  pid;

@property(nonatomic,assign)CGFloat CellCommenHeight;

@end

#pragma 评论
@interface BoyiShiPinCommentDetailModel : NSObject
/**
 * 评论
 */
@property(nonatomic,copy)NSString * comm;

/**
 * 创建时间
 */
@property(nonatomic,copy)NSString * create_ti;

/**
 * 头像
 */
@property(nonatomic,copy)NSString * head;


/**
 * 用户id
 */
@property(nonatomic,assign)NSInteger  id;


/**
 * 昵称
 */
@property(nonatomic,copy)NSString * nickname;


/**
 * 评论id
 */
@property(nonatomic,assign)NSInteger pid;

/**
 * 用户id
 */
@property(nonatomic,copy)NSString * userid;


@property(nonatomic,copy)NSArray * xiaji;

@property(nonatomic,copy)NSArray<BoyiShiPinXiaJiCommentDetailModel*> * XiaJiCommentModelList;

/**
 * 评论 中评论的内容高度
 */
@property(nonatomic,assign)CGFloat CellCommenOnCommenListHeight;


/**
 *  评论视频 头像+ 评论内容 部分界面的高度
 */
@property(nonatomic,assign)CGFloat CellCommenAndHeadHeight;

@end


#pragma 视频内容
@interface BoyiShiPinDetailModel : NSObject
/**
 * 评论数
 */
@property(nonatomic,assign)NSInteger commentnum;


/**
 * 封面
 */
@property(nonatomic,copy)NSString * cover;


/**
 * 创建时间
 */
@property(nonatomic,copy)NSString * create_ti;



/**
 * 视频的内容
 */
@property(nonatomic,copy)NSString * describe;



/**
 * 视频点赞数
 */
@property(nonatomic,assign)NSInteger dianzan;


@property(nonatomic,assign)NSInteger display;


@property(nonatomic,assign)NSInteger downloads;


@property(nonatomic,assign)NSInteger id;


@property(nonatomic,assign)NSInteger istop;


@property(nonatomic,assign)NSInteger isvipsee;


@property(nonatomic,assign)NSInteger iszan;


@property(nonatomic,assign)NSInteger pv;


@property(nonatomic,copy)NSString * name;


@property(nonatomic,assign)NSInteger type;


@property(nonatomic,copy)NSString * update_ti;


@property(nonatomic,copy)NSString * video_url;


@property(nonatomic,assign)NSInteger weight;

@property(nonatomic,copy)NSArray * commentlist;

@property(nonatomic,copy)NSArray<BoyiShiPinCommentDetailModel*> *commentModelist;


@end


