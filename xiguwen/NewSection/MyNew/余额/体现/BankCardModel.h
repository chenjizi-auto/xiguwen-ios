//
//  BankCardModel.h
//  BoYi
//
//  Created by Niklaus on 2018/4/12.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankCardModel : NSObject

@property (nonatomic, strong) NSString *band_number;
@property (nonatomic, assign) NSInteger bandid;
@property (nonatomic, strong) NSString *bandname;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *site;
@property (nonatomic, assign) NSInteger userid;

// 后续添加
@property (nonatomic, strong) NSString *bandnumber;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;

@end
