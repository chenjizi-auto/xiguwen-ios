//
//  XuanzheMusicSubVC.m
//  BoYi
//
//  Created by heng on 2017/12/31.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "XuanzheMusicSubVC.h"
#import "XuanZeMusicViewController.h"

#define DataArray

@interface XuanzheMusicSubVC ()

@end

@implementation XuanzheMusicSubVC

- (NSMutableArray *)dataArray {
	if (!_dataArray) {
		_dataArray = [[NSMutableArray alloc] init];
		_dataArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"MusicTypeList"];
	}
	return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择音乐";
    [self addPopBackBtn];
    [self addRightBtnWithTitle:@"保存" image:nil];
	
	
	
}
- (void)addRightBtnWithTitle:(NSString *)title image:(NSString *)image {
    
    UIBarButtonItem *placeBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    placeBarButton.width = -10;
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 64, 44)];
    [backBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    backBtn.backgroundColor = [UIColor clearColor];
    if (image) {
        [backBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (title) {
        [backBtn setTitle:title forState:UIControlStateNormal];
    }
    [backBtn addTarget:self action:@selector(respondsToRightBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItems = @[placeBarButton,bar];
}
- (void)respondsToRightBtn{
	
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"MusicID"]) {
        [NavigateManager showMessage:@"请选择音乐"];
        return;
    }
	// 更换背景音乐请求
	
    NSDictionary *dic = @{@"token":[UserDataNew sharedManager].userInfoModel.token.token,
						  @"userid":@([UserDataNew sharedManager].userInfoModel.token.userid),
						  @"mid":@(self.model.id),
						  @"yid":[[NSUserDefaults standardUserDefaults] objectForKey:@"MusicID"]};
    [[RequestManager sharedManager] requestUrl:URL_New_musicshezhi
                                        method:POST
                                        loding:@"正在保存"
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showLoadingMessage:@"保存成功"];
//                                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                                                   [self popViewConDelay];;
//                                               });
                                           }else {
                                               [NavigateManager hiddenLoadingMessage];
                                           }
                                           
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager hiddenLoadingMessage];
                                       }];
}

- (void)addPopBackBtn {
    
    UIBarButtonItem *placeBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    placeBarButton.width = -10;
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0,10);
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"返回(red)"] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(popViewConDelay)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItems = @[placeBarButton,bar];
}
- (void)popViewConDelay
{
	WeakSelf(self);
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:^{
			weakSelf.onDidReload();
        }];
	} else {
		weakSelf.onDidReload();
	}
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return self.dataArray.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return [self.dataArray[index] objectForKey:@"title"];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    XuanZeMusicViewController *vc = [[XuanZeMusicViewController alloc] init];
    vc.statusFlag = [[self.dataArray[index] objectForKey:@"id"] integerValue];
    return vc;
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    return CGRectMake(leftMargin, originY, self.view.frame.size.width - 2*leftMargin, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
        originY += 2;
    }
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

@end
