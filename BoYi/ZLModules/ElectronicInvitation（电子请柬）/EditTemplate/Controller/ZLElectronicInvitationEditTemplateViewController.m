//
//  ZLElectronicInvitationEditTemplateViewController.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/7.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationEditTemplateViewController.h"
#import "ZLElectronicInvitationEditTemplateView.h"
#import "ZLElectronicInvitationSelectMusicViewController.h"
#import "ZLElectronicInvitationEditTemplateSelectImage.h"
#import "ZLElectronicInvitationPreviewInvitationViewController.h"
#import "ZLElectronicInvitationEditTemplateTailorImage.h"
#import "ZLElectronicInvitationNavBar.h"

@interface ZLElectronicInvitationEditTemplateViewController ()<ZLElectronicInvitationEditTemplateSelectImageDelegate>

///主视图
@property (nonatomic,weak) ZLElectronicInvitationEditTemplateView *editTemplateView;
///持有数据
@property (nonatomic,strong) ZLElectronicInvitationEditTemplateModel *infoModel;
///导航条（自定义）
@property (nonatomic,weak) ZLElectronicInvitationNavBar *navBar;
///选择图片
@property (nonatomic,strong) ZLElectronicInvitationEditTemplateSelectImage *selectImageManager;

@end

@implementation ZLElectronicInvitationEditTemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self addSubviews];
    [self editTemplateData];
    [self navBar];
}

#pragma mark - Add
- (void)addSubviews {
    ZLElectronicInvitationEditTemplateView *editTemplateView = [[ZLElectronicInvitationEditTemplateView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:editTemplateView];
    self.editTemplateView = editTemplateView;
    //初始化模型
    ZLElectronicInvitationEditTemplateModel *infoModel = [ZLElectronicInvitationEditTemplateModel new];
    infoModel.userId = self.userId;
    infoModel.token = self.token;
    infoModel.keyId = self.keyId;
    infoModel.isFromPreviewTemplateEnter = self.isFromPreviewTemplateEnter;
    self.infoModel = infoModel;
    //导航项
    [self removeViewControllers];
    //修改图片
    __weak typeof(self)weakSelf = self;
    editTemplateView.changeImageAction = ^ {
        [weakSelf.selectImageManager updateHeadPictureWithDelegate:weakSelf];
    };
    //保存文本
    editTemplateView.saveTextAction = ^ {
        [weakSelf saveTemplateData];
    };
    //底部功能
    editTemplateView.bottomFunctionAction = ^(ZLEditTemplateFunction type) {
        if (type == ZLEditTemplateFunctionDeleteInvitation//删除电子请柬
            || type == ZLEditTemplateFunctionDeletePage) {//删除当前页面
            NSString *message = type == ZLEditTemplateFunctionDeleteInvitation ? @"确定要删除当前的电子请柬？" : @"确定要删除当前页？";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
            [alert addAction:cancelAction];
            UIAlertAction *dleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
                weakSelf.editTemplateView.showHud = YES;
                type == ZLEditTemplateFunctionDeleteInvitation
                ? [weakSelf deleteInvitation]
                : [weakSelf deletePage];
            }];
            [alert addAction:dleteAction];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else if (type == ZLEditTemplateFunctionPreview) {//预览
            if (!weakSelf.infoModel.sharetime) {
                weakSelf.editTemplateView.errorMessage = @"加载失败，请重试……";
                return;
            }
            if (weakSelf.isFromPreviewTemplateEnter) {
                [weakSelf gotoPreview];
                return;
            }
            [weakSelf goBackPreview];
        }
    };
}

#pragma mark - Set
- (void)setInfoModel:(ZLElectronicInvitationEditTemplateModel *)infoModel {
    _infoModel = infoModel;
    self.editTemplateView.infoModel = infoModel;
}

#pragma mark - Lazy
- (ZLElectronicInvitationNavBar *)navBar {
    if (!_navBar) {
        ZLElectronicInvitationNavBar *navBar = [[ZLElectronicInvitationNavBar alloc] init];
        NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"返回按钮.png"];
        [navBar.goBackButton setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        __weak typeof(self)weakSelf = self;
        navBar.goBack = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:@"音乐按钮.png"];
        [navBar.rightButton setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        navBar.rightAction = ^{
            [weakSelf rightBarButtonItemAction];
        };
        [self.view addSubview:navBar];
        _navBar = navBar;
    }
    return _navBar;
}
- (ZLElectronicInvitationEditTemplateSelectImage *)selectImageManager {
    if (!_selectImageManager) {
        _selectImageManager = [ZLElectronicInvitationEditTemplateSelectImage new];
    }
    return _selectImageManager;
}

#pragma mark - Action
- (void)rightBarButtonItemAction {
    if (!self.infoModel.invitationId) {
        self.editTemplateView.errorMessage = @"加载失败，请重试……";
        return;
    }
    ZLElectronicInvitationSelectMusicViewController *selectMusicVc = [ZLElectronicInvitationSelectMusicViewController new];
    selectMusicVc.keyId = self.infoModel.invitationId;
    selectMusicVc.userId = self.userId;
    selectMusicVc.token = self.token;
    if (self.infoModel.currentMusicModel) {
        ZLElectronicInvitationSelectMusicModel *currentMusicModel = [ZLElectronicInvitationSelectMusicModel new];
        currentMusicModel.keyId = self.infoModel.currentMusicModel.keyId;
        currentMusicModel.musicUrl = self.infoModel.currentMusicModel.musicUrl;
        selectMusicVc.musicModel = currentMusicModel;
    }
    __weak typeof(self)weakSelf = self;
    //选中的音乐模型 Note:会有空值的情况，如果用户没有选择音乐却点击了保存，则当前模型为空。
    selectMusicVc.clickRow = ^(ZLElectronicInvitationSelectMusicModel *musicModel) {
        ZLElectronicInvitationEditTemplateModel *model = [ZLElectronicInvitationEditTemplateModel new];
        model.keyId = musicModel.keyId;
        model.musicUrl = musicModel.musicUrl;
        weakSelf.infoModel.currentMusicModel = model;
    };
    [self.navigationController pushViewController:selectMusicVc animated:YES];
}

#pragma mark - Separate
- (void)gotoPreview {
    if (!self.infoModel.invitationId) {
        self.editTemplateView.errorMessage = @"加载失败，请重试……";
        return;
    }
    ZLElectronicInvitationPreviewInvitationViewController *previewInvitationVc = [ZLElectronicInvitationPreviewInvitationViewController new];
    previewInvitationVc.keyId = self.infoModel.invitationId;
    previewInvitationVc.htmlUrl = self.infoModel.invitationUrl;
    previewInvitationVc.shareurl = self.infoModel.shareurl;
    previewInvitationVc.userId = self.userId;
    previewInvitationVc.sharetime = self.infoModel.sharetime;
    previewInvitationVc.token = self.token;
    previewInvitationVc.isFromEditPageEnter = YES;
    [self.navigationController pushViewController:previewInvitationVc animated:YES];
}
- (void)goBackPreview {
    for (NSInteger index = 0; index < self.navigationController.childViewControllers.count; index++) {
        UIViewController *viewController = self.navigationController.childViewControllers[index];
        if ([viewController isKindOfClass:[ZLElectronicInvitationPreviewInvitationViewController class]]) {
            ZLElectronicInvitationPreviewInvitationViewController *previewInvitationVc = (ZLElectronicInvitationPreviewInvitationViewController *)viewController;
            previewInvitationVc.sharetime = self.infoModel.sharetime;
            previewInvitationVc.shareurl = self.infoModel.shareurl;
            [self.navigationController popToViewController:previewInvitationVc animated:YES];
        }
    }
}
- (void)removeViewControllers {
    if (self.isFromPreviewTemplateEnter) {
        NSMutableArray *viewControllersM = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        //这个循环不加break时一次也只能干掉一个viewController。所以我就循环了两次
        for (NSInteger index = 0; index < viewControllersM.count; index++) {
            UIViewController *viewController = viewControllersM[index];
            if ([viewController isKindOfClass:NSClassFromString(@"ZLElectronicInvitationSelectTemplateViewController")]
                || [viewController isKindOfClass:NSClassFromString(@"ZLElectronicInvitationPreviewTemplateViewController")]) {
                [viewControllersM removeObjectAtIndex:index];
                break;
            }
        }
        for (NSInteger index = 0; index < viewControllersM.count; index++) {
            UIViewController *viewController = viewControllersM[index];
            if ([viewController isKindOfClass:NSClassFromString(@"ZLElectronicInvitationSelectTemplateViewController")]
                || [viewController isKindOfClass:NSClassFromString(@"ZLElectronicInvitationPreviewTemplateViewController")]) {
                [viewControllersM removeObjectAtIndex:index];
                break;
            }
        }
        self.navigationController.viewControllers = viewControllersM;
    }
}

#pragma mark - Request
- (void)editTemplateData {
    __weak typeof(self)weakSelf = self;
    [ZLElectronicInvitationEditTemplateModel editTemplateDataWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState) {
        if (!sessionErrorState) {
            weakSelf.infoModel = weakSelf.infoModel;
        }
    }];
}
- (void)saveTemplateData {
    __weak typeof(self)weakSelf = self;
    [ZLElectronicInvitationEditTemplateModel changeEditTemplateDataWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage) {
        weakSelf.editTemplateView.showHud = NO;
        if (errorMessage) {
            weakSelf.editTemplateView.errorMessage = errorMessage;
            return ;
        }
        if (!sessionErrorState) {
            
            return;
        }
    }];
}
- (void)deleteInvitation {
    if (!self.infoModel.invitationId) {
        self.editTemplateView.errorMessage = @"加载失败，请重试……";
        return;
    }
    __weak typeof(self)weakSelf = self;
    [ZLElectronicInvitationEditTemplateModel deleteEditTemplateDataWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage) {
        weakSelf.editTemplateView.showHud = NO;
        if (errorMessage) {
            weakSelf.editTemplateView.errorMessage = errorMessage;
            return ;
        }
        if (!sessionErrorState) {
            for (NSInteger index = 0; index < weakSelf.navigationController.childViewControllers.count; index++) {
                UIViewController * viewController = weakSelf.navigationController.childViewControllers[index];
                if ([viewController isKindOfClass:[NSClassFromString(@"ZLElectronicInvitationHomeViewController") class]]) {
                    [weakSelf.navigationController popToViewController:viewController animated:YES];
                }
            }
            return;
        }
    }];
}
- (void)deletePage {
    if (!self.infoModel.invitationId) {
        self.editTemplateView.errorMessage = @"加载失败，请重试……";
        return;
    }
    __weak typeof(self)weakSelf = self;
    [ZLElectronicInvitationEditTemplateModel deleteEditTemplatePageDataWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage) {
        weakSelf.editTemplateView.showHud = NO;
        if (errorMessage) {
            weakSelf.editTemplateView.errorMessage = errorMessage;
            return ;
        }
        if (!sessionErrorState) {
            //删除页面
            [weakSelf.editTemplateView deletePage];
            return;
        }
    }];
}

#pragma mark - ZLElectronicInvitationEditTemplateSelectImageDelegate
-(void)didEndSelectedImageWithImage:(UIImage *)image {
    __weak typeof(self)weakSelf = self;
    UIView *view = self.infoModel.units[self.infoModel.currentIndexPath.section][self.infoModel.currentIndexPath.row];
    [ZLElectronicInvitationEditTemplateTailorImage showTailorImageViewInSuperView:self.view Image:image Scale:view.frame.size.height / view.frame.size.width Results:^(NSData *imageData) {
        self.infoModel.imageData = imageData;
        self.editTemplateView.showHud = YES;
        [ZLElectronicInvitationEditTemplateModel imageUrlWithInfoModel:self.infoModel Results:^(ZLSessionManagerErrorState sessionErrorState, NSString *errorMessage) {
            if (errorMessage) {
                weakSelf.editTemplateView.showHud = NO;
                weakSelf.editTemplateView.errorMessage = errorMessage;
                return ;
            }
            if (!sessionErrorState) {
                [weakSelf saveTemplateData];
                return;
            }
        }];
    }];
}

@end
