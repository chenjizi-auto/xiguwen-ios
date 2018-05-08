//
//  DiPuPickerView.h
//  BoYi
//
//  Created by zhoumeineng on 3/23/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

typedef NS_ENUM(NSInteger) {
    city= 1,
    ShopType = 2,//商家类型
    Occupational=3//职业类型
}DiPuPickerType;
typedef void(^CityPickBlock)(NSString * cityNames,NSString * citys,DiPuPickerType type);
#import <UIKit/UIKit.h>
@interface DiPuPickerView : UIView
-(void)PickdataSources:(NSArray *)dataSources type:(NSInteger)type;
@property(assign,nonatomic) BOOL isCityChoose;  //城市选择，只有省市
@property(nonatomic,strong)CityPickBlock Mblock;
@end
