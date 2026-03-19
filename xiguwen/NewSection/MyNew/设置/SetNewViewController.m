//
//  SetNewViewController.m
//  BoYi
//
//  Created by heng on 2018/1/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SetNewViewController.h"
#import "ShouHuodizhiViewController.h"
#import "MyDataNewViewController.h"
#import "UserNumberNewViewController.h"
#import "ChooseSettingViewController.h"
#import "ZLHTTPSessionManager.h"
#import "Util.h"
#import <UMShare/UMShare.h>

@interface LogFilesViewController : UIViewController
@end

@interface SetNewViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topInset;
@property (nonatomic, strong) UIView *logItemView;
@property (nonatomic, strong) NSLayoutConstraint *logItemHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *logoutTopConstraint;
@property (nonatomic, assign) BOOL logItemVisible;

@end

@implementation SetNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    [self addPopBackBtn];
    [self updateTopInsetIfNeeded];
    [self setupDebugLogItem];
    [self setupLogRevealGestureIfNeeded];
#if DEBUG
    [self setLogItemVisible:YES animated:NO];
#else
    [self setLogItemVisible:NO animated:NO];
#endif
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self updateTopInsetIfNeeded];
}

- (void)updateTopInsetIfNeeded {
    CGFloat topInset = self.view.safeAreaInsets.top;
    if (topInset <= 0.0) {
        topInset = [self currentStatusBarHeight];
    }
    self.topInset.constant = topInset + 44.0;
}

- (CGFloat)currentStatusBarHeight {
    if (@available(iOS 13.0, *)) {
        for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
            if (![scene isKindOfClass:[UIWindowScene class]]) {
                continue;
            }
            UIWindowScene *windowScene = (UIWindowScene *)scene;
            return windowScene.statusBarManager.statusBarFrame.size.height;
        }
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return UIApplication.sharedApplication.statusBarFrame.size.height;
#pragma clang diagnostic pop
}

- (void)setupDebugLogItem {
    if (self.logItemView) {
        return;
    }
    
    UIView *closeAccountView = [self.view viewWithTag:9000];
    UIView *logoutView = [self.view viewWithTag:9001];
    if (!closeAccountView || !logoutView) {
        return;
    }
    
    for (NSLayoutConstraint *constraint in self.view.constraints) {
        BOOL isLogoutTopConstraint =
        (constraint.firstItem == logoutView &&
         constraint.firstAttribute == NSLayoutAttributeTop &&
         constraint.secondItem == closeAccountView &&
         constraint.secondAttribute == NSLayoutAttributeBottom) ||
        (constraint.firstItem == closeAccountView &&
         constraint.firstAttribute == NSLayoutAttributeBottom &&
         constraint.secondItem == logoutView &&
         constraint.secondAttribute == NSLayoutAttributeTop);
        if (isLogoutTopConstraint) {
            constraint.active = NO;
            break;
        }
    }
    
    UIView *logItem = [[UIView alloc] init];
    logItem.translatesAutoresizingMaskIntoConstraints = NO;
    logItem.backgroundColor = [UIColor whiteColor];
    logItem.hidden = YES;
    logItem.alpha = 0.0;
    [self.view addSubview:logItem];
    self.logItemView = logItem;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.text = @"日志文件";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
    [logItem addSubview:titleLabel];
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"更多"]];
    arrow.translatesAutoresizingMaskIntoConstraints = NO;
    [logItem addSubview:arrow];
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeSystem];
    actionButton.translatesAutoresizingMaskIntoConstraints = NO;
    actionButton.tintColor = [UIColor clearColor];
    [actionButton addTarget:self action:@selector(openLogFiles) forControlEvents:UIControlEventTouchUpInside];
    [logItem addSubview:actionButton];
    
    UILayoutGuide *safe = self.view.safeAreaLayoutGuide;
    self.logItemHeightConstraint = [logItem.heightAnchor constraintEqualToConstant:50];
    self.logoutTopConstraint = [logoutView.topAnchor constraintEqualToAnchor:logItem.bottomAnchor constant:16];
    [NSLayoutConstraint activateConstraints:@[
        [logItem.leadingAnchor constraintEqualToAnchor:safe.leadingAnchor],
        [logItem.trailingAnchor constraintEqualToAnchor:safe.trailingAnchor],
        [logItem.topAnchor constraintEqualToAnchor:closeAccountView.bottomAnchor constant:16],
        self.logItemHeightConstraint,
        self.logoutTopConstraint,
        
        [titleLabel.leadingAnchor constraintEqualToAnchor:logItem.leadingAnchor constant:16],
        [titleLabel.centerYAnchor constraintEqualToAnchor:logItem.centerYAnchor],
        
        [arrow.trailingAnchor constraintEqualToAnchor:logItem.trailingAnchor constant:-16],
        [arrow.centerYAnchor constraintEqualToAnchor:titleLabel.centerYAnchor],
        
        [actionButton.leadingAnchor constraintEqualToAnchor:logItem.leadingAnchor],
        [actionButton.trailingAnchor constraintEqualToAnchor:logItem.trailingAnchor],
        [actionButton.topAnchor constraintEqualToAnchor:logItem.topAnchor],
        [actionButton.bottomAnchor constraintEqualToAnchor:logItem.bottomAnchor],
    ]];
}

- (void)setupLogRevealGestureIfNeeded {
#if DEBUG
    return;
#else
    UIView *titleView = self.navigationItem.titleView;
    if (!titleView) {
        return;
    }
    titleView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSettingTitleTap)];
    tapGesture.numberOfTapsRequired = 4;
    [titleView addGestureRecognizer:tapGesture];
#endif
}

- (void)handleSettingTitleTap {
    if (self.logItemVisible) {
        return;
    }
    [self setLogItemVisible:YES animated:YES];
    [Util showMessage:@"日志入口已显示"];
}

- (void)setLogItemVisible:(BOOL)visible animated:(BOOL)animated {
    if (!self.logItemView) {
        return;
    }
    self.logItemVisible = visible;
    self.logItemHeightConstraint.constant = visible ? 50.0 : 0.0;
    self.logoutTopConstraint.constant = visible ? 16.0 : 0.0;
    
    void (^changes)(void) = ^{
        self.logItemView.hidden = NO;
        self.logItemView.alpha = visible ? 1.0 : 0.0;
        [self.view layoutIfNeeded];
    };
    
    void (^completion)(BOOL) = ^(BOOL finished) {
        if (!visible) {
            self.logItemView.hidden = YES;
        }
    };
    
    if (animated) {
        [UIView animateWithDuration:0.25 animations:changes completion:completion];
    } else {
        changes();
        completion(YES);
    }
}

- (void)openLogFiles {
    UIViewController *vc = [[LogFilesViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {//收货地址
        ShouHuodizhiViewController *shouhuo = [[ShouHuodizhiViewController alloc] init];
        [self pushToNextVCWithNextVC:shouhuo];
    }else if (sender.tag == 1) {//个人资料
        MyDataNewViewController *ziliao = [[MyDataNewViewController alloc] init];
        [self pushToNextVCWithNextVC:ziliao];
    }else if (sender.tag == 2) {//账号绑定
        UserNumberNewViewController *ziliao = [[UserNumberNewViewController alloc] init];
        [self pushToNextVCWithNextVC:ziliao];
        
    }else if (sender.tag == 3) {//安全设置
        ChooseSettingViewController *vc = [[ChooseSettingViewController alloc] init];
        [self pushToNextVCWithNextVC:vc];
    }else {//退出账号
        [UserDataNew signOut];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeUserAction:(UIButton *)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"注销喜顾问账号"
                                   message:@"账号注销后不可恢复，请您谨慎操作。注销成功后，您将无法登录或使用原账号，账号内的信息和权益将无法找回。"
                                   preferredStyle:UIAlertControllerStyleAlert];
     
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
       handler:^(UIAlertAction * action) {}];
     
    [alert addAction:defaultAction];
    
    defaultAction = [UIAlertAction actionWithTitle:@"已清楚，确定注销" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
        [self closeUserRequest];
    }];
     
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/// 注销账号
- (void)closeUserRequest {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"token"] = [UserDataNew sharedManager].userInfoModel.token.token;
    dictM[@"userid"] = @([UserDataNew sharedManager].userInfoModel.token.userid);
    dictM[@"status"] = @(2);
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/cancel/index" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            [UserDataNew signOutNoAlert];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"账号已注销成功"];
            });
            return;
        }
        [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"请求失败"];
    }];
}

@end

#pragma mark - 日志列表

@interface LogFilesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray<NSURL *> *logFiles;

@end

@implementation LogFilesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"日志文件";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(reloadLogFiles)];
    [self setupTableView];
    [self reloadLogFiles];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadLogFiles];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    UILayoutGuide *safe = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:safe.topAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:safe.bottomAnchor],
        [self.tableView.leadingAnchor constraintEqualToAnchor:safe.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:safe.trailingAnchor],
    ]];
}

- (void)reloadLogFiles {
    self.logFiles = [AppLogManager sortedLogFileURLs];
    [self.tableView reloadData];
    if (self.logFiles.count == 0) {
        self.tableView.backgroundView = [self emptyLabel];
    } else {
        self.tableView.backgroundView = nil;
    }
}

- (UILabel *)emptyLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:self.tableView.bounds];
    label.text = @"暂无日志文件";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
    label.font = [UIFont systemFontOfSize:15];
    return label;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.logFiles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"LogFileCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSURL *url = self.logFiles[indexPath.row];
    cell.textLabel.text = url.lastPathComponent;
    
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:url.path error:nil];
    unsigned long long size = [attrs[NSFileSize] unsignedLongLongValue];
    NSDate *modDate = attrs[NSFileModificationDate];
    NSString *sizeText = [NSByteCountFormatter stringFromByteCount:(long long)size countStyle:NSByteCountFormatterCountStyleFile];
    NSString *dateText = @"";
    if (modDate) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        dateText = [formatter stringFromDate:modDate];
    }
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ · %@", dateText, sizeText ?: @"0B"];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSURL *fileURL = self.logFiles[indexPath.row];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:fileURL.lastPathComponent
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"分享到微信"
                                              style:UIAlertActionStyleDefault
                                            handler:^(__unused UIAlertAction *action) {
        [self shareLogFileToWeChat:fileURL];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"更多分享"
                                              style:UIAlertActionStyleDefault
                                            handler:^(__unused UIAlertAction *action) {
        [self shareLogFileWithActivity:fileURL];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Share

- (void)shareLogFileToWeChat:(NSURL *)fileURL {
    [self shareLogFileWithActivity:fileURL];
}

- (void)shareLogFileWithActivity:(NSURL *)fileURL {
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:@[fileURL] applicationActivities:nil];
    [self presentViewController:activity animated:YES completion:nil];
}

@end
