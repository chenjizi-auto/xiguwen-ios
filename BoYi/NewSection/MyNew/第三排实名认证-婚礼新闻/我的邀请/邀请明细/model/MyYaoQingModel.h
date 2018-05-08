//
//  MyYaoQingModel.h
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class InvitationArray;
@interface MyYaoQingModel : NSObject

// custom code
@property (nonatomic, strong) NSArray<InvitationArray *> *invitationArray;

@end

@interface InvitationArray :NSObject

@property (nonatomic, strong) NSNumber *mobile;
@property (nonatomic, strong) NSString *created_at;

@end
