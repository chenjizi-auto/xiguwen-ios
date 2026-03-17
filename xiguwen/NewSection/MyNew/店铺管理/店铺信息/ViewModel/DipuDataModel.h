//
//  DipuDataModel.h
//  BoYi
//
//  Created by zhoumeineng on 3/19/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DipuModel.h"

typedef void(^DipuDataModelBlock)(DipuModel * model);

typedef void(^DipuUpImageBlock)(NSString * imageUrl,NSInteger indext);
typedef NS_ENUM(NSInteger) {
    ificationlist = 1 , //职业类型
    storeinformation = 2//店铺详情
}REQUESTURL;
@interface DipuDataModel : NSObject
/**
 * 获取数据
 */
@property(nonatomic,strong)RACCommand *DataCommand;


@property (nonatomic, strong) RACSubject *Subject;


@property(nonatomic,strong)RACCommand *DataIficationlistCommand;

@property (nonatomic, strong) RACSubject *DataIficationlistSubject;


@property(nonatomic,strong)RACCommand *UpDataCommand;

@property (nonatomic, strong) RACSubject *UpDataSubject;

@property(nonatomic,copy)NSString * ReqUrl;

@property(nonatomic,strong)DipuDataModelBlock Mblock;

@property(nonatomic,strong)DipuUpImageBlock ImageBlock ;

-(void)Request:(NSString*)url;

-(void)UpImage:(NSData*)ImageData indext:(NSInteger)indext;
@end
