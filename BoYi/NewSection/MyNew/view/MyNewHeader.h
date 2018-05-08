//
//  MyNewHeader.h
//  BoYi
//
//  Created by heng on 2018/1/7.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNewHeader : UIView
//进入到我的订单，我的账户，设置     0,1,2
@property (strong, nonatomic) RACSubject *gotoNextVc;

@property (strong, nonatomic) NSArray *hunqinImage;
@property (strong, nonatomic) NSArray *shangchengImage;
@property (weak, nonatomic) IBOutlet UILabel *hunqinDingLabel;
@property (weak, nonatomic) IBOutlet UIView *hunqinDingView;
@property (weak, nonatomic) IBOutlet UILabel *shangChengDinglabel;
@property (weak, nonatomic) IBOutlet UIView *shangChengDingView;
@property (weak, nonatomic) IBOutlet UIImageView *headerimage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *tuanduiName;
@property (weak, nonatomic) IBOutlet UILabel *fensishuliang;
@property (weak, nonatomic) IBOutlet UILabel *guanzhushuliang;
@property (weak, nonatomic) IBOutlet UILabel *yuE;
@property (weak, nonatomic) IBOutlet UILabel *zhekouQuan;

- (void)relodata;

@end
