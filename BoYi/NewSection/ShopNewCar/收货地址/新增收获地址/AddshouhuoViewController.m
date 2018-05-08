//
//  AddshouhuoViewController.m
//  BoYi
//
//  Created by heng on 2018/1/7.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AddshouhuoViewController.h"
#import "CwChooseAreaPikerView.h"
@interface AddshouhuoViewController (){
    NSString *provinceid,*cityid,*countyid;
    NSInteger hot;
}


@end

@implementation AddshouhuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (isIPhoneX) {
        self.height.constant = 84;
    }
    [self addPopBackBtn];
    [self addRightBtnWithTitle:@"保存" image:nil];
    self.name.delegate = self;
    self.name.inputAccessoryView = [self addToolbar];
    self.iphone.delegate = self;
    self.iphone.inputAccessoryView = [self addToolbar];
    self.xiangziAddress.delegate = self;
    self.xiangziAddress.inputAccessoryView = [self addToolbar];
    if (self.isBianji) {
//        provinceid = @"";
//        cityid = @"";
//        countyid = @"";
        self.name.text = self.model.username;
        self.iphone.text = self.model.mobile;
        if (self.model.hot) {
            self.isMonren.on = YES;
        }else {
            self.isMonren.on = NO;
        }
        self.xiangziAddress.text = self.model.site;
        if ([self.model.province isBlankString]) {
            [self.addressbtn setTitle:[NSString stringWithFormat:@"%@%@",self.model.city,self.model.county] forState:UIControlStateNormal];
        }else {
            [self.addressbtn setTitle:[NSString stringWithFormat:@"%@%@%@",self.model.province,self.model.city,self.model.county] forState:UIControlStateNormal];
        }
        provinceid = self.model.province;
        cityid = self.model.city;
        countyid = self.model.county;
        self.navigationItem.title = @"编辑收货地址";
    }else {
        provinceid = @"";
        cityid = @"";
        countyid = @"";
        self.navigationItem.title = @"新增收货地址";
    }
    
    self.xiangziAddress.placeholder = @"请填写详细地址";
    
}
- (void)respondsToRightBtn {
    
    if ([self.name.text isEqualToString:@""]) {
        [NavigateManager showMessage:@"请填写收货人地址"];
        return;
    }
    if ([self.iphone.text isEqualToString:@""]) {
        [NavigateManager showMessage:@"请填写联系电话"];
        return;
    }
    if ([self.addressbtn.titleLabel.text isEqualToString:@"请选择"]) {
        [NavigateManager showMessage:@"请填写地区"];
        return;
    }
    if ([self.xiangziAddress.text isEqualToString:@""]) {
        [NavigateManager showMessage:@"请填写收货人详细地址"];
        return;
    }
    [NavigateManager showLoadingMessage:@"正在保存..."];
    NSDictionary *dic = [[NSDictionary alloc] init];
    if (self.isMonren.on) {
        hot = 1;
    }else {
        hot = 0;
    }
    NSString *url;
    if (self.isBianji) {
        url = [HOMEURL stringByAppendingString:@"appapi/Address/updateAddsite"];
        dic = @{@"id":@(self.model.id),@"provinceid":provinceid,@"cityid":cityid,@"countyid":countyid,@"hot":@(hot),@"mobile":self.iphone.text,@"site":self.xiangziAddress.text,@"username":self.name.text,@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
    }else {
        url = [HOMEURL stringByAppendingString:@"appapi/Address/addsite"];
        dic = @{@"provinceid":provinceid,@"cityid":cityid,@"countyid":countyid,@"hot":@(hot),@"mobile":self.iphone.text,@"site":self.xiangziAddress.text,@"username":self.name.text,@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
    }
    
    
    
    [[RequestManager sharedManager] requestUrl:url
                                        method:POST
                                        loding:nil
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           
                                           [NavigateManager hiddenLoadingMessage];
                                           if ([response[@"code"] integerValue] == 0) {
                                               
                                               [NavigateManager hiddenLoadingMessage];
                                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                   [self popViewConDelay];
                                               });
                                               
                                           }else{
                                               [NavigateManager showMessage:response[@"message"] ? [[NSString stringWithFormat:@"%@",response[@"message"]] replaceUnicode] : @"空空如也"];
                                           }
                                           
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                           [NavigateManager showMessage:@"网络连接失败"];
                                           
                                       }];
    
}
- (IBAction)address:(UIButton *)sender {
    __weak typeof(self)weakSelf = self;
    
    [CwChooseAreaPikerView showInView:self.view block:^(NSString *province, NSString *city, NSString *area) {
        
        
        if ([province isEqualToString:city]) {
            cityid = city;
            countyid = area;
            [weakSelf.addressbtn setTitle:[NSString stringWithFormat:@"%@%@",province,area] forState:UIControlStateNormal];
        }else {
            provinceid = province;
            cityid = city;
            countyid = area;
            [weakSelf.addressbtn setTitle:[NSString stringWithFormat:@"%@%@%@",province,city,area] forState:UIControlStateNormal];
        }
        
        
        
    }];
}

@end
