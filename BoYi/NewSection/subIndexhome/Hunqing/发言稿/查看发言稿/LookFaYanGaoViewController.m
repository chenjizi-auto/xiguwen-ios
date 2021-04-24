//
//  LookFaYanGaoViewController.m
//  BoYi
//
//  Created by heng on 2018/1/3.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "LookFaYanGaoViewController.h"
#import "ZLHTTPSessionManager.h"
#import "ZLShareFaYanGaoViewController.h"

@interface LookFaYanGaoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textvieww;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baseViewHeight;
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeightConstraints;

@end

@implementation LookFaYanGaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topHeightConstraints.constant = UIApplication.sharedApplication.statusBarFrame.size.height == 20.0 ? self.topHeightConstraints.constant : -100.0;
    self.navigationItem.title = @"婚礼宝典" ;
    [self addPopBackBtn];
    [self addRightBtnWithTitle:@"分享" image:nil];
	[self.titleLabel setText:self.model.title];
    self.textvieww.text = self.model.content;
    if (isIPhoneX) {
        self.height.constant = 107;
    }
	
	self.baseView.layer.cornerRadius = 5;
	self.baseView.layer.masksToBounds = YES;
	self.textvieww.sd_layout.autoHeightRatio(0);
	// 设置高度
	[self.baseView setupAutoHeightWithBottomView:self.textvieww bottomMargin:10.0f];
	
//	[self layoutSubviews];
}

//- (void)layoutSubviews {
//	self.baseViewHeight.constant = self.textvieww.height+20;
////	[self.baseView setNeedsLayout];
//}

- (void)respondsToRightBtn {
    __weak typeof(self)weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[@"id"] = @(self.model.id);
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/share/hunlibaodian" Params:params POST:YES ModelArray:nil HttpHeader:NO Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            NSDictionary *dataDict = responseObject[@"data"];
            if ([dataDict isKindOfClass:[NSDictionary class]]) {
                if (dataDict.count) {
                    ZLShareFaYanGaoViewController *shareFaYanGaoVc = [ZLShareFaYanGaoViewController new];
                    shareFaYanGaoVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                    shareFaYanGaoVc.imageUrl = dataDict[@"image"];
                    shareFaYanGaoVc.titleString = dataDict[@"title"];
                    shareFaYanGaoVc.content = dataDict[@"descr"];
                    shareFaYanGaoVc.htmlUrl = dataDict[@"url"];
                    [weakSelf presentViewController:shareFaYanGaoVc animated:NO completion:nil];
                }
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
