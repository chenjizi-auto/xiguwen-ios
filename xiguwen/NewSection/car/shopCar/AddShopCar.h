//
//  AddShopCar.h
//  BoYi
//
//  Created by apple on 2017/8/24.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fuwuModel.h"
#import "ScheduleModel.h"
@interface AddShopCar : UIView{

}

@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *quankuanBTN;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *dingjinBTN;


@property (nonatomic, assign) int priceNUmber;//

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UIButton *timeBtn;

@property (weak, nonatomic) IBOutlet UILabel *number;

@property (nonatomic, strong) UIButton *timeBtnMark;//


@property (nonatomic, strong) NSDictionary *dicccc;//

@property (copy,nonatomic) void(^ block)(NSDictionary *dic);
@property (nonatomic, strong) NSMutableDictionary *dicm;

+ (AddShopCar *)showInView:(UIView *)view array:(NSMutableArray *)array dic:(NSMutableDictionary *)dic string:(NSString *)string block:(void(^)(NSDictionary *dic))block;

@property (strong, nonatomic)NSString *userId;
@end
