//
//  MineViewController.m
//  BoYi
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MineViewController.h"
#import "MineViewModel.h"
#import "EvaluationManagementSubViewController.h"
#import "MyCaseSubViewController.h"
#import "MyOfferSubViewController.h"
#import "MyConcernSubViewController.h"
#import "MyOrderSubViewController.h"
#import "ShopOrderSubViewController.h"
#import "LoginViewController.h"
#import "UserInfoModel.h"
#import "UIImage+GIF.h"
#import "MineModel.h"
#import "ShopCarList.h"
#import "SurePayViewController.h"
@interface MineViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) MineViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIView *NotLoginView;
@property (weak, nonatomic) IBOutlet UIImageView *userHeader;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *myMoney;
@property (weak, nonatomic) IBOutlet UILabel *MyBoIcon;

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (![UserData UserLoginState]) {
        self.NotLoginView.hidden = NO;
    } else {
        
        [self refreshUserData];
        
        [self getZiZhi];
    }
    
}
- (void)refreshUserData {
    UIView *headerView = self.table.tableHeaderView;
    
    
    if ([UserData sharedManager].userInfoModel.userType == 2) {
        self.viewGuanzhu.hidden = YES;
        self.viewTwo.hidden = YES;
        self.viewThree.hidden = YES;
        self.viewFour.hidden = YES;
        
        self.height.constant = -64;
        UILabel *label = (UILabel *)[self.viewOne viewWithTag:200];
        label.text = @"我的关注";
        UIImageView *image = (UIImageView *)[self.viewOne viewWithTag:300];
        image.image = IMAGE_NAME(@"关注");
        for (UIView *view in self.viewOne.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                view.tag = 102;
                break;
            }
        }
        CGRect rect = CGRectMake(0, 0, ScreenWidth, 294);
        headerView.frame = rect;
        self.table.tableHeaderView = nil;
        self.table.tableHeaderView = headerView;
        
    }else {
        self.viewGuanzhu.hidden = NO;
        self.viewTwo.hidden = NO;
        self.viewThree.hidden = NO;
        self.viewFour.hidden = NO;
        
        self.height.constant = -64;
        UILabel *label = (UILabel *)[self.viewOne viewWithTag:200];
        label.text = @"商家接单";
        UIImageView *image = (UIImageView *)[self.viewOne viewWithTag:300];
        image.image = IMAGE_NAME(@"订单-(2)");
        for (UIView *view in self.viewOne.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                view.tag = 101;
                break;
            }
        }
        self.height.constant = 8;
        CGRect rect = CGRectMake(0, 0, ScreenWidth, 366);
        headerView.frame = rect;
        self.table.tableHeaderView = nil;
        self.table.tableHeaderView = headerView;
    }
    self.NotLoginView.hidden = YES;
    if ([UserData sharedManager].userInfoModel.avatar) {
        
        //            [self.userHeader sd_setImageWithUrl:ImageAppendURL([UserData sharedManager].userInfoModel.avatar)];
        [self.userHeader sd_setImageWithUrl:ImageAppendURL([UserData sharedManager].userInfoModel.avatar) placeHolder:[UIImage imageNamed:@"头像"]];
    }
    self.userName.text = [UserData sharedManager].userInfoModel.cnName;
    self.myMoney.text = [NSString stringWithFormat:@"%@",@([UserData sharedManager].userInfoModel.money)];
    if (![[NSString stringWithFormat:@"%@",[UserData sharedManager].userInfoModel.bizProductCount] isBlankString]) {
        self.MyBoIcon.text = [UserData sharedManager].userInfoModel.bizProductCount;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    
    [self setupTableView];
    [self cellClick];
    if ([UserData UserLoginState]) {
        [self addRightBtnWithTitle:@"" image:@"购物车"];
    }
}

- (void)respondsToRightBtn{
    //是否登录
    if (![UserData UserLoginState]) {
        //预约cell
        NewLoginViewController *vc = [[NewLoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:vc];
        return ;
    }
    [ShopCarList showInView:[UIApplication sharedApplication].keyWindow dic:nil block:^(NSDictionary *dic) {
        SurePayViewController *sure = [[SurePayViewController alloc] init];
        sure.dic = [[NSMutableDictionary alloc] initWithDictionary:dic];
        sure.hidesBottomBarWhenPushed = YES;
        [self pushToNextVCWithNextVC:sure];
    }];
}

- (void)getZiZhi{
    
    if (![[UserData sharedManager].userInfoModel.username isBlankString]) {
        [[RequestManager sharedManager] requestUrl:URL_myPersonal
                                            method:POST
                                            loding:nil
                                               dic:@{@"mobile":[UserData sharedManager].userInfoModel.username}
                                          progress:nil
                                           success:^(NSURLSessionDataTask *task, id response) {
                                               
                                               if ([response[@"status"] isEqualToString:@"200"]) {
                                                   //重写userInfo
                                                   [UserData WriteUserInfo:response[@"r"]];
                                                   [self refreshUserData];
                                                   
                                                   MineModel *model = [MineModel mj_objectWithKeyValues:response[@"r"]];
                                                   
                                                   
                                                   self.width.constant = 0;
                                                   if (model.userBizAuth) {
                                                       if (model.userBizAuth.count == 1) {
                                                           self.width.constant = 30;
                                                           self.imageRZOne.hidden = NO;
                                                           if (model.userBizAuth[0].authType == 1) {
                                                               
                                                               self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"平台认证1"];
                                                           }else if (model.userBizAuth[0].authType == 2){
                                                               self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"诚信认证1"];
                                                           }else {
                                                               
                                                               if (model.userBizAuth[0].authLevel == 1) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"初级认证"];
                                                               }else if (model.userBizAuth[0].authLevel == 2) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"中级认证"];
                                                               }else if (model.userBizAuth[0].authLevel == 3) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"高级认证"];
                                                               }else if (model.userBizAuth[0].authLevel == 4) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"大师认证"];
                                                               }else if (model.userBizAuth[0].authLevel == 5) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"总监认证"];
                                                               }else if (model.userBizAuth[0].authLevel == 6) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"皇冠认证"];
                                                               }else if (model.userBizAuth[0].authLevel == 7) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"金冠认证"];
                                                               }else if  (model.userBizAuth[0].authLevel == 8) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"一星白银团队"];
                                                               }else if (model.userBizAuth[0].authLevel == 9) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"二星黄金团队"];
                                                               }else if (model.userBizAuth[0].authLevel == 10) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"三星白金团队"];
                                                               }else if (model.userBizAuth[0].authLevel == 11) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"四星钻石团队"];
                                                               }else if (model.userBizAuth[0].authLevel == 12) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"五星大师团队"];
                                                               }else if (model.userBizAuth[0].authLevel == 13) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"六星皇冠团队"];
                                                               }else if (model.userBizAuth[0].authLevel == 14) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"七星至尊团队"];
                                                               }
                                                           }
                                                       }
                                                       if (model.userBizAuth.count == 2) {
                                                           self.width.constant = 55;
                                                           self.imageRZOne.hidden = NO;
                                                           self.imageRZtwo.hidden = NO;
                                                           
                                                           if (model.userBizAuth[0].authType == 1) {
                                                               
                                                               self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"平台认证1"];
                                                           }else if (model.userBizAuth[0].authType == 2){
                                                               self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"诚信认证1"];
                                                           }else {
                                                               
                                                               if (model.userBizAuth[0].authLevel == 1) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"初级认证"];
                                                               }else if (model.userBizAuth[0].authLevel == 2) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"中级认证"];
                                                               }else if (model.userBizAuth[0].authLevel == 3) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"高级认证"];
                                                               }else if (model.userBizAuth[0].authLevel == 4) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"大师认证"];
                                                               }else if (model.userBizAuth[0].authLevel == 5) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"总监认证"];
                                                               }else if (model.userBizAuth[0].authLevel == 6) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"皇冠认证"];
                                                               }else if (model.userBizAuth[0].authLevel == 7) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"金冠认证"];
                                                               }else if  (model.userBizAuth[0].authLevel == 8) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"一星白银团队"];
                                                               }else if (model.userBizAuth[0].authLevel == 9) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"二星黄金团队"];
                                                               }else if (model.userBizAuth[0].authLevel == 10) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"三星白金团队"];
                                                               }else if (model.userBizAuth[0].authLevel == 11) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"四星钻石团队"];
                                                               }else if (model.userBizAuth[0].authLevel == 12) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"五星大师团队"];
                                                               }else if (model.userBizAuth[0].authLevel == 13) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"六星皇冠团队"];
                                                               }else if (model.userBizAuth[0].authLevel == 14) {
                                                                   self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"七星至尊团队"];
                                                               }
                                                           }
                                                           
                                                           
                                                           //dierge
                                                           if (model.userBizAuth[1].authType == 1) {
                                                               
                                                               self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"平台认证1"];
                                                           }else if (model.userBizAuth[1].authType == 2){
                                                               self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"诚信认证1"];
                                                           }else {
                                                               
                                                               if (model.userBizAuth[1].authLevel == 1) {
                                                                   self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"初级认证"];
                                                               }else if (model.userBizAuth[1].authLevel == 2) {
                                                                   self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"中级认证"];
                                                               }else if (model.userBizAuth[1].authLevel == 3) {
                                                                   self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"高级认证"];
                                                               }else if (model.userBizAuth[1].authLevel == 4) {
                                                                   self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"大师认证"];
                                                               }else if (model.userBizAuth[1].authLevel == 5) {
                                                                   self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"总监认证"];
                                                               }else if (model.userBizAuth[1].authLevel == 6) {
                                                                   self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"皇冠认证"];
                                                               }else if (model.userBizAuth[1].authLevel == 7) {
                                                                   self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"金冠认证"];
                                                               }else if  (model.userBizAuth[1].authLevel == 8) {
                                                                   self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"一星白银团队"];
                                                               }else if (model.userBizAuth[1].authLevel == 9) {
                                                                   self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"二星黄金团队"];
                                                               }else if (model.userBizAuth[1].authLevel == 10) {
                                                                   self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"三星白金团队"];
                                                               }else if (model.userBizAuth[1].authLevel == 11) {
                                                                   self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"四星钻石团队"];
                                                               }else if (model.userBizAuth[1].authLevel == 12) {
                                                                   self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"五星大师团队"];
                                                               }else if (model.userBizAuth[1].authLevel == 13) {
                                                                   self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"六星皇冠团队"];
                                                               }else if (model.userBizAuth[1].authLevel == 14) {
                                                                   self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"七星至尊团队"];
                                                               }
                                                           }
                                                           
                                                       }
                                                       if (model.userBizAuth.count == 3) {
                                                           self.imageRZOne.hidden = NO;
                                                           self.imageRZtwo.hidden = NO;
                                                           self.imageRZthree.hidden = NO;
                                                           self.width.constant = 70;
                                                           
                                                           if (model.userBizAuth[0].authType == 1) {
                                                               
                                                               self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"平台认证1"];
                                                           }else if (model.userBizAuth[0].authType == 2){
                                                               self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"诚信认证1"];
                                                           }else {

                                                                   if (model.userBizAuth[0].authLevel == 1) {
                                                                       self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"初级认证"];
                                                                   }else if (model.userBizAuth[0].authLevel == 2) {
                                                                       self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"中级认证"];
                                                                   }else if (model.userBizAuth[0].authLevel == 3) {
                                                                       self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"高级认证"];
                                                                   }else if (model.userBizAuth[0].authLevel == 4) {
                                                                       self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"大师认证"];
                                                                   }else if (model.userBizAuth[0].authLevel == 5) {
                                                                       self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"总监认证"];
                                                                   }else if (model.userBizAuth[0].authLevel == 6) {
                                                                       self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"皇冠认证"];
                                                                   }else if (model.userBizAuth[0].authLevel == 7) {
                                                                       self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"金冠认证"];
                                                                   }else if (model.userBizAuth[0].authLevel == 8) {
                                                                       self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"一星白银团队"];
                                                                   }else if (model.userBizAuth[0].authLevel == 9) {
                                                                       self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"二星黄金团队"];
                                                                   }else if (model.userBizAuth[0].authLevel == 10) {
                                                                       self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"三星白金团队"];
                                                                   }else if (model.userBizAuth[0].authLevel == 11) {
                                                                       self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"四星钻石团队"];
                                                                   }else if (model.userBizAuth[0].authLevel == 12) {
                                                                       self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"五星大师团队"];
                                                                   }else if (model.userBizAuth[0].authLevel == 13) {
                                                                       self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"六星皇冠团队"];
                                                                   }else if (model.userBizAuth[0].authLevel == 14) {
                                                                       self.imageRZOne.image = [UIImage sd_animatedGIFNamed:@"七星至尊团队"];
                                                                   }
                                                               }

                                                           //dierge
                                                           if (model.userBizAuth[1].authType == 1) {
                                                               
                                                               self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"平台认证1"];
                                                           }else if (model.userBizAuth[1].authType == 2){
                                                               self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"诚信认证1"];
                                                           }else {
                                                               
                                                                   
                                                                   if (model.userBizAuth[1].authLevel == 1) {
                                                                       self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"初级认证"];
                                                                   }else if (model.userBizAuth[1].authLevel == 2) {
                                                                       self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"中级认证"];
                                                                   }else if (model.userBizAuth[1].authLevel == 3) {
                                                                       self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"高级认证"];
                                                                   }else if (model.userBizAuth[1].authLevel == 4) {
                                                                       self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"大师认证"];
                                                                   }else if (model.userBizAuth[1].authLevel == 5) {
                                                                       self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"总监认证"];
                                                                   }else if (model.userBizAuth[1].authLevel == 6) {
                                                                       self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"皇冠认证"];
                                                                   }else if (model.userBizAuth[1].authLevel == 7) {
                                                                       self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"金冠认证"];
                                                                   }else if (model.userBizAuth[1].authLevel == 8) {
                                                                       self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"一星白银团队"];
                                                                   }else if (model.userBizAuth[1].authLevel == 9) {
                                                                       self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"二星黄金团队"];
                                                                   }else if (model.userBizAuth[1].authLevel == 10) {
                                                                       self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"三星白金团队"];
                                                                   }else if (model.userBizAuth[1].authLevel == 11) {
                                                                       self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"四星钻石团队"];
                                                                   }else if (model.userBizAuth[1].authLevel == 12) {
                                                                       self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"五星大师团队"];
                                                                   }else if (model.userBizAuth[1].authLevel == 13) {
                                                                       self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"六星皇冠团队"];
                                                                   }else if (model.userBizAuth[1].authLevel == 14) {
                                                                       self.imageRZtwo.image = [UIImage sd_animatedGIFNamed:@"七星至尊团队"];
                                                                   }
                                                               }
                                                           //disange
                                                           //model.userBizAuth[1].authType == 1
                                                           if (model.userBizAuth[2].authType == 1) {
                                                               
                                                               self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"平台认证1"];
                                                           }else if (model.userBizAuth[2].authType == 2){
                                                               self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"诚信认证1"];
                                                           }else {
                                                               
                                                             
                                                                   if (model.userBizAuth[2].authLevel == 1) {
                                                                       self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"初级认证"];
                                                                   }else if (model.userBizAuth[2].authLevel == 2) {
                                                                       self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"中级认证"];
                                                                   }else if (model.userBizAuth[2].authLevel == 3) {
                                                                       self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"高级认证"];
                                                                   }else if (model.userBizAuth[2].authLevel == 4) {
                                                                       self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"大师认证"];
                                                                   }else if (model.userBizAuth[2].authLevel == 5) {
                                                                       self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"总监认证"];
                                                                   }else if (model.userBizAuth[2].authLevel == 6) {
                                                                       self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"皇冠认证"];
                                                                   }else if (model.userBizAuth[2].authLevel == 7) {
                                                                       self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"金冠认证"];
                                                                   }else if (model.userBizAuth[2].authLevel == 8) {
                                                                       self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"一星白银团队"];
                                                                   }else if (model.userBizAuth[2].authLevel == 9) {
                                                                       self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"二星黄金团队"];
                                                                   }else if (model.userBizAuth[2].authLevel == 10) {
                                                                       self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"三星白金团队"];
                                                                   }else if (model.userBizAuth[2].authLevel == 11) {
                                                                       self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"四星钻石团队"];
                                                                   }else if (model.userBizAuth[2].authLevel == 12) {
                                                                       self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"五星大师团队"];
                                                                   }else if (model.userBizAuth[2].authLevel == 13) {
                                                                       self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"六星皇冠团队"];
                                                                   }else if (model.userBizAuth[2].authLevel == 14) {
                                                                       self.imageRZthree.image = [UIImage sd_animatedGIFNamed:@"七星至尊团队"];
                                                                   }
                                                               }
                                                           }
                                                       if (model.userBizAuth.count == 0) {
                                                           self.fenView.hidden = YES;
                                                       }
                                                           
                                                       }
                                                   if (![[NSString stringWithFormat:@"%ld",model.bizDealCount] isBlankString]) {
                                                       int max = (int)model.bizDealCount;
                                                       int a = 0,b = 0,c = 0,d = 0;
                                                       a = max / 1250;
                                                       b = (max % 1250) / 250;
                                                       c = (max % 1250 % 250) / 50;
                                                       d = (max % 1250 % 250 % 50) / 10;
                                                       for (int i = 0; i < a + b + c + d; i ++) {
                                                           NSString *imageString;
                                                           
                                                           if (i > 8) {
                                                               break;
                                                           }
                                                           if (i < a) {
                                                               imageString = @"未标题-5";//zhi
                                                           }
                                                           if (a <= i  && i  < a + b) {
                                                               imageString = @"未标题-2";//huang
                                                           }
                                                           if (i  >= a + b && i <a + b + c) {
                                                               imageString = @"未标题-1";//zhuan
                                                           }
                                                           if (i  >= a + b + c && i < a + b + c + d) {
                                                               imageString = @"未标题-3";//xing
                                                           }
                                                           UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageString]];
                                                           
                                                           view.frame = CGRectMake(i * 15, 0, 13, 13);
                                                           
                                                           [self.starView addSubview:view];
                                                       }
                                                       if (max < 10 && max > 0) {
                                                           UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"未标题-3"]];
                                                           
                                                           view.frame = CGRectMake(0, 0, 13, 13);
                                                           
                                                           [self.starView addSubview:view];
                                                       }
                                                   }

//                                                   if (model.creditData.length == 0) {
//                                                           UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"未标题-3"]];
//                                                           
//                                                           view.frame = CGRectMake(15, 0, 13, 13);
//                                                           
//                                                           [self.starView addSubview:view];
//                                                       }
                                               }
                                                   
                                               
  
                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                               
                                            
                                               
                                           }];
    }
}

#pragma mark - 点击事件
/**
 提现

 @param sender 按钮
 */
- (IBAction)getMoney:(id)sender {
    
    [self pushToNextvcWithNextVCTitle:@"GetMoneyViewController"];
}

/**
 登录
 */
- (IBAction)login:(id)sender {
    LoginViewController *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    [self presentViewController:vc animated:YES completion:NULL];
    
}

- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        switch ([x integerValue]) {
            case 0:
                [self pushToNextvcWithNextVCTitle:@"CheckFriendsWeddingViewController"];
                break;
                
            case 1: {
                if (![UserData UserLoginState]) {
                    LoginViewController *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
                    [self presentViewController:vc animated:YES completion:NULL];
                    return;
                }
                [self pushToNextvcWithNextVCTitle:@"MyBanksViewController"];
            }
                break;
            case 2: {
                if (![UserData UserLoginState]) {
                    LoginViewController *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
                    [self presentViewController:vc animated:YES completion:NULL];
                    return;
                }
                [self pushToNextvcWithNextVCTitle:@"GetMoneyViewController"];
            }
                break;
            case 3: {
                    NSMutableString* str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"02862528708"];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                }
                
                break;
            case 4:
                [self pushToNextvcWithNextVCTitle:@"FeedBackViewController"];
                break;
            case 5:
                [self pushToNextvcWithNextVCTitle:@"AboutUsViewController"];
                break;
            default:
                break;
        }
    }];
}
- (IBAction)clickBtn:(UIButton *)sender {
    
    if (![UserData UserLoginState]) {
        LoginViewController *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        [self presentViewController:vc animated:YES completion:NULL];
        return;
    }
    switch (sender.tag) {
        case 100:{
			// 婚庆订单
            MyOrderSubViewController *vc = [[MyOrderSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }
            break;
        case 101:{
			// 商城订单
            ShopOrderSubViewController *vc = [[ShopOrderSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        } break;
        case 102: {
			// 关注页面
            MyConcernSubViewController *vc = [[MyConcernSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }
            
            break;
        case 103: {
			// 评价管理
            EvaluationManagementSubViewController *vc = [[EvaluationManagementSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }
            break;
        case 104: {
			// 服务
            MyOfferSubViewController *vc = [[MyOfferSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }
            break;
        case 105: {
            MyCaseSubViewController *vc = [[MyCaseSubViewController alloc] init];
            vc.titleColorSelected = MAINCOLOR;
            vc.menuViewStyle = WMMenuViewStyleLine;
            vc.automaticallyCalculatesItemWidths = YES;
            vc.progressWidth = 10;
            vc.progressViewIsNaughty = YES;
            vc.showOnNavigationBar = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:vc];
        }
            break;
        case 106:[self pushToNextvcWithNextVCTitle:@"MyInfoViewController"]; break;
        case 107:[self pushToNextvcWithNextVCTitle:@"ScheduleViewController"]; break;
        default:
            break;
    }
    
//    NSArray *nameArray = @[@"",@"ScheduleViewController",@"",@"EvaluationManagementSubViewController",@"",@""];
//    [self pushToNextvcWithNextVCTitle:nameArray[sender.tag - 100]];
}

#pragma mark - public api


#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    
//    [self.table registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineTableViewCell"];
//    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
//    self.table.emptyDataSetDelegate = self.viewModel;
//    self.table.emptyDataSetSource   = self.viewModel;
    /*
    @weakify(self);
    
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        [self.viewModel.refreshDataCommand execute:@{}];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    //传入参数 进行刷新
                    [self.viewModel.refreshDataCommand execute:@{}];
                }];
            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
        if (self.viewModel.dataArray.count < 10) {
            
            [self.table.mj_footer endRefreshingWithNoMoreData];
        } else {
            
            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
            
        }
        //    [self.tableView reloadEmptyDataSet];
        //刷新视图
        [self.table reloadData];
        
    }];
     */
}

//初始化viewModel
- (MineViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MineViewModel alloc] init];
    }
    return _viewModel;
}


@end
