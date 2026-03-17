//
//  JoinDetilViewController.m
//  BoYi
//
//  Created by heng on 2018/1/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "JoinDetilViewController.h"
#import "MyXuqiuModel.h"

@interface JoinDetilViewController ()

@property (nonatomic, strong) PlayersModel *model;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chengxin;
@property (weak, nonatomic) IBOutlet UIImageView *pingtai;
@property (weak, nonatomic) IBOutlet UIImageView *xueyuan;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *pinglun;
@property (weak, nonatomic) IBOutlet UILabel *fensi;

@property (weak, nonatomic) IBOutlet UIImageView *followImg;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;


@end

@implementation JoinDetilViewController

- (PlayersModel *)model {
	if (!_model) {
		_model = [[PlayersModel alloc] init];
	}
	return _model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"参与详情";
    [self addPopBackBtn];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	// 数据请求
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_myDemandJoinDetails
										method:POST
										loding:@""
										   dic:@{@"cid":@(self.cid),
												 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   // 刷新数据
											   weakSelf.model = [PlayersModel mj_objectWithKeyValues:response[@"data"]];
											   [weakSelf updateView];
										   } else {
											   [NavigateManager showMessage: response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage: @"数据请求错误"];
									   }];
}

- (void)updateView {
	// 刷新界面
	[self.infoLabel setText:self.model.jdshuoming];
	[self.headerImg sd_setImageWithUrl:self.model.head];
	[self.nameLabel setText:self.model.nickname];
	[self.typeLabel setText:self.model.occupationid];
	[self.priceLabel setText:[NSString stringWithFormat:@"¥%ld起",self.model.minimumprice]];
	[self.chengxin setHidden:self.model.sincerity == 0 ? NO : YES];
	[self.pingtai setHidden:self.model.platform == 0 ? NO : YES];
	[self.xueyuan setHidden:self.model.college == 0 ? NO : YES];
	[self.scoreLabel setText:[NSString stringWithFormat:@"好评率 %ld%@",self.model.goodscore*100,@"%"]];
	[self.pinglun setText:[NSString stringWithFormat:@"评论 %ld",self.model.num]];
	[self.fensi setText:[NSString stringWithFormat:@"粉丝 %ld",self.model.pv]];
	
	
	[self.followImg setImage:[UIImage imageNamed:self.model.follow == 0 ? @"关注" : @"已关注"]];
	[self.followBtn setSelected: self.model.follow == 0 ? NO : YES];
	[self.joinBtn setBackgroundColor:self.model.status_j == 3 ? UIColorFromRGB(0xFF7299) : UIColorFromRGB(0xD9D9D9)];
	[self.joinBtn setUserInteractionEnabled:self.model.status_j == 3 ? YES : NO];
	
}

- (IBAction)selectedDetails:(UIButton *)sender {
	// 跳转商家详情页面(待完成)self.model里包含了你所需要的商家数据
    if (self.model.usertype == 2) { //婚庆
        NewShangjiaViewController *newshangjia = [[NewShangjiaViewController alloc] init];
        newshangjia.shopid = self.model.userid;
        [self pushToNextVCWithNextVC:newshangjia];
    }else { //商城
        ShangchengsjNewDetilViewController *vc = [[ShangchengsjNewDetilViewController alloc] init];
        vc.id = self.model.userid;
        [self pushToNextVCWithNextVC:vc];
    }
    
    
    
    
	
}

- (IBAction)sendMessage:(UIButton *)sender {
	// 发送消息
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms:%@",self.model.mobile]]];
    //im
    NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"user%ld",self.model.userid] type:NIMSessionTypeP2P];
    NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:session];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)makeCall:(UIButton *)sender {
	// 拨打电话
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.model.mobile]]];
}
- (IBAction)takeCare:(UIButton *)sender {
	// 是否关注
	sender.selected = !sender.selected;
	NSString *url = self.model.follow == 0 ? URL_ADDUserFollowById : URL_deleGuanzhu;
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:url
										method:POST
										loding:@""
										   dic:@{@"id":@(self.model.userid),
												 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   [NavigateManager showMessage: @"成功"];
											   weakSelf.model.follow = self.model.follow == 0 ? 1 : 0;
											   [weakSelf.followImg setImage:[UIImage imageNamed:weakSelf.model.follow == 0 ? @"关注" : @"已关注"]];
											   [weakSelf.followBtn setSelected: weakSelf.model.follow == 0 ? NO : YES];
										   } else {
											   [NavigateManager showMessage:response[@"message"]];
										   }
									   }
									   failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage: @"失败"];
									   }];
	
}
- (IBAction)joinWith:(UIButton *)sender {
	// 合作
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_myDemandCooperation
										method:POST
										loding:@""
										   dic:@{@"cid":@(self.model.cid),
												 @"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
											   [NavigateManager showMessage: @"合作成功"];
											   weakSelf.model.status_j = 1;
											   [weakSelf.joinBtn setBackgroundColor:weakSelf.model.status_j == 3 ? UIColorFromRGB(0xFF7299) : UIColorFromRGB(0xD9D9D9)];
											   [weakSelf.joinBtn setUserInteractionEnabled:weakSelf.model.status_j == 3 ? YES : NO];
										   } else {
											   [NavigateManager showMessage:response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage:@"合作失败"];
									   }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
