//
//  UserInfoModel.m
//  ZeroRead_OC
//
//  Created by Yifei Li on 2017/4/19.
//  Copyright © 2017年 fuyou. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

- (id)copyWithZone:(NSZone *)zone
{
    UserInfoModel *cpyPerson = [[UserInfoModel allocWithZone:zone] init];
    cpyPerson.username = self.username;
    cpyPerson.mobile = self.mobile;
    cpyPerson.sex = self.sex;
    cpyPerson.avatar = self.avatar;
    return cpyPerson;
}



@end
@implementation Createtime

@end


@implementation Zone

@end


@implementation Uncachedzone

@end


@implementation Chronology

@end




@implementation Updatetime

@end




