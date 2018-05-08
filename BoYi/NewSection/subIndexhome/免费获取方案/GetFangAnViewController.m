//
//  GetFangAnViewController.m
//  BoYi
//
//  Created by heng on 2017/12/28.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "GetFangAnViewController.h"
#import "CwDatePiker.h"
#import "UItextViewWithPlaceHloder.h"
#import "MOFSPickerManager.h"

@interface GetFangAnViewController ()<UITextFieldDelegate,UITextViewDelegate>{
    NSString *_cityid,*_datepicker,*_provinceid,*_countyid;
    NSArray *arrayCity;
}
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *gouxuanImage;
@property (weak, nonatomic) IBOutlet UILabel *gouxuanLabel;
@property (weak, nonatomic) IBOutlet UITextField *yusuan;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet UITextField *iphone;
@property (weak, nonatomic) IBOutlet UItextViewWithPlaceHloder *textView;
@property (weak, nonatomic) IBOutlet UIButton *surebtn;
@end

@implementation GetFangAnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"免费获取方案";
    if (IS_IPHONE_5) {
        self.height.constant = 20;
    }
    [self addPopBackBtn];
    [self getNumber];
    self.textView.placeholder = @"请输入...";
    self.yusuan.delegate = self;
    self.iphone.delegate = self;
    self.textView.delegate = self;
    [self.yusuan setValue:RGBA(137, 137, 137, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [self.yusuan setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.iphone setValue:RGBA(137, 137, 137, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [self.iphone setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,10,26)];
    leftView.backgroundColor = [UIColor clearColor];
    self.yusuan.leftView = leftView;
    self.yusuan.leftViewMode = UITextFieldViewModeAlways;
    self.yusuan.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel * leftView1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,10,26)];
    leftView1.backgroundColor = [UIColor clearColor];
    self.iphone.leftView = leftView1;
    self.iphone.leftViewMode = UITextFieldViewModeAlways;
    self.iphone.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    self.yusuan.inputAccessoryView = [self addToolbar];
    self.iphone.inputAccessoryView = [self addToolbar];
    self.textView.inputAccessoryView = [self addToolbar];
}
- (IBAction)sureac:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.gouxuanImage.image = [UIImage imageNamed:@"勾选照片"];
        [self.timeBtn setTitle:@"请选择婚礼时间" forState:UIControlStateNormal];

        _datepicker = @"";
    }else {
        self.gouxuanImage.image = [UIImage imageNamed:@"勾选圈"];
        [self.timeBtn setTitle:@"请选择婚礼时间" forState:UIControlStateNormal];
         _datepicker = @"";
    }
    
}
- (IBAction)tijiao:(UIButton *)sender {
    
    
    if ([self.yusuan.text isEqualToString:@""]) {
        [NavigateManager showMessage:@"请填写预算"];
        return;
    }
    if ([_provinceid isEqualToString:@""]) {
        [NavigateManager showMessage:@"请选择地址"];
        return;
    }
    if (self.iphone.text.length != 11) {
        [NavigateManager showMessage:@"手机号格式错误"];
        return;
    }
    if ([self.textView.text isEqualToString:@""]) {
        [NavigateManager showMessage:@"请填写说明备注"];
        return;
    }
    NSDictionary *dic = @{@"cityid":_cityid,@"contenta":self.textView.text,@"datepicker":_datepicker,@"mobile":self.iphone.text,@"price":self.yusuan.text,@"provinceid":_provinceid};
    [[RequestManager sharedManager] requestUrl:URL_New_jubaohunli
                                        method:POST
                                        loding:@""
                                           dic:@{@"cityid":_cityid,@"contenta":self.textView.text,@"datepicker":_datepicker,@"mobile":self.iphone.text,@"price":self.yusuan.text,@"provinceid":_provinceid,@"countyid":_countyid}
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               self.number.text = [NSString stringWithFormat:@"%@位",response[@"data"]];
                                               [NavigateManager showMessage:@"提交成功"];
                                               
                                               
                                               UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提交成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                                               UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:^(UIAlertAction*_Nonnull action) {
                                                   
                                                   [self popViewConDelay];
                                                   
                                               }];
                                               
                                               UIAlertAction*cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction*_Nonnull action) {
                                                  
                                                   
                                               }];
                                               [alertController addAction:sureAction];
                                               [alertController addAction:cancelAction];
                                               [self presentViewController:alertController animated:YES completion:nil];
                                               
                                               return;
                                           }else{
                                               [NavigateManager showMessage:response[@"message"]];
                                               
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                       }];
    
}
- (IBAction)timeac:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [CwDatePiker showInView:weakSelf.view issele:YES block:^(NSDate *date) {

        NSString *dateString = [date fs_stringWithFormat:@"yyyy-MM-dd"];
        
                    [weakSelf.timeBtn setTitle:dateString forState:UIControlStateNormal];
        _datepicker = dateString;
        self.gouxuanImage.image = [UIImage imageNamed:@"勾选圈"];
        self.surebtn.selected = NO;
    }];
}
- (IBAction)addressac:(UIButton *)sender {
    @weakify(self)
    [[MOFSPickerManager shareManger] showMOFSAddressPickerWithDefaultAddress:@"四川省-成都市市-锦江区" title:@"选择地址" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *address, NSString *zipcode) {
        arrayCity = [address componentsSeparatedByString:@"-"]; //字符串按照【分隔成数组
        @strongify(self)
        [self.self.addressBtn setTitle:[NSString stringWithFormat:@"%@%@%@",arrayCity[0],arrayCity[1],arrayCity[2]] forState:UIControlStateNormal];
        _provinceid = arrayCity[0];
        _cityid = arrayCity[1];
        _countyid = arrayCity[2];
    } cancelBlock:^{
        
    }];
}

- (void)getNumber{

    
    [[RequestManager sharedManager] requestUrl:URL_New_getNumber
                                        method:POST
                                        loding:nil
                                           dic:nil
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               self.number.text = [NSString stringWithFormat:@"%@位",response[@"data"]];
                                               
                                           }else{
                                               
                                               
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           
                                    
                                           
                                       }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 收起键盘
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
