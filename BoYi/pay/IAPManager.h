//
//  IAPManager.h
//  FaceShow
//
//  Created by gchao on 2018/4/9.
//  Copyright © 2018年 GChao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IAPManagerDelegate <NSObject>

-(void)IAPFailedWithWrongInfor:(NSString *)informationStr;

-(void)IAPPaySuccessFunctionWithBase64:(NSString *)base64Str;

@end


@interface IAPManager : NSObject
@property(nonatomic ,weak) id<IAPManagerDelegate> IAPDelegate;

+(instancetype)sharedManager;



/**
 *  @brief     添加IAP观察者
 *
 *  @parameter 无
 *
 *  @returning 无
 */
-(void)addTheIAPObserver;

/**
 *  @brief     删除IAP观察者
 *
 *  @parameter 无
 *
 *  @returning 无
 */
-(void)removeTheIAPOberver;

/**
 *  @brief     从appleStore获取商品信息
 *
 *  @parameter productIdentifier  商品编号（服务器获取）
 *
 *  @returning 无
 */
- (void)getProductInfo:(NSString *)productIdentifier;


@end
