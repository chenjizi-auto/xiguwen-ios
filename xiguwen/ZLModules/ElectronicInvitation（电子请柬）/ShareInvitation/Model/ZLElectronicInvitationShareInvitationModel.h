//
//  ZLElectronicInvitationShareInvitationModel.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/19.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLHTTPSessionManager.h"

@interface ZLElectronicInvitationShareInvitationModel : NSObject

///图片地址
@property (nonatomic,strong) NSData *imageData;
///生成的图片地址
@property (nonatomic,strong) NSString *imageUrl;

#pragma mark - 图片换地址（千牛）
+ (void)imageUrlWithInfoModel:(ZLElectronicInvitationShareInvitationModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete;

@end
