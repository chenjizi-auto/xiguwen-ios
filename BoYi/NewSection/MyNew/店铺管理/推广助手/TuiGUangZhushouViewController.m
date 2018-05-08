//
//  TuiGUangZhushouViewController.m
//  BoYi
//
//  Created by heng on 2018/1/22.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "TuiGUangZhushouViewController.h"
#import "WeChatPayManager.h"

@interface TuiGUangZhushouViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *robBtn;

@property (nonatomic, assign) BOOL isEnable;// 推广按钮是否可以点击

@end

@implementation TuiGUangZhushouViewController

#pragma mark - Setters and getters
- (UILabel *)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] init];
		[_titleLabel setFont: [UIFont systemFontOfSize:16.0f]];
		[_titleLabel setTextAlignment: NSTextAlignmentCenter];
//		[_titleLabel setTextColor: UIColorFromRGB(0x1E5A92)];
		[_titleLabel setTextColor: [UIColor whiteColor]];
	}
	return _titleLabel;
}

- (UILabel *)numLabel {
	if (!_numLabel) {
		_numLabel = [[UILabel alloc] init];
		[_numLabel setTextColor: [UIColor whiteColor]];
		[_numLabel setTextAlignment: NSTextAlignmentCenter];
	}
	return _numLabel;
}

- (UILabel *)timeLabel {
	if (!_timeLabel) {
		_timeLabel = [[UILabel alloc] init];
		[_timeLabel setFont: [UIFont systemFontOfSize:16.0f]];
		[_timeLabel setTextAlignment: NSTextAlignmentCenter];
//		[_timeLabel setTextColor:UIColorFromRGB(0x1E5A92)];
		[_timeLabel setTextColor: [UIColor whiteColor]];
	}
	return _timeLabel;
}

- (UIButton *)robBtn {
	if (!_robBtn) {
		_robBtn = [[UIButton alloc] init];
		[_robBtn.layer setCornerRadius:2.0f];
		[_robBtn.layer setMasksToBounds: YES];
		[_robBtn addTarget:self action:@selector(robBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
		[_robBtn setTitle:@"抢推广" forState:(UIControlStateNormal)];
		[_robBtn setTitle: @"已抢到" forState:(UIControlStateSelected)];
		[_robBtn setBackgroundColor:UIColorFromRGB(0xFFBE54)];
	}
	return _robBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"推广助手";
	
	[self.view addSubview: self.titleLabel];
	self.titleLabel.sd_layout
	.topSpaceToView(self.view, ScreenHeight/3)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(20.0f);
	
	[self.view addSubview: self.numLabel];
	self.numLabel.sd_layout
	.topSpaceToView(self.titleLabel, 20.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(80.0f);
	
	[self.view addSubview: self.timeLabel];
	self.timeLabel.sd_layout
	.topSpaceToView(self.numLabel, 20.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(20.0f);
	
	[self.view addSubview: self.robBtn];
	self.robBtn.sd_layout
	.bottomSpaceToView(self.view, 50.0f)
	.leftSpaceToView(self.view, 15.0f)
	.rightSpaceToView(self.view, 15.0f)
	.heightIs(40.0f);
	
	[self.titleLabel setText: @"广告位预定剩余数量"];
    
    [self addPopBackBtn];
    
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:ALIPAY_PAY_RESULT_NOTIFACATION object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        if ([x.object integerValue] == 9000) {
            [NavigateManager showMessage:@"抢购成功"];
            [self requestNum];
        }
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self requestNum];
}

#pragma mark - 抢推广点击事件
- (void)robBtnClick {
	WeakSelf(self);
	// 点击推广请求支付信息（并且在支付信息返回后改变状态）
	[[RequestManager sharedManager] requestUrl:URL_promotePay
										method:POST
										loding:@""
										   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
										   if ([response[@"code"] integerValue] == 0) {
//											   [NavigateManager showMessage:@"抢购成功"];
											   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
												   
												   DLog(@"支付数据--%@",response[@"data"]);
												   // 在这里得到支付信息之后直接跳转支付宝方法将支付数据传递给支付宝SDK(现在默认支付成功)
//                                                   weakSelf.isEnable = YES;
												   [weakSelf payWithData:response[@"data"]];
											   });

										   }else{
											   [NavigateManager showMessage:response[@"message"]];
										   }
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
//										   [NavigateManager showMessage: @"抢购失败"];
									   }];
}

- (void)payWithData:(id)data {
    
    [WeChatPayManager payWithType:1 info:data vc:self block:^(NSDictionary *response) {
        
    }];
}
#pragma mark - 广告位名额数据请求
- (void)requestNum {
	WeakSelf(self);
	[[RequestManager sharedManager] requestUrl:URL_promoteNum
										method:POST
										loding:@""
										   dic:@{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
												 @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)}
									  progress:nil
									   success:^(NSURLSessionDataTask *task, id response) {
                                           
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager hiddenLoadingMessage];
                                               
                                               NSInteger num = [response[@"sum"] integerValue];
                                               
                                               [weakSelf.numLabel setAttributedText:[weakSelf richText:[response[@"sum"] stringValue]]];
                                               [weakSelf.timeLabel setText: response[@"date"]];
                                               
                                               weakSelf.isEnable = [response[@"user"] integerValue] == 1;
                                               
                                               [weakSelf.robBtn setSelected: weakSelf.isEnable];
                                               [weakSelf.robBtn setEnabled: !weakSelf.isEnable];
                                               [weakSelf.robBtn setBackgroundColor: weakSelf.isEnable ? UIColorFromRGB(0xD9D9D9) : UIColorFromRGB(0xFFBE54)];
                                               if (num == 0) {
                                                   if ([response[@"user"] integerValue] != 0) {
                                                       //没抢到
                                                       [weakSelf.robBtn setSelected: YES];
                                                       [weakSelf.robBtn setEnabled: NO];
                                                       [weakSelf.robBtn setTitle:@"已抢完" forState:UIControlStateNormal];
                                                       [weakSelf.robBtn setBackgroundColor:UIColorFromRGB(0xD9D9D9)];
                                                   }
                                               }
                                               
                                               
                                               
                                           } else {
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
										   
									   } failure:^(NSURLSessionDataTask *task, NSError *error) {
										   [NavigateManager showMessage:error.localizedDescription];
									   }];
}

#pragma mark - 富文本
- (NSMutableAttributedString *)richText:(NSString *)str {
	str = [str stringByAppendingString: @"个"];
	NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
	[attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:60.0f] range:NSMakeRange(0, str.length-1)];
	return attributedStr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
