//
//  PushXuqiuViewController.m
//  BoYi
//
//  Created by heng on 2017/12/28.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "PushXuqiuViewController.h"
#import "FuWuCityMyModel.h"
#import "CwPikerView.h"
#import "MOFSPickerManager.h"
@interface PushXuqiuViewController (){
    NSInteger openmessage,openphone;
    NSArray *arrayCity;
	NSInteger type;
}
@end

@implementation PushXuqiuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布需求";
    [self addPopBackBtn];
    ZL_Discern_Bang_Device(isBangDevice);
    if (isBangDevice) {
        self.height.constant = 84;
    }
    self.xuqiu.placeholder = @"请输入您的需求…";
    openmessage = 1;
    openphone = 1;
	[self.messageBtn setSelected:YES];
	[self.phoneBtn setSelected: YES];
	self.gongkaiIMAGE.image = [UIImage imageNamed:@"勾选商品"];
	self.sureImage.image = [UIImage imageNamed:@"勾选商品"];
	
    arrayCity = [[NSArray alloc] init];
	
	// 判断是否是新建还是编辑
	if (self.model) {
		// 编辑
		type = self.model.type;
		[self.titlename setText: self.model.title];
		[self.price setText: [NSString stringWithFormat:@"%.2ld",(long)self.model.price]];
		[self.diqubtn setTitle:[NSString stringWithFormat:@"%@%@%@",self.model.provinceid,self.model.cityid,self.model.countyid] forState:UIControlStateNormal];
		arrayCity = @[self.model.provinceid,self.model.cityid,self.model.countyid];
		[self.xuqiu setText:self.model.details];
		// 是否选中
		[self.messageBtn setSelected: self.model.openmessage == 0 ? NO : YES];
		[self.gongkaiIMAGE setImage:[UIImage imageNamed: self.model.openmessage == 0 ? @"勾选圈" : @"勾选商品"]];
		openmessage = self.model.openmessage;
		
		[self.phoneBtn setSelected: self.model.openphone == 0 ? NO : YES];
		[self.sureImage setImage:[UIImage imageNamed: self.model.openphone == 0 ? @"勾选圈" : @"勾选商品"]];
		openphone = self.model.openphone;
	}
    
    
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,10,26)];
    leftView.backgroundColor = [UIColor clearColor];
    self.titlename.leftView = leftView;
    self.titlename.leftViewMode = UITextFieldViewModeAlways;
    self.titlename.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel * leftView1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,10,26)];
    leftView1.backgroundColor = [UIColor clearColor];
    self.price.leftView = leftView1;
    self.price.leftViewMode = UITextFieldViewModeAlways;
    self.price.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.price.inputAccessoryView = [self addToolbar];
	self.titlename.inputAccessoryView = [self addToolbar];
    self.xuqiu.inputAccessoryView = [self addToolbar];
    
}
- (IBAction)diqu:(IB_DESIGN_Button *)sender {
    @weakify(self)
    [[MOFSPickerManager shareManger] showMOFSAddressPickerWithDefaultAddress:@"四川省-成都市市-锦江区" title:@"选择地址" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *address, NSString *zipcode) {        
        arrayCity = [address componentsSeparatedByString:@"-"]; //字符串按照【分隔成数组
        @strongify(self)
        [self.diqubtn setTitle:[NSString stringWithFormat:@"%@%@%@",arrayCity[0],arrayCity[1],arrayCity[2]] forState:UIControlStateNormal];
    } cancelBlock:^{
        
    }];

}
- (IBAction)gongkai:(UIButton *)sender {
    
    if (sender.selected) {
        self.gongkaiIMAGE.image = [UIImage imageNamed:@"勾选圈"];
        openmessage = 0;
    }else {
        self.gongkaiIMAGE.image = [UIImage imageNamed:@"勾选商品"];
        openmessage = 1;
    }
    sender.selected = !sender.selected;
}
//dianhua
- (IBAction)surehunqi:(UIButton *)sender {
    
    if (sender.selected) {
        self.sureImage.image = [UIImage imageNamed:@"勾选圈"];
        openphone = 0;
    }else {
        self.sureImage.image = [UIImage imageNamed:@"勾选商品"];
        openphone = 1;
    }
    sender.selected = !sender.selected;
}
- (IBAction)fabu:(IB_DESIGN_Button *)sender {
    
    if ([self.titlename.text isEqualToString:@""]) {
        [NavigateManager showMessage:@"请输入标题"];
        return;
    }
    if ([self.price.text isEqualToString:@""]) {
        [NavigateManager showMessage:@"请输入价格"];
        return;
    }
    if ([self.diqubtn.titleLabel.text isEqualToString:@"请选择地区"]) {
        [NavigateManager showMessage:@"请选择地区"];
        return;
    }
    
    type = 1;
	
	NSDictionary *dic;
	if (self.isEdit) {
		dic = @{@"address":self.diqubtn.titleLabel.text,@"details":self.xuqiu.text,@"price":self.price.text,@"title":self.titlename.text,@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),@"type":@(type),@"openmessage":@(openmessage),@"openphone":@(openphone),@"provinceid":arrayCity[0],@"cityid":arrayCity[1],@"countyid":arrayCity[2],@"id":@(self.model.id)};
	} else {
		dic = @{@"address":self.diqubtn.titleLabel.text,@"details":self.xuqiu.text,@"price":self.price.text,@"title":self.titlename.text,@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),@"type":@(type),@"openmessage":@(openmessage),@"openphone":@(openphone),@"provinceid":arrayCity[0],@"cityid":arrayCity[1],@"countyid":arrayCity[2]};
	}
	[[RequestManager sharedManager] requestUrl: self.isEdit ? URL_editMyDemand : URL_New_fabuxuqiu
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"cdoe"] integerValue] == 0) {
                                               [NavigateManager showMessage:@"发布成功"];
											   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                   
                                                   [self popViewConDelay];;
                                               });
                                               
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                           [NavigateManager showMessage:@"发布失败"];
                                           
                                       }];
}


@end
