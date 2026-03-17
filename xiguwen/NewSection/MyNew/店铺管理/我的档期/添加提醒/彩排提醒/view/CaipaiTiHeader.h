//
//  CaipaiTiHeader.h
//  BoYi
//
//  Created by heng on 2018/1/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDangQiModel.h"

@interface CaipaiTiHeader : UIView

//重新加载数据
@property (nonatomic, strong) RACSubject *selectBtnSubject;

@property (weak, nonatomic) IBOutlet UITextField *weddingTimeTF;// 婚礼事时间
@property (weak, nonatomic) IBOutlet UITextField *addressTF;// 彩排地点
@property (weak, nonatomic) IBOutlet UILabel *rehearsalLab;// 彩排时间
@property (weak, nonatomic) IBOutlet UITextView *remarkTV;// 备注

@property (nonatomic, strong) DangQiDetailsModel *model;// 档期model

@end
