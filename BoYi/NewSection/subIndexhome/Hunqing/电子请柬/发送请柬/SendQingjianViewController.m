//
//  SendQingjianViewController.m
//  BoYi
//
//  Created by heng on 2018/1/1.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SendQingjianViewController.h"
#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

@interface SendQingjianViewController ()

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineOne;
@property (nonatomic, strong) UIImageView *coverImg;
@property (nonatomic, strong) UITextView *contentTV;
@property (nonatomic, strong) UIView *lineTwo;
@property (nonatomic, strong) UIView *lineThree;
@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation SendQingjianViewController

- (UIView *)mainView {
	if (!_mainView) {
		_mainView = [[UIView alloc] init];
		[_mainView setBackgroundColor:[UIColor whiteColor]];
	}
	return _mainView;
}

- (UILabel *)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] init];
		[_titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
	}
	return _titleLabel;
}
- (UIView *)lineOne {
	if (!_lineOne) {
		_lineOne = [[UIView alloc] init];
		[_lineOne setBackgroundColor:UIColorFromRGB(0xF0F0F2)];
	}
	return _lineOne;
}
- (UIImageView *)coverImg {
	if (!_coverImg) {
		_coverImg = [[UIImageView alloc] init];
		[_coverImg setUserInteractionEnabled:YES];
		[_coverImg setContentMode:(UIViewContentModeScaleAspectFill)];
		[_coverImg.layer setMasksToBounds:YES];
		// 添加点击事件
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedImage)];
		[_coverImg addGestureRecognizer:tap];
	}
	return _coverImg;
}
- (UITextView *)contentTV {
	if (!_contentTV) {
		_contentTV = [[UITextView alloc] init];
		[_contentTV setFont:[UIFont systemFontOfSize:15.0f]];
	}
	return _contentTV;
}
- (UIView *)lineTwo {
	if (!_lineTwo) {
		_lineTwo = [[UIView alloc] init];
		[_lineTwo setBackgroundColor:UIColorFromRGB(0xF0F0F2)];
	}
	return _lineTwo;
}
- (UIView *)lineThree {
	if (!_lineThree) {
		_lineThree = [[UIView alloc] init];
		[_lineThree setBackgroundColor:UIColorFromRGB(0xF0F0F2)];
	}
	return _lineThree;
}
- (UIButton *)cancelBtn {
	if (!_cancelBtn) {
		_cancelBtn = [[UIButton alloc] init];
		[_cancelBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
		[_cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
		[_cancelBtn addTarget:self action:@selector(cancelButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
	}
	return _cancelBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.view addSubview: self.mainView];
	self.mainView.sd_layout
	.bottomSpaceToView(self.view, 0.0f)
	.leftSpaceToView(self.view, 0.0f)
	.rightSpaceToView(self.view, 0.0f)
	.heightIs(420.0f);
	
	[self.mainView addSubview: self.titleLabel];
	self.titleLabel.sd_layout
	.topSpaceToView(self.mainView, 0.0f)
	.leftSpaceToView(self.mainView, 16.0f)
	.rightSpaceToView(self.mainView, 16.0f)
	.heightIs(50.0f);
	
	[self.mainView addSubview: self.lineOne];
	self.lineOne.sd_layout
	.topSpaceToView(self.titleLabel, 0.0f)
	.leftSpaceToView(self.mainView, 0.0f)
	.rightSpaceToView(self.mainView, 0.0f)
	.heightIs(1.0f);
	
	[self.mainView addSubview:self.coverImg];
	self.coverImg.sd_layout
	.topSpaceToView(self.lineOne, 16.0f)
	.leftSpaceToView(self.mainView, 16.0f)
	.widthIs(100.0f)
	.heightEqualToWidth();
	
	UILabel *tapLab = [[UILabel alloc] init];
	[tapLab setText:@"点击更换图片"];
	[tapLab setTextAlignment:NSTextAlignmentCenter];
	[tapLab setTextColor:[UIColor whiteColor]];
	[tapLab setBackgroundColor:[[UIColor clearColor] colorWithAlphaComponent:0.5]];
	[tapLab setFont:[UIFont systemFontOfSize:12.0f]];
	[self.coverImg addSubview: tapLab];
	tapLab.sd_layout
	.bottomSpaceToView(self.coverImg, 0.0f)
	.leftSpaceToView(self.coverImg, 0.0f)
	.rightSpaceToView(self.coverImg, 0.0f)
	.heightIs(20.0f);
	
	[self.mainView addSubview:self.contentTV];
	self.contentTV.sd_layout
	.centerYEqualToView(self.coverImg)
	.leftSpaceToView(self.coverImg, 20.0f)
	.rightSpaceToView(self.mainView, 16.0f)
	.heightIs(90.0f);
	
	[self.mainView addSubview:self.lineTwo];
	self.lineTwo.sd_layout
	.topSpaceToView(self.coverImg, 16.0f)
	.leftSpaceToView(self.mainView, 16.0f)
	.rightSpaceToView(self.mainView, 16.0f)
	.heightIs(1.0f);
	
	// 循环加载分享按钮
	NSArray *imageArr = @[@"朋友圈",@"微信好友",@"QQ好友",@"QQ空间",@"新浪微博"];
	for (NSInteger index = 0; index < 5; index ++) {
		UIButton *shareBtn = [[UIButton alloc] init];
		shareBtn.tag = index;
		[shareBtn setImage:[UIImage imageNamed:imageArr[index]] forState:(UIControlStateNormal)];
		[shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
		[self.mainView addSubview: shareBtn];
		shareBtn.sd_layout
		.centerXIs(ScreenWidth/8+(index%4)*ScreenWidth/4)
		.centerYIs(185+45+(index/4)*90)
		.widthIs(50.0f)
		.heightIs(80.0f);
	}
	
	[self.mainView addSubview: self.lineThree];
	self.lineThree.sd_layout
	.topSpaceToView(self.lineTwo, 180.0f)
	.leftSpaceToView(self.mainView, 0.0f)
	.rightSpaceToView(self.mainView, 0.0f)
	.heightIs(1.0f);
	
	[self.mainView addSubview:self.cancelBtn];
	self.cancelBtn.sd_layout
	.topSpaceToView(self.lineThree,0.0f)
	.leftSpaceToView(self.mainView, 0.0f)
	.rightSpaceToView(self.mainView, 0.0f)
	.heightIs(50.0f);
	
	// 绑定数据
	[self.titleLabel setText:[NSString stringWithFormat:@"%@&%@的婚礼请柬",self.model.xinlang,self.model.xinniang]];
	[self.coverImg sd_setImageWithUrl:self.model.cover];
	[self.contentTV setText:[NSString stringWithFormat:@"我们将在%@于%@举行婚礼，诚挚的邀请您的到来",[self stringForNSInteger:self.model.hunlitime],self.model.hunlidizhi]];
	
}

- (NSString *)stringForNSInteger:(NSInteger) time{
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	NSString *string = [formatter stringFromDate:date];
	return string;
}

- (void)selectedImage {
	// 切换图片
	WeakSelf(self);
	[self showImagePikerWithActionTitle: @"" imageEditing:YES imageBlock:^(UIImage *image) {
		
		[UIImage urlWithBase64Image:image complete:^(BOOL isSuccess, NSString *urlStr) {
			if (isSuccess) {
				weakSelf.model.cover = urlStr;
				[weakSelf.coverImg setImage:image];
			}
		}];
	}];
}

- (void)shareBtnClick:(UIButton *)sender {
	NSArray *array = @[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_Sina)];
	
	// 分享按钮点击事件
	UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
	//创建网页内容对象
	NSString* thumbURL =  self.model.cover;
	UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.titleLabel.text descr:self.contentTV.text thumImage:thumbURL];
	//设置网页地址
	shareObject.webpageUrl = [self.model.url stringByReplacingOccurrencesOfString:@"indexedit" withString:@"index"];//[NSString stringWithFormat:@"%@",@""];//url;
	//分享消息对象设置分享内容对象
	messageObject.shareObject = shareObject;
	WeakSelf(self);
	[[UMSocialManager defaultManager] shareToPlatform:[array[sender.tag] integerValue] messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
		if (error) {
			DLog(@"************Share fail with error %@*********",error);
			[NavigateManager showMessage:@"分享失败！"];
		}else {
			
			//                [CwShareManager shareSuccess:2];
			if ([data isKindOfClass:[UMSocialShareResponse class]]) {
				UMSocialShareResponse *resp = data;
				[NavigateManager showMessage:@"分享成功！"];
				//分享结果消息
				UMSocialLogInfo(@"response message is %@",resp.message);
				//第三方原始返回的数据
				UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
				
			}else{
				UMSocialLogInfo(@"response data is %@",data);
			}
		}
		
	}];
}

- (void)cancelButtonClick {
	// 	取消分享
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"iscleanData"];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)popaction:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"iscleanData"];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
