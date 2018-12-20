//
//  baojiaShopCar.m
//  BoYi
//
//  Created by heng on 2017/12/24.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "baojiaShopCar.h"
#import "CDdatepicker.h"
#import "ApayOrYL.h"
#import "WeChatPayManager.h"

@implementation baojiaShopCar
+ (baojiaShopCar *)showInView:(UIView *)view array:(NSMutableArray *)array dic:(NSMutableDictionary *)dic string:(NSString *)string block:(void(^)(NSDictionary *dic))block{
    
    baojiaShopCar *alert = [[[NSBundle mainBundle]loadNibNamed:@"baojiaShopCar" owner:self options:nil]lastObject];
    alert.name.text = dic[@"name"];
    alert.price.text = dic[@"price"];
    alert.dicccc = dic;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"]; // ----------设置你想要的格式,hh与HH的
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间
    NSString *times = [NSString stringWithFormat:@"%@  中午",[formatter stringFromDate:datenow]];
    alert.time.text = times;
    
    [[NSString stringWithFormat:@"%@",dic[@"header"]] isBlankString] ? @"" : [alert.headerImage sd_setImageWithUrl:dic[@"header"] placeHolder:[UIImage imageNamed:@"占位图片"]];
    alert.userId = string;
    
    alert.priceNUmber = 1;
    
    
    NSDictionary *dicc = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),@"baojiaid":alert.userId,@"quantity":@"1",@"paytype":@"1",@"baojiatime":@"2",@"baojiadate":[formatter stringFromDate:datenow]};
    alert.dicm = [[NSMutableDictionary alloc] initWithDictionary:dicc];
    
    alert.frame = view.frame;
    alert.block = block;
    [alert showOnView:view];
    
    return alert;
    
}

- (IBAction)all:(IB_DESIGN_Button *)sender {
    if (sender.tag == 10) {
        [self.quankuanBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.quankuanBTN setBackgroundColor:MAINCOLOR];
        
        [self.dingjinBTN setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
        [self.dingjinBTN setBackgroundColor:RGBA(240, 240, 240, 1)];
        self.price.text = self.dicccc[@"price"];
        [self.dicm setObject:@"1" forKey:@"paytype"];
    }else {
        [self.quankuanBTN setTitleColor:RGBA(38, 38, 38, 1) forState:UIControlStateNormal];
        [self.quankuanBTN setBackgroundColor:RGBA(240, 240, 240, 1)];
        self.price.text = self.dicccc[@"temporarypay"];
        [self.dingjinBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.dingjinBTN setBackgroundColor:MAINCOLOR];
        [self.dicm setObject:@"2" forKey:@"paytype"];
    }
    
}



- (IBAction)timer:(UIButton *)sender {
    
    
    
    __weak typeof(self) weakSelf = self;
    CDdatepicker *piker = [CDdatepicker showInView:weakSelf issele:NO block:^(NSMutableDictionary *dic) {
        NSString *date = dic[@"date"];
        NSString *time = dic[@"time"];
        NSString *timewu = @"1";
        if ([time isEqualToString:@"上午"]) {
            timewu = @"1";
        }if ([time isEqualToString:@"中午"]){
            timewu = @"2";
        }if ([time isEqualToString:@"下午"]){
            timewu = @"3";
        }if ([time isEqualToString:@"晚上"]){
            timewu = @"4";
        }
        self.time.text = [NSString stringWithFormat:@"%@ %@",date,time];
        
        [self.dicm setObject:timewu forKey:@"baojiatime"];
        [self.dicm setObject:date forKey:@"baojiadate"];
    }];
    
}



- (IBAction)jiajianAC:(UIButton *)sender {
    if (sender.tag == 201) {
        
        self.priceNUmber ++;
        
    }else { //减
        self.priceNUmber > 1 ? self.priceNUmber -- : self.priceNUmber;
        
    }
    self.number.text = [NSString stringWithFormat:@"%d",self.priceNUmber];
    
    [self.dicm setObject:[NSString stringWithFormat:@"%d",self.priceNUmber] forKey:@"quantity"];
    
    
}
//确定
- (IBAction)sureAC:(UIButton *)sender {
    sender.enabled = NO;
    if (sender.tag == 20) {
        
        if ([[self.dicm objectForKey:@"baojiatime"] isEqualToString:@""] ||  [[self.dicm objectForKey:@"baojiadate"] isEqualToString:@""]) {
            sender.enabled = YES;
            [NavigateManager showMessage:@"请选择日期"];
            return;
        }
        /*
        [ApayOrYL showInView:[UIApplication sharedApplication].keyWindow block:^(NSDictionary *dic) {
            NSString *payFor;
            if ([dic[@"type"] intValue] == 1) {
                payFor = @"app";
            }else {
                payFor = @"bank";
            }
            NSMutableDictionary *dicm = [[NSMutableDictionary alloc] initWithDictionary:@{@"ids":self.dic[@"id"],@"userId":@([UserData sharedManager].userInfoModel.id),@"payStatus":_payStatus,@"payFor":payFor}];
            if ([dic[@"type"] intValue] == 1) {
                [self.dicm setObject:@"alipay" forKey:@"typeus"];
            }else {
                [self.dicm setObject:@"wxpay" forKey:@"typeus"];
            }
         
        [[RequestManager sharedManager] requestUrl:URL_New_hunqinbuyFrist
                                            method:POST
                                            loding:@""
                                               dic:self.dicm
                                          progress:nil
                                           success:^(NSURLSessionDataTask *task, id response) {
         
                                               [NavigateManager hiddenLoadingMessage];
                                               sender.enabled = YES;
                                               if ([response[@"code"] integerValue] == 0) {
         
                                                   [NavigateManager hiddenLoadingMessage];
                                                   [WeChatPayManager payWithType:[dic[@"type"] intValue] info:response[@"data"] vc:self block:^(NSDictionary *response) {
         
                                                   }];
                                                   if (self.block) {
                                                       self.block(self.dicm);
                                                   }
                                                   [self hidden];
                                               }else{
                                                   [NavigateManager showMessage:response[@"msg"] ? [[NSString stringWithFormat:@"%@",response[@"msg"]] replaceUnicode] : @"空空如也"];
                                               }
         
                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                               sender.enabled = YES;
                                               [NavigateManager showMessage:@"网络连接失败"];
                                               if (self.block) {
                                                   self.block(self.dicm);
                                               }
                                               [self hidden];
                                           }];
        
        
        }];
         */
        if (self.block) {
            self.block(self.dicm);
        }
        [self hidden];

    } else {//取消
        [self hidden];
    }
    
    
}
- (void) hidden{
    self.transform = CGAffineTransformIdentity;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 0.01;
        weakSelf.bgView.alpha = 0.01;
        //        weakSelf.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}
- (void)showOnView:(UIView *)view{
    self.alpha = 0.01;
    self.bgView.alpha = 0.01;
    self.transform = CGAffineTransformIdentity;
    self.transform = CGAffineTransformMakeScale(2.5, 2.5);
    [view addSubview:self];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 1;
        weakSelf.bgView.alpha = 1;
        weakSelf.transform = CGAffineTransformIdentity;
    }];
}
- (void)dealloc{
    NSLog(@"xiaohui");
}



@end
