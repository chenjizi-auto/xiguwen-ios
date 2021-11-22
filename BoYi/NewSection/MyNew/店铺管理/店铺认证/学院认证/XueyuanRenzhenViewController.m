//
//  XueyuanRenzhenViewController.m
//  BoYi
//
//  Created by heng on 2018/1/18.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "XueyuanRenzhenViewController.h"
#import "InstituteAuthCell.h"
#import "CertificationDataModel.h"
#import "RenZhenXYViewController.h"
#import "ShouyinTaiViewController.h"

@interface XueyuanRenzhenViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSString *remark;
@end

@implementation XueyuanRenzhenViewController

#pragma mark - setters and getters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 45;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview: self.tableView];
    self.tableView.sd_layout
    .topSpaceToView(self.view, 0.0f)
    .leftSpaceToView(self.view, 0.0f)
    .rightSpaceToView(self.view, 0.0f)
    .bottomSpaceToView(self.view, 0.0f);
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 获取认证类型和价格
    WeakSelf(self);
    [[RequestManager sharedManager] requestUrl:URL_getAuthInfo
                                        method:POST
                                        loding:@""
                                           dic:@{}
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
        // 判断用户类型
        if ([UserDataNew sharedManager].userInfoModel.user.team == 1) {
            // 个人
            weakSelf.certificationArray = [response[@"data"] subarrayWithRange:NSMakeRange(4, 7)];
        } else {
            // 团队
            weakSelf.certificationArray = [response[@"data"] subarrayWithRange:NSMakeRange(11, 7)];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    [self updateView];
}

- (void)updateView {
    // 所有用户进行交互成功之后都要进行此步操作来冲亲请求数据并且刷新页面
    WeakSelf(self);
    [[UserDataNew sharedManager] getCertificationInfo:^(BOOL isSuccess) {
        if (isSuccess) {
            // 请求成功可以刷新界面
            weakSelf.dataArray = [UserDataNew sharedManager].certificationDataModel.xueyuan;
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark - TableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InstituteAuthCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    if (!cell) {
        cell = [[InstituteAuthCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier: @"cell"];
    }
    InstituteAuth *model = self.dataArray[indexPath.row];
    DLog(@"%@",model.statusStr);
    [cell updateViewWithModel:model];
    // 判断用户类型
    if ([UserDataNew sharedManager].userInfoModel.user.team != 1) {
        // 个人
        cell.levelLabel.text = @[@"一星",@"二星",@"三星",@"四星",@"五星",@"六星",@"七星"][indexPath.row];
    } else {
        // 团队
        cell.levelLabel.text = @[@"初级",@"中级",@"高级",@"总监",@"大师",@"皇冠大师",@"超凡大师"][indexPath.row];
    }
    WeakSelf(self);
    [cell setSubmitClick:^{
        
        if (model.state == 0) {
            // 先交钱
            [weakSelf ToCertification:indexPath.row];
        } else if (model.state == 1) {
            // 已经通过无操作
        } else if (model.state == 2) {
            // 未通过
            RenZhenXYViewController *vc = [[RenZhenXYViewController alloc] init];
            vc.model = model;
            [weakSelf pushToNextVCWithNextVC:vc];
        } else if (model.state == 3) {
            // 审核中无操作
        } else if (model.state == 4) {
            // 点击认证按钮进行操作
            RenZhenXYViewController *vc = [[RenZhenXYViewController alloc] init];
            vc.model = model;
            [weakSelf pushToNextVCWithNextVC:vc];
        }
    }];
    return cell;
}

- (void)ToCertification:(NSInteger)index {
    
    
    WeakSelf(self);
    // 进行判断状态，是否认证通过
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"message"preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入备注";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
    
    UIAlertAction*cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleDefault handler:^(UIAlertAction*_Nonnull action) {
        // 取消认证支付
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"去缴费"style:UIAlertActionStyleDefault handler:^(UIAlertAction*_Nonnull action) {
        // 跳转支付模块
        [weakSelf ToPayWith:index];
    }];
    
    
    NSMutableAttributedString *messageAttribute = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"认证费用:¥%@",[self.certificationArray[index] objectForKey:@"parameter2"]]];
    [messageAttribute addAttribute:NSForegroundColorAttributeName value: MAINCOLOR range:NSMakeRange(5,messageAttribute.string.length-5)];
    [messageAttribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0,messageAttribute.string.length)];
    [alertController setValue:messageAttribute forKey:@"attributedMessage"];
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

// TextFieldTextDidChange 的通知处理方法
- (void)alertTextFieldDidChange:(NSNotification *)notification{
    
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *remarkTF = alertController.textFields.firstObject;
        //		UIAlertAction *okAction = alertController.actions.lastObject;
        // 设置okAction的状态，是否可点击
        //		okAction.enabled = remarkTF.text.length > 0;
        self.remark = remarkTF.text;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)ToPayWith:(NSInteger)index {
    // 提交认证费用
    [self getOrderIdWithPrice:[NSString stringWithFormat:@"%@",self.certificationArray[index][@"parameter2"]] type:[NSString stringWithFormat:@"%@",self.certificationArray[index][@"id"]]];
}
- (void)getOrderIdWithPrice:(NSString *)price type:(NSString *)type {
    
    NSDictionary *info = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
                           @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
                           @"money":price,
                           @"type":type,
                           @"remark":self.remark ? self.remark : @""
    };
    
    WeakSelf(self);
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/Authentication/flowsheet"]
                                        method:POST
                                        loding:@""
                                           dic:info
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
        
        [NavigateManager hiddenLoadingMessage];
        
        if ([response[@"code"] integerValue] == 0) {
            
            [NavigateManager hiddenLoadingMessage];
            // 跳转支付模块
            ShouyinTaiViewController *vc = [[ShouyinTaiViewController alloc] init];
            vc.type = 5;
            vc.price = price;
            vc.bianhao = [NSString stringWithFormat:@"%@",response[@"data"][@"dingdanid"]];
            [weakSelf pushToNextVCWithNextVC:vc];
            
        }else{
            [NavigateManager showMessage:response[@"message"] ? [[NSString stringWithFormat:@"%@",response[@"message"]] replaceUnicode] : @"空空如也"];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [NavigateManager showMessage:@"网络连接失败"];
        
    }];
}

@end
