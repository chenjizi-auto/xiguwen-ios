//
//  WirteInfoViewController.m
//  BoYi
//
//  Created by Yifei Li on 2017/8/9.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "WirteInfoViewController.h"
#import "CwPikerView.h"
#import "CwChooseAreaPikerView.h"

@interface WirteInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *MerchantType;
@property (weak, nonatomic) IBOutlet UITextField *type;
@property (weak, nonatomic) IBOutlet UIView *merchantTypeSubView;
@property (weak, nonatomic) IBOutlet UIView *TypeSubView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *areaTopLayout;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;

@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *county;
@end

@implementation WirteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addPopBackBtn];
    [self isChooseMerchant:self.isMerchant];
    
    //显示颜色
    RAC(self.completeBtn,backgroundColor) = [RACSignal combineLatest:@[self.userName.rac_textSignal,
                                                                       RACObserve(self.MerchantType,text),
                                                                       RACObserve(self.type,text),
                                                                       RACObserve(self,isMerchant),
                                                                       RACObserve(self,province)]
                                             
                                                              reduce:^id _Nullable(NSString *name,
                                                                                   NSString *code,
                                                                                   NSString *password,
                                                                                   NSNumber *select,
                                                                                   NSString *province) {
                                                                  
                                                                  if (select.boolValue && name.length > 0 && province.length > 0) {
                                                                      return MAINCOLOR;
                                                                  } else if (!select.boolValue && name.length > 0 && province.length > 0 && code.length > 0 && password.length > 0)
                                                                      return MAINCOLOR;
                                                                  return RGBA(128, 128, 128, 1);
                                                              }];
    RAC(self.completeBtn,enabled) = [RACSignal combineLatest:@[self.userName.rac_textSignal,
                                                                       RACObserve(self.MerchantType,text),
                                                                       RACObserve(self.type,text),
                                                                       RACObserve(self,isMerchant),
                                                                       RACObserve(self,province)]
                                             
                                                              reduce:^id _Nullable(NSString *name,
                                                                                   NSString *code,
                                                                                   NSString *password,
                                                                                   NSNumber *select,
                                                                                   NSString *province) {
                                                                  
                                                                  if (select.boolValue && name.length > 0 && province.length > 0) {
                                                                      return @YES;
                                                                  } else if (!select.boolValue && name.length > 0 && province.length > 0 && code.length > 0 && password.length > 0)
                                                                      return @YES;
                                                                  return @NO;
                                                              }];
}

/**
 点击完成
 
 @param sender 按钮
 */
- (IBAction)complete:(id)sender {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.userName.text forKey:@"unionName"];
    [dic setObject:self.phone forKey:@"username"];
    [dic setObject:self.province forKey:@"s_province"];
    [dic setObject:self.county forKey:@"s_county"];
    [dic setObject:self.city forKey:@"s_city"];
    
    UIButton *btn = (UIButton *)[[[self.view viewWithTag:500] viewWithTag:100] viewWithTag:200];
    if (btn.selected) {
        [dic setObject:@3 forKey:@"diction"];
        [dic setObject:@10 forKey:@"occupation"];
    } else {
        [dic setObject:[self.MerchantType.text isEqualToString:@"团体商家"] ? @5 : @4 forKey:@"diction"];
        NSArray *arr = @[@"策划师",@"摄影师",@"摄像师",@"主持人",@"化妆师"];
        __block NSInteger index = 0;
        __weak typeof (self)WeakSelf = self;
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:WeakSelf.type.text]) {
                index = idx;
                *stop = YES;
            }
        }];
        [dic setObject:@(index + 11) forKey:@"occupation"];
    }
    
    @weakify(self);
    [[[RequestManager sharedManager] RACRequestUrl:URL_REGISTER_Detail
                                            method:POST
                                            loding:@"提交中..."
                                               dic:dic] subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        [NavigateManager showMessage:@"注册成功，请重新登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 顶部选择
 
 @param sender 个人，商家
 */
- (IBAction)ChooseType:(UIButton *)sender {
    
    [sender.superview viewWithTag:300].hidden = NO;
    sender.selected = YES;
    NSInteger tag = sender.tag == 200 ? 201 : 200;
    UIView *otherView = [sender.superview.superview viewWithTag:tag - 100];
    UIButton *btn = (UIButton *)[otherView viewWithTag:tag];
    btn.selected = NO;
    [otherView viewWithTag:300].hidden = YES;

    [self isChooseMerchant:sender.tag == 201];
}


/**
 选择商家类型
 
 @param sender 个人商家，还是其他
 */
- (IBAction)chooseMerchantType:(id)sender {
    
    __weak typeof(self)weakSelf = self;
    
    CwPikerView *piker = [CwPikerView showInView:self.view block:^(NSString *title, NSInteger index) {
        weakSelf.MerchantType.text = title;
    }];
    piker.dataSource = @[@"个人商家",@"团队商家"];
}

/**
 选择类型

 @param sender 营业类型
 */
- (IBAction)chooseType:(id)sender {
    
    __weak typeof(self)weakSelf = self;
    
    CwPikerView *piker = [CwPikerView showInView:self.view block:^(NSString *title, NSInteger index) {
        weakSelf.type.text = title;
    }];
    piker.dataSource = @[@"策划师",@"摄影师",@"摄像师",@"主持人",@"化妆师"];
}


/**
 选择地区

 @param sender 地区
 */
- (IBAction)chooseCity:(id)sender {
    
    __weak typeof(self)weakSelf = self;
    
    [CwChooseAreaPikerView showInView:self.view block:^(NSString *province, NSString *city, NSString *area) {
        
        UIView *view = [weakSelf.view viewWithTag:500];
        UILabel *label1 = (UILabel *)[[view viewWithTag:300] viewWithTag:400];
        label1.text = province;
        UILabel *label2 = (UILabel *)[[view viewWithTag:301] viewWithTag:400];
        label2.text = city;
        UILabel *label3 = (UILabel *)[[view viewWithTag:302] viewWithTag:400];
        label3.text = area;
        
        weakSelf.province = province;
        weakSelf.city     = city;
        weakSelf.county   = area;
    }];
    
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 收起键盘
    [self.view endEditing:YES];
}


//是否是选择的商家
- (void)isChooseMerchant:(BOOL)isChoose {
    
    _merchantTypeSubView.hidden = !isChoose;
    _TypeSubView.hidden = !isChoose;
    
    self.areaTopLayout.constant = isChoose ? 110 : 0;
}


@end
