//
//  FatherViewController.m
//  Sahara
//
//  Created by huangcan on 15/5/20.
//  Copyright (c) 2015年 bodecn. All rights reserved.
//

#import "FatherViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <SGNavigationProgress/UINavigationController+SGProgress.h>
//#import "ZMMonitorKeyBoder.h"

@interface FatherViewController ()


@end

@implementation FatherViewController

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
//        [self.navigationController setNavigationBarHidden:YES];
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    [ZMMonitorKeyBoder manager];
    // Do any additional setup after loading the view
//    [self.navigationController setNavigationBarHidden:YES];
//    [self.navigationController.navigationBar setBarTintColor:MAINCOLOR];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)changeTile{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DLog(@"Ó%@",NSStringFromClass([self class]));
    //统计计数
//    [MobClick beginLogPageView:NSStringFromClass([self class])];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //统计计数
//    [MobClick endLogPageView:NSStringFromClass([self class])];
}



/**
 显示加载提示语

 @param loading 提示语
 @param command 请求命令
 */
- (void)showLoadingWithLoading:(NSString *)loading command:(RACCommand *)command {
    
    
    @weakify(self);
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([x integerValue] == 1) {
                MBProgressHUD *mb = [[MBProgressHUD alloc] initWithView:self.view];
                mb.animationType = MBProgressHUDAnimationFade;
                mb.mode = MBProgressHUDModeText;
//                mb.label.text = loading;
//                [mb showAnimated:YES];
            } else {
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        });
        
        
        
    }];
}
- (void)setNavigationTitle:(NSString *)title
              leftBarTitle:(NSString *)leftButtonTitle
             rigthBarTitle:(NSString *)rigthButtonTitle
         whetherAddBackBar:(BOOL)backBar{
    
    self.navigationItem.title = title;
    if (backBar) {
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
        backBtn.backgroundColor = [UIColor clearColor];
        [backBtn setImage:[UIImage imageNamed:@"back-白色"] forState:UIControlStateNormal];
        
        [backBtn addTarget:self action:@selector(backOnViewController)forControlEvents:UIControlEventTouchUpInside];
    }
    if (rigthButtonTitle) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:leftButtonTitle style:UIBarButtonItemStyleDone target:self action:@selector(leftBtnAction)];
    }
    if (leftButtonTitle) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:leftButtonTitle style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnAction)];
    }
}
-(void)leftBtnAction{
    
}
-(void)rightBtnAction{
    
}
//返回按钮
- (UIButton *)addBackBtn {
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(popViewConDelay)forControlEvents:UIControlEventTouchUpInside];
    return backBtn;
}
//
- (void)addPopBackBtn {
    
    UIBarButtonItem *placeBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    placeBarButton.width = -10;
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"返回(red)"] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(popViewConDelay)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItems = @[placeBarButton,bar];
}
- (void)addRightBtnWithTitle:(NSString *)title image:(NSString *)image {
    
    UIBarButtonItem *placeBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    placeBarButton.width = -10;
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
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

- (UIButton *)rightBtn {
    UIButton *btn = (UIButton *)[self.navigationItem.rightBarButtonItems[1] customView];
    return btn;
}


- (void)popViewConDelay
{
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

- (void)popViewControllerAtLastIndex:(NSInteger)index {
    NSInteger count = self.navigationController.viewControllers.count;
    [self.navigationController popToViewController:self.navigationController.viewControllers[count - index] animated:YES];
}

- (void)respondsToRightBtn {
    
}


-(void)addCustomNavBarTitle:(NSString *)title
                    leftBar:(UIButton *)leftButton
                   rigthBar:(UIButton *)rigthButton
          whetherAddBackBar:(BOOL)backBar
{
    BOOL isWhite = YES;
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.backgroundColor = RGBA(255, 83, 132, 1);
    [self.view addSubview:_navView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_navView.center.x - 80, 20, 160, 44)];
    titleLabel.text = title;
    
    if (isWhite) {
        titleLabel.textColor = [UIColor whiteColor];
    }else{
        titleLabel.textColor = RGBA(15, 51, 68, 1);
    }
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_navView addSubview:titleLabel];
    
    if (leftButton && backBar == NO) {
        leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        leftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
//        leftButton.titleLabel.textColor = [UIColor whiteColor];
        leftButton.frame = CGRectMake(0, 20, 44, 44);
        [_navView addSubview:leftButton];
    } else if (backBar == YES) {
        [_navView addSubview:[self addBackBtnWithIsWhite:isWhite]];
    } else if (backBar == YES && leftButton) {
        [_navView addSubview:[self addBackBtnWithIsWhite:isWhite]];
        leftButton.frame = CGRectMake(45, 20, 40, 40);
    }
    if (rigthButton) {
        rigthButton.titleLabel.textColor = [UIColor whiteColor];
//        rigthButton.titleLabel.font = [UIFont systemFontOfSize:16];
        
        CGFloat width = [rigthButton.titleLabel.text sizeWithFont:rigthButton.titleLabel.font Size:CGSizeMake(100, 44)].width;
        CGFloat buttonWidth = width > 44 ? width + 20 : 44;
        rigthButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        rigthButton.frame = CGRectMake(ScreenWidth - buttonWidth, 20, buttonWidth, 44);
        [_navView addSubview:rigthButton];
    }
}
//左返回按钮
- (UIButton *)addBackBtnWithIsWhite:(BOOL)isWhite {
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    _backBtn.backgroundColor = [UIColor clearColor];
    if (isWhite) {
        [_backBtn setImage:[UIImage imageNamed:@"back-白色"] forState:UIControlStateNormal];
    }else{
        [_backBtn setImage:[UIImage imageNamed:@"back-墨绿"] forState:UIControlStateNormal];
    }
    [_backBtn addTarget:self action:@selector(backOnViewController)forControlEvents:UIControlEventTouchUpInside];
    return _backBtn;
}


- (void)backOnViewController
{
    if ([self.navigationController respondsToSelector:@selector(pushViewController:animated:)]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)setTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor redColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationItem.titleView      = titleLabel;
}


//添加举报按钮
- (void)addReportRightButton
{
    UIButton *reportBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 44, 20, 44, 44)];
    reportBtn.backgroundColor = [UIColor clearColor];
    reportBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [reportBtn setTitleColor:RGBA(15, 51, 68, 1) forState:UIControlStateNormal];
    [reportBtn setTitle:@"举报" forState:UIControlStateNormal];
    [reportBtn addTarget:self action:@selector(pushReportVC)forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:reportBtn];
}

- (void)pushReportVC
{
    
}

/**
 返回上一级页面
 */
- (void)respondsToBackButton {
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
}
- (void)pushToNextVCWithNextVC:(UIViewController *)nextVC {
//    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}
- (void)pushToNextvcWithNextVCTitle:(NSString *)nextVCTitle {
    
    id vc = [[NSClassFromString(nextVCTitle) alloc]init];
    if ([vc isKindOfClass:[UIViewController class]]) {
        ((UIViewController *)vc).hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 公共
- (void)changeRoundView:(UIView *)view radius:(CGFloat)radius
{
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
}

- (void)changeTextField:(UITextField *)textfield text:(NSString *)text color:(UIColor *)color
{
    textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:color}];
}

- (void)isUserLogin:(void (^)(BOOL))login
{
    if (TOKEN) {
        login(YES);
    }else{
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        loginVC.isLoginSuccessful = ^(BOOL islogin){
//            if (islogin == YES) {
//                login(islogin);
//            }
//        };
//        [[self myViewController] presentViewController:[[BaseNavigationViewController alloc] initWithRootViewController:loginVC] animated:YES completion:nil];
    }
    
}
- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                      left:(NSString *)left
                     right:(NSString *)right
                     block:(void (^)(NSInteger index))block {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *photographicAction = [UIAlertAction actionWithTitle:left
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                   block(0);
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:right
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            block(1);
    }];
    [alertController addAction:photographicAction];
    [alertController addAction:photoAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - 图片选择器
- (void)showImagePikerWithActionTitle:(NSString *)title imageEditing:(BOOL)imageEditing imageBlock:(ImagePikerBlock)imageBlock {
    self.imagePikerCallBack = imageBlock;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photographicAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openSystemPhotoAlbum:UIImagePickerControllerSourceTypeCamera imageEditing:imageEditing imageBlock:imageBlock];
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openSystemPhotoAlbum:UIImagePickerControllerSourceTypePhotoLibrary imageEditing:imageEditing imageBlock:imageBlock];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:photographicAction];
    [alertController addAction:photoAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 视频选择器
- (void)showVideoPikerWithActionTitle:(NSString *)title imageEditing:(BOOL)imageEditing videoBlock:(VideoPickerBlock)videoBlock {
	self.videoPickerCallBack = videoBlock;
	
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	UIAlertAction *photographicAction = [UIAlertAction actionWithTitle:@"录像" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[self openSystemVideo:UIImagePickerControllerSourceTypeCamera videoEditing:YES videoBlock:videoBlock];
		
//		UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
//		pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//		pickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
//		pickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
//		pickerController.videoQuality = UIImagePickerControllerQualityType640x480;
//		pickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
//		pickerController.allowsEditing = YES;
//
//		[self presentViewController:pickerController animated:YES completion:nil];
		
	}];
	UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从视频库中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[self openSystemVideo:UIImagePickerControllerSourceTypePhotoLibrary videoEditing:YES videoBlock:videoBlock];
//		UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
//		pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//		pickerController.mediaTypes = @[(NSString *)kUTTypeMovie];
//		pickerController.allowsEditing = NO;
//
//		[self presentViewController:pickerController animated:YES completion:nil];
	}];
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
	[alertController addAction:photographicAction];
	[alertController addAction:photoAction];
	[alertController addAction:cancelAction];
	[self presentViewController:alertController animated:YES completion:nil];
}

- (void)openSystemVideo:(UIImagePickerControllerSourceType)sourceType videoEditing:(BOOL)videoEditing videoBlock:(VideoPickerBlock)videoBlock {
	self.videoPickerCallBack = videoBlock;
	if (sourceType == UIImagePickerControllerSourceTypeCamera && ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备不支持拍照！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alert show];
		return;
	}
	
	NSString *mediaType = AVMediaTypeVideo;
	
	AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
	
	if(authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied){
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在iPhone的”设置-隐私-相机“选项中允许零阅使用相机权限" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alert show];
		return;
		
	}
	
	UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
	pickerController.delegate = self;
	pickerController.sourceType = sourceType;
	pickerController.mediaTypes = @[(NSString *)kUTTypeMovie];
	pickerController.allowsEditing = videoEditing;
	pickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentViewController:pickerController animated:YES completion:nil];
}

/**
 *打开相册或者相机
 *
 */
- (void)openSystemPhotoAlbum:(UIImagePickerControllerSourceType)sourceType imageEditing:(BOOL)imageEditing imageBlock:(ImagePikerBlock)imageBlock
{
    self.imagePikerCallBack = imageBlock;
    if (sourceType == UIImagePickerControllerSourceTypeCamera && ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备不支持拍照！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSString *mediaType = AVMediaTypeVideo;
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied){
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在iPhone的”设置-隐私-相机“选项中允许零阅使用相机权限" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
        
    }
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    pickerController.sourceType = sourceType;
	pickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    pickerController.allowsEditing = imageEditing;
    pickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:pickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
	
	//获取用户选择或拍摄的是照片还是视频
	NSString *mediaType = info[UIImagePickerControllerMediaType];
	
	if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
		if (picker.allowsEditing) {
			self.imagePikerCallBack(info[@"UIImagePickerControllerEditedImage"]);
		}else{
			self.imagePikerCallBack(info[@"UIImagePickerControllerOriginalImage"]);
			//获取照片名称（例：IMG_0001.JPG）
			//        __block NSString *imageFileName;
			//        NSURL *imageURL = info[@"UIImagePickerControllerReferenceURL"];
			//        ALAssetsLibraryAssetForURLResultBlock resultBlock = ^(ALAsset *myAssset){
			//            ALAssetRepresentation *representation = [myAssset defaultRepresentation];
			//            imageFileName = [representation filename];
			//            NSLog(@"%@",imageFileName);
			//        };
			//
			//        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
			//        [assetsLibrary assetForURL:imageURL resultBlock:resultBlock failureBlock:nil];
			
		}
		
	} else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
//		if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
		
			//如果是拍摄的视频, 则把视频保存在系统多媒体库中(此时保存的只是视频路径地址)
//			NSLog(@"video path: %@", info[UIImagePickerControllerMediaURL]);
		DLog(@"%@",info[@"UIImagePickerControllerMediaURL"]);
		self.videoPickerCallBack(info[@"UIImagePickerControllerMediaURL"]);
	}
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 获取当前屏幕显示的viewcontroller
- (UIViewController *)myViewController {
    // 定义一个变量存放当前屏幕显示的viewcontroller
    UIViewController *result = nil;
    // 得到当前应用程序的主要窗口
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    // windowLevel是在 Z轴 方向上的窗口位置，默认值为UIWindowLevelNormal
    if (window.windowLevel != UIWindowLevelNormal)    {
        // 获取应用程序所有的窗口
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)        {
            // 找到程序的默认窗口（正在显示的窗口）
            if (tmpWin.windowLevel == UIWindowLevelNormal)            {
                // 将关键窗口赋值为默认窗口
                window = tmpWin;
                break;
            }
        }
    }
    // 获取窗口的当前显示视图
    UIView *frontView = [[window subviews] objectAtIndex:0];
    // 获取视图的下一个响应者，UIView视图调用这个方法的返回值为UIViewController或它的父视图
    id nextResponder = [frontView nextResponder];
    // 判断显示视图的下一个响应者是否为一个UIViewController的类对象
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
//        UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
//        while (topVC.presentedViewController) {
//            topVC = topVC.presentedViewController;
//        }
//    
//        return topVC;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
}
    
- (void)dealloc
{
    DLog(@"页面销毁%@",self);
}
//取消第一响应者
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (UIToolbar *)addToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 35)];
    toolbar.tintColor = MAINCOLOR;
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space, bar];
    return toolbar;
}
- (void)textFieldDone{
    [self.view endEditing:YES];
}

//#pragma mark - 网络请求

@end
