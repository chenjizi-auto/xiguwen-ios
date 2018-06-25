//
//  ZLElectronicInvitationEditTemplateView.m
//  ProjectModules
//
//  Created by zhaolei on 2018/6/8.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import "ZLElectronicInvitationEditTemplateView.h"
#import "ZLElectronicInvitationEditPage.h"

@interface ZLElectronicInvitationEditTemplateView ()<ZLElectronicInvitationEditPageDelegate>

///滑动视图
@property (nonatomic,weak) ZLElectronicInvitationEditPage *editPage;
///功能条
@property (nonatomic,weak) UIView *functionBar;
///删除时的蒙版
@property (nonatomic,weak) UIView *hudView;
///错误提示
@property (nonatomic,weak) UILabel *errorLabel;

@end

@implementation ZLElectronicInvitationEditTemplateView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self editPage];
        [self functionBar];
    }
    return self;
}

#pragma mark - Set
- (void)setInfoModel:(ZLElectronicInvitationEditTemplateModel *)infoModel {
    _infoModel = infoModel;
    
    if (infoModel.units.count) {
        [self.editPage setupEditPageWithFrame:infoModel.frame PageSize:infoModel.pageSize Space:infoModel.space UnitViews:infoModel.units];
    }
}
- (void)setErrorMessage:(NSString *)errorMessage {
    _errorMessage = errorMessage;
    [self showErrorMessage];
}
- (void)setShowHud:(BOOL)showHud {
    if (_showHud != showHud) {
        _showHud = showHud;
        if (showHud) {
            [self showSaveDataHudView];
        }else {
            if (self.hudView) {
                [self.hudView removeFromSuperview];
            }
        }
    }
}

#pragma mark - Lazy
- (ZLElectronicInvitationEditPage *)editPage {
    if (!_editPage) {
        ZLElectronicInvitationEditPage *editPage = [[ZLElectronicInvitationEditPage alloc] initWithFrame:CGRectZero];
        editPage.delegate = self;
        [self addSubview:editPage];
        _editPage = editPage;
    }
    return _editPage;
}
- (UIView *)functionBar {
    if (!_functionBar) {
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        CGFloat safetyAreaHeight = statusBarHeight == 20.0 ? 0 : 24.0;
        
        //夹层，用来弥补iPhoneX的底部安全域
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height - 50.0 - safetyAreaHeight, UIScreen.mainScreen.bounds.size.width, 50.0 + safetyAreaHeight);
        [self addSubview:effectView];
        
        UIView *functionBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 50.0)];
        functionBar.backgroundColor = UIColor.whiteColor;
        [effectView.contentView addSubview:functionBar];
        
        //子视图
        CGFloat height = CGRectGetHeight(functionBar.frame) - 10.0;
        CGFloat space = (CGRectGetWidth(functionBar.frame) - height * 3) / 6;
        NSArray *tags = @[@(ZLEditTemplateFunctionDeleteInvitation),@(ZLEditTemplateFunctionDeletePage),@(ZLEditTemplateFunctionPreview)];
        NSArray *imageNames = @[@"删除.png",@"删页.png",@"预览.png"];
        for (NSInteger index = 0; index < imageNames.count; index++) {
            UIButton *sender = [[UIButton alloc] initWithFrame:CGRectMake(space + (height + space * 2) * index, 5.0, height, height)];
            NSString *path = [NSBundle.mainBundle.bundlePath stringByAppendingPathComponent:imageNames[index]];
            sender.tag = [tags[index] integerValue];
            [sender setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
            [sender addTarget:self action:@selector(bottomBarAction:) forControlEvents:UIControlEventTouchUpInside];
            [functionBar addSubview:sender];
        }
        _functionBar = functionBar;
    }
    return _functionBar;
}
- (UILabel *)errorLabel {
    if (!_errorLabel) {
        UILabel *errorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        errorLabel.textColor = UIColor.whiteColor;
        errorLabel.backgroundColor = UIColor.blackColor;
        errorLabel.textAlignment = NSTextAlignmentCenter;
        errorLabel.layer.cornerRadius = 3.0;
        errorLabel.layer.masksToBounds = YES;
        errorLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:errorLabel];
        _errorLabel = errorLabel;
    }
    return _errorLabel;
}

#pragma mark - Action
- (void)bottomBarAction:(UIButton *)sender {
    if (self.infoModel.units.count < 2 && sender.tag == ZLEditTemplateFunctionDeletePage) {
        self.errorMessage = @"至少保留一页";
        return;
    }
    if (self.bottomFunctionAction) {
        self.infoModel.willDeletePageIndex = self.editPage.currentPageIndex;
        self.bottomFunctionAction(sender.tag);
    }
}

#pragma mark - Separate
- (void)showSaveDataHudView {
    UIView *hudView = [[UIView alloc] initWithFrame:self.frame];
    [self addSubview:hudView];
    self.hudView = hudView;
    UIView *alphaView = [[UIView alloc] initWithFrame:self.frame];
    alphaView.alpha = 0.2;
    alphaView.backgroundColor = UIColor.blackColor;
    [hudView addSubview:alphaView];
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 80.0, 80.0)];
    activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activityIndicatorView.color = [UIColor colorWithRed:255/255.0 green:114/255.0 blue:153/255.0 alpha:1.0];
    [hudView addSubview:activityIndicatorView];
    activityIndicatorView.layer.cornerRadius = 5.0;
    activityIndicatorView.layer.masksToBounds = YES;
    activityIndicatorView.backgroundColor = UIColor.whiteColor;
    activityIndicatorView.center = hudView.center;
    [activityIndicatorView startAnimating];
}
- (void)showErrorMessage {
    [self.hudView removeFromSuperview];
    CGSize size = [self.errorMessage boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 50.0,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;
    CGFloat width = size.width + 20;
    CGFloat height = size.height + 20;
    CGFloat x = (UIScreen.mainScreen.bounds.size.width - width) * 0.5;
    CGFloat y = UIScreen.mainScreen.bounds.size.height - height - self.functionBar.superview.frame.size.height - 20.0;
    self.errorLabel.frame = CGRectMake(x, y, width, height);
    self.errorLabel.text = self.errorMessage;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.errorLabel removeFromSuperview];
    });
}
- (void)deletePage {
    self.editPage.unitViews = self.infoModel.units;
}

#pragma mark - ZLElectronicInvitationEditPageDelegate
- (void)changeImageWithIndexPath:(NSIndexPath *)indexPath {
    if (self.changeImageAction) {
        self.infoModel.currentIndexPath = indexPath;
        self.changeImageAction();
    }
}
- (void)saveTextWithIndexPath:(NSIndexPath *)indexPath LatestText:(NSString *)value {
    if (self.saveTextAction) {
        self.infoModel.currentIndexPath = indexPath;
        self.infoModel.willChangeValue = value;
        self.showHud = YES;
        self.saveTextAction();
    }
}

@end
