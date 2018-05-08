//
//  DIpuAlertImageBaseView.h
//  BoYi
//
//  Created by zhoumeineng on 3/23/18.
//  Copyright © 2018 hengwu. All rights reserved.
//
typedef NS_ENUM(NSInteger) {
   btn=1,
    imageView=2,
}UPDATIMAGEINDEXT;
#import <UIKit/UIKit.h>
#import "DipuDataModel.h"

typedef void(^AlertImageBaseBlock)(NSData *data);
@interface DIpuAlertImageBaseView : UIView
@property(nonatomic,weak)id Object;
- (void)ShowView;
@property(nonatomic,strong)DipuDataModel * DataModel;
@property(nonatomic,strong)UIImageView * BackImageView;
@property(nonatomic,strong)UIButton * Btn;
@property(nonatomic,assign)UPDATIMAGEINDEXT type;
@property(nonatomic,strong)AlertImageBaseBlock Mblock;
@end
