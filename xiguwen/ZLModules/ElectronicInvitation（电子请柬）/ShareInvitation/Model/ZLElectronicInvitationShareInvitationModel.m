//
//  ZLElectronicInvitationShareInvitationModel.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/19.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationShareInvitationModel.h"

@implementation ZLElectronicInvitationShareInvitationModel

#pragma mark - 图片换地址（千牛）
+ (void)imageUrlWithInfoModel:(ZLElectronicInvitationShareInvitationModel *)infoModel Results:(void (^)(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage))complete {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    NSString *dataString = [infoModel.imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    dictM[@"img"] = [@"data:image/jpeg;base64," stringByAppendingString:dataString];
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/System/uploadimgba" Params:dictM POST:YES ModelArray:nil HttpHeader:NO Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            if ([responseObject[@"code"] intValue]) {
                complete(sessionErrorState,responseObject[@"message"]);
                return ;
            }
            infoModel.imageUrl = responseObject[@"data"];
            complete(sessionErrorState,nil);
            return ;
        }
        complete(sessionErrorState,@"图片上传失败！");
        return ;
    }];
}

@end
