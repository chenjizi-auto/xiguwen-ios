//
//  FindReportViewController.m
//  BoYi
//
//  Created by 赵磊 on 2023/2/20.
//  Copyright © 2023 hengwu. All rights reserved.
//

#import "FindReportViewController.h"
#import "ZLHTTPSessionManager.h"

@interface CellView: UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, unsafe_unretained) BOOL didSelect;

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *markButton;

@end

@interface FindReportViewController ()

@property (nonatomic, unsafe_unretained) NSInteger index;

@end

@implementation FindReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:240 / 255.0 alpha:1.0];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"举报";
    [self addPopBackBtn];
    
    CellView *view = [[CellView alloc] initWithFrame:CGRectMake(0, UIApplication.sharedApplication.statusBarFrame.size.height + 52.0, UIScreen.mainScreen.bounds.size.width, 50)];
    view.title = @"涉嫌淫秽色情";
    view.tag = 1;
    view.didSelect = true;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)]];
    [self.view addSubview:view];
    
    view = [[CellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), UIScreen.mainScreen.bounds.size.width, 50)];
    view.title = @"涉嫌违法违规";
    view.tag = 2;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)]];
    [self.view addSubview:view];
    
    view = [[CellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), UIScreen.mainScreen.bounds.size.width, 50)];
    view.title = @"涉嫌诈骗";
    view.tag = 3;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)]];
    [self.view addSubview:view];
    
    view = [[CellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), UIScreen.mainScreen.bounds.size.width, 50)];
    view.title = @"其他原因";
    view.tag = 4;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)]];
    [self.view addSubview:view];
    
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(view.frame) + 40, UIScreen.mainScreen.bounds.size.width - 30, 50)];
    sendButton.layer.cornerRadius = 5;
    sendButton.layer.masksToBounds = true;
    /// 主色调
    sendButton.backgroundColor = [UIColor colorWithRed:1.0 green:0.4 blue:0.56 alpha:1.0];
    [sendButton setTitle:@"提交" forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
}

- (void)viewTap:(UITapGestureRecognizer *)tap {
    CellView *view = [self.view viewWithTag:self.index + 1];
    view.didSelect = false;
    view = [self.view viewWithTag:tap.view.tag];
    view.didSelect = true;
    self.index = tap.view.tag - 1;
}

- (void)sendButtonAction {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"token"] = [UserDataNew sharedManager].userInfoModel.token.token;
    dictM[@"userid"] = @([UserDataNew sharedManager].userInfoModel.token.userid);
    dictM[@"mydynamicid"] = @(self.dyid);
    dictM[@"reportid"] = @(self.index + 1);
    WeakSelf(self);
    [ZLHTTPSessionManager requestDataWithUrlPath:@"http://www.xiguwen520.com/appapi/report/report" Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"提交成功"];
            [weakSelf.navigationController popToRootViewControllerAnimated:true];
            return;
        }
        [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"请求失败"];
    }];
}

+ (void)showDiscomfortContentAlertWithNav:(UINavigationController *)nav dyid:(NSInteger)dyid results:(void(^)(BOOL isSuccess))results {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                   message:nil
                                   preferredStyle:UIAlertControllerStyleActionSheet];
     
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"屏蔽当前动态" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
        [self shieldContentAndUserWithNav:nav dyid:dyid isShieldUser: false results: results];
    }];
     
    [alert addAction:defaultAction];
    
    defaultAction = [UIAlertAction actionWithTitle:@"屏蔽当前用户" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
        [self shieldContentAndUserWithNav:nav dyid:dyid isShieldUser: true results: results];
    }];
     
    [alert addAction:defaultAction];
    
    defaultAction = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
        FindReportViewController *vc = [[FindReportViewController alloc] init];
        vc.dyid = dyid;
        [nav pushViewController:vc animated:true];
    }];
     
    [alert addAction:defaultAction];
    
    defaultAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
       handler:^(UIAlertAction * action) {}];
     
    [alert addAction:defaultAction];
    
    [nav presentViewController:alert animated:YES completion:nil];
}

+ (void)shieldContentAndUserWithNav:(UINavigationController *)nav dyid:(NSInteger)dyid isShieldUser:(BOOL)isShieldUser results:(void(^)(BOOL isSuccess))results {
    NSMutableDictionary *dictM = [NSMutableDictionary new];
    dictM[@"token"] = [UserDataNew sharedManager].userInfoModel.token.token;
    dictM[@"userid"] = @([UserDataNew sharedManager].userInfoModel.token.userid);
    dictM[@"mydynamicid"] = @(dyid);
    NSString *path = isShieldUser ? @"/appapi/shield/shielduser" : @"/appapi/shield/shield";
    [ZLHTTPSessionManager requestDataWithUrlPath:[NSString stringWithFormat:@"http://www.xiguwen520.com/%@", path] Params:dictM POST:YES ModelArray:nil HttpHeader:YES Results:^(ZLSessionManagerErrorState sessionErrorState, id responseObject) {
        if (!sessionErrorState) {
            [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"屏蔽成功"];
            if (results) {
                results(true);
            }
            return;
        }
        [ZLWarnView showErrorMessageOnView:UIApplication.sharedApplication.delegate.window Message:@"请求失败"];
        if (results) {
            results(false);
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end





@implementation CellView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.width - 60 - 15, self.height)];
        [self addSubview:label];
        self.titleLabel = label;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 60, 0, 60, 60)];
        button.userInteractionEnabled = false;
        [self addSubview:button];
        self.markButton = button;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setDidSelect:(BOOL)didSelect {
    _didSelect = didSelect;
    [self.markButton setImage:didSelect ? [UIImage imageNamed:@"勾选"] : nil forState:UIControlStateNormal];
}

@end
