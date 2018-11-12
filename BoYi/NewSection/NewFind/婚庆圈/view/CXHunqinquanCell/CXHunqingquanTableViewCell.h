//
//  CXHunqingquanTableViewCell.h
//  BoYi
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HunqinQuanModel.h"
typedef void (^operationtaped)(NSString *typeName);
@interface CXHunqingquanTableViewCell : UITableViewCell
@property (nonatomic ,strong)UIButton *header;
@property (nonatomic ,strong)UILabel *name;
@property (nonatomic ,strong)UILabel *deslabel;
@property (nonatomic ,strong)UILabel *time;
@property (nonatomic ,strong)UIButton *sees;
@property (nonatomic ,strong) UIButton *careBtn;
@property (nonatomic ,strong)UIButton *talks;
@property (nonatomic ,strong)UIButton *goods;
@property (nonatomic ,copy)operationtaped partTpaed;
-(void)loadwithModel:(Hunqinnewarray *)model;

@property (nonatomic, copy) void(^onSelectedImg)(NSInteger index);
@property (nonatomic, copy) void(^onSelectedHeader)(void);
@end
