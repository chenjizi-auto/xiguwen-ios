//
//  FatherViewController.h
//  Sahara
//
//  Created by huangcan on 15/5/20.
//  Copyright (c) 2015年 bodecn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImagePikerBlock)(UIImage *image);
typedef void (^VideoPickerBlock)(NSURL *urlStr);

@interface FatherViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong) UIView * navView;
@property (nonatomic, strong) UIButton * backBtn;

@property (copy,nonatomic) ImagePikerBlock imagePikerCallBack;
@property (copy,nonatomic) VideoPickerBlock videoPickerCallBack;


/**
 左边返回按钮
 */
- (void)addPopBackBtn;

/**
 在导航栏添加右边按钮

 @param title 按钮title
 @param image 按钮image
 */
- (void)addRightBtnWithTitle:(NSString *)title image:(NSString *)image;

/**
 显示加载提示语
 
 @param loading 提示语
 @param command 请求命令
 */
- (void)showLoadingWithLoading:(NSString *)loading command:(RACCommand *)command;
/**
 右边按钮
 
 @return 右边按钮
 */
- (UIButton *)rightBtn;

/**
 右边响应事件
 */
- (void)respondsToRightBtn;

//返回
- (void)popViewConDelay;

/**
 返回到导航控制器前面第几个控制器

 @param index 前面第几个
 */
- (void)popViewControllerAtLastIndex:(NSInteger)index;

//添加举报按钮
- (void)addReportRightButton;
- (void)pushReportVC;
/**
 返回上一级页面
 */
- (void)respondsToBackButton;
- (void)pushToNextVCWithNextVC:(UIViewController *)nextVC;
- (void)pushToNextvcWithNextVCTitle:(NSString *)nextVCTitle;


/**
 快速弹出Alert

 @param title  标题
 @param message message
 @param left 左边按钮文字
 @param right 右边文字
 @param block 返回点击哪个按钮   0左边，1右边
 */
- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                      left:(NSString *)left
                     right:(NSString *)right
                     block:(void (^)(NSInteger index))block;

/**
 *  照片，相机
 *
 *  @param title        标题
 *  @param imageEditing 是否可以编辑
 *  @param imageBlock   图片回调
 */
- (void)showImagePikerWithActionTitle:(NSString *)title imageEditing:(BOOL)imageEditing imageBlock:(ImagePikerBlock)imageBlock;

/**
 *  打开相册或者相机
 *
 *  @param sourceType   相册类型或者相机类型
 *  @param imageEditing 是否可以编辑
 *  @param imageBlock   图片回调
 */
- (void)openSystemPhotoAlbum:(UIImagePickerControllerSourceType)sourceType imageEditing:(BOOL)imageEditing imageBlock:(ImagePikerBlock)imageBlock;

/**
 *  自定义导航栏
 *
 *  @param title           标题
 *  @param backgroundColor 背景颜色
 *  @param leftButton      左按钮
 *  @param rigthButton     右按钮
 *  @param backBar         是否有返回按钮
 *  @param isWhite         导航栏是否需要白色返回按钮和title白色字体
 */
//-(void)addCustomNavBarTitle:(NSString *)title
//            backgroundColor:(UIColor *)backgroundColor
//                    leftBar:(UIButton *)leftButton
//                   rigthBar:(UIButton *)rigthButton whetherAddBackBar:(BOOL)backBar isWhite:(BOOL)isWhite;
-(void)addCustomNavBarTitle:(NSString *)title
                    leftBar:(UIButton *)leftButton
                   rigthBar:(UIButton *)rigthButton
          whetherAddBackBar:(BOOL)backBar;
//返回上一个控制器
- (void)backOnViewController;
//判断是否登录
- (void)isUserLogin:(void (^) (BOOL isLogin))login;

//改变圆角
- (void)changeRoundView:(UIView *)view radius:(CGFloat)radius;
//改变输入框占位符字体颜色
- (void)changeTextField:(UITextField *)textfield text:(NSString *)text color:(UIColor *)color;


/**
 选择视频
 
 @param vc 推送的控制器
 @param block 选择完成的回调
 */
//- (void)chooseVideoWithVc:(UIViewController *)vc block:(void(^)(UIImage *coverImage,id asset))block;

- (void)showVideoPikerWithActionTitle:(NSString *)title imageEditing:(BOOL)imageEditing videoBlock:(VideoPickerBlock)videoBlock;


- (UIToolbar *)addToolbar;
@end
