//
//  MyInfoViewController.m
//  BoYi
//
//  Created by Chen on 2017/8/13.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyInfoViewModel.h"
#import "CwPikerView.h"
#import "ChangePhoneViewController.h"
#import "OrderAlertView.h"

@interface MyInfoViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) MyInfoViewModel *viewModel;

@end

@implementation MyInfoViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人资料";
    [self addPopBackBtn];
    
    [self setupTableView];
    [self cellClick];
    self.topInset.constant = UIApplication.sharedApplication.statusBarFrame.size.height + 44.0;
}


#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(id  _Nullable x) {
       
        @strongify(self);
        switch ([x integerValue]) {
            case 0:
            {
                __weak typeof(self) weakSelf = self;
                [self showImagePikerWithActionTitle:@"选择" imageEditing:YES imageBlock:^(UIImage *image) {
                    [NavigateManager showLoadingMessage:@"正在保存..."];
                    [[RequestManager sharedManager] updatePic:UIImagePNGRepresentation(image)
                                                   parameters:@{@"username":USERID}
                                                     response:^(id response) {
                                                         if (response) {
                                                             [NavigateManager showMessage:@"修改成功"];
                                                             [UserData reWriteUserInfo:response[@"r"][@"avatar"] ForKey:@"avatar"];
                                                             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                 [weakSelf.table reloadData];
                                                             });
                                                         } else {
                                                             [NavigateManager showMessage:@"修改失败，请重试"];
                                                         }
                                                         
                    }];
                }];
            }
                break;
            case 1: {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                               message:@"请输入您的姓名"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    //
                }];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    DLog(@"%@",alert.textFields.firstObject.text);
                    
                    __weak typeof(self) weakSelf = self;
                    [NavigateManager showLoadingMessage:@"正在保存..."];
                    [[RequestManager sharedManager] updatePic:nil
                                                   parameters:@{@"username":USERID,@"cnName":alert.textFields.firstObject.text}
                                                     response:^(id response) {
                                                         if (response) {
                                                             [NavigateManager showMessage:@"修改成功"];
                                                             [UserData reWriteUserInfo:response[@"r"][@"cnName"] ForKey:@"cnName"];
                                                             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                 [weakSelf.table reloadData];
                                                             });
                                                         } else {
                                                             [NavigateManager showMessage:@"修改失败，请重试"];
                                                         }
                                                     }];
//
                                                     }]];
                [self presentViewController:alert animated:YES completion:NULL];
            }
                                  
                break;
            case 2:
            {
//                ChangePhoneViewController *vc = [[ChangePhoneViewController alloc] init];
//                vc.style = ChangePhoneStyleVerPhone;
//                [self pushToNextVCWithNextVC:vc];
            }
                break;
            case 3: {
                
                __weak typeof(self) weakSelf = self;
                CwPikerView *piker = [CwPikerView showInView:self.view block:^(NSString *title, NSInteger index) {
                    
                    [NavigateManager showLoadingMessage:@"正在保存..."];
                    [[RequestManager sharedManager] updatePic:nil
                                                   parameters:@{@"username":USERID,@"sex":index == 0 ? @0 : @2}
                                                     response:^(id response) {
                                                         if (response) {
                                                             [NavigateManager showMessage:@"修改成功"];
                                                             [UserData reWriteUserInfo:response[@"r"][@"sex"] ForKey:@"sex"];
                                                             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                 [weakSelf.table reloadData];
                                                             });
                                                         } else {
                                                             [NavigateManager showMessage:@"修改失败，请重试"];
                                                         }
                                                     }];

                }];
                piker.dataSource = @[@"男",@"女"];
            }
                break;
            case 4:
            {
                ChangePhoneViewController *vc = [[ChangePhoneViewController alloc] init];
                vc.style = ChangePhoneStyleChangePassword;
                [self pushToNextVCWithNextVC:vc];
            }
                break;
                
                
            default:
                
                break;
        }
    }];
    
}


/**
 退出
 */
- (void)exit {
    
    //取消订单  未付款
    __weak typeof(self) weakSelf = self;
    [OrderAlertView showInView:self.view
                           top:@"您真的要退出吗!"
                        bottom:nil
                         block:^(NSInteger index) {
                             //完成
                             [UserData cleanUserInfo];
                             [NavigateManager showLoadingMessage:@"正在退出..."];
                             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 [NavigateManager showMessage:@"退出成功!"];
                                 [weakSelf popViewConDelay];
                             });
                         }];
    
    
}

#pragma mark - public api


#pragma mark - private api

- (void)beginUpdate:(NSDictionary *)info {
    
    @weakify(self);
    [[[RequestManager sharedManager] RACRequestUrl:URL_updateUser
                                           method:POST
                                           loding:@"正在保存"
                                              dic:info] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [NavigateManager showMessage:@"保存成功"];
        
    }];
}


//配置tableView
- (void)setupTableView {
    
    
    [self.table registerNib:[UINib nibWithNibName:@"MyInfoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyInfoTableViewCell"];
    //[self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    footer.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth * 2 / 3, 40)];
    btn.center = footer.center;
    btn.backgroundColor = MAINCOLOR;
    [btn setTitle:@"注销登录" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 4;
    [footer addSubview:btn];
    
    self.table.tableFooterView = footer;
    

//    @weakify(self);
//    
//    //下拉刷新
//    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//        @strongify(self);
//        //传入参数 进行刷新
//        [self.viewModel.refreshDataCommand execute:@{}];
//    }];
//    
//    //请求结束
//    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
//        
//        @strongify(self);
//        
//        //数据处理
//        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
//        
//        //正在下啦
//        if (self.table.mj_header.isRefreshing) {
//            
//            if (!self.table.mj_footer) {
//                //上啦加载
//                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                    //传入参数 进行刷新
//                    [self.viewModel.refreshDataCommand execute:@{}];
//                }];
//            }
//            [self.table.mj_header endRefreshing];
//        }
//        
//        //判断，如果item < size 显示已获取完成
//        if (self.viewModel.dataArray.count < 10) {
//            
//            [self.table.mj_footer endRefreshingWithNoMoreData];
//        } else {
//            
//            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
//            
//        }
//        //    [self.tableView reloadEmptyDataSet];
//        //刷新视图
//        [self.table reloadData];
//        
//    }];
}

//初始化viewModel
- (MyInfoViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MyInfoViewModel alloc] init];
    }
    return _viewModel;
}


@end
