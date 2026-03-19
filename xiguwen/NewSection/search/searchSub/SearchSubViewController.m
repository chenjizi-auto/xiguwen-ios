//
//  SearchSubViewController.m
//  BoYi
//
//  Created by heng on 2018/4/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "SearchSubViewController.h"
#import "AnlieListModel.h"
#import "AnlieListSearchModel.h"
#import "NewShangjiaModel.h"
#import "SearchbjViewController.h"
#import "SearchscViewController.h"
@interface SearchSubViewController (){
    NSInteger types;
}
@property (weak, nonatomic) IBOutlet UITextField *search;
@property (nonatomic, strong) NSArray *titleNames;

@end

@implementation SearchSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationItem.title = @"搜索";
//    [self addPopBackBtn];
    ZL_Discern_Bang_Device(isBangDevice);
    if (isBangDevice) {
//        self.height.constant = 32;
    }
    self.search.delegate = self;
    self.search.returnKeyType = UIReturnKeySearch;
    self.search.textAlignment = NSTextAlignmentLeft;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 76, 30)];
    leftView.backgroundColor = [UIColor clearColor];
    self.search.leftView = leftView;
    self.search.leftViewMode = UITextFieldViewModeAlways;
    self.search.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.search.inputAccessoryView = [self addToolbar];
    self.search.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.search.text = self.content;
    self.cityBtn.hidden = NO;
    [self.cityBtn setTitle:(self.scope.length ? self.scope : @"同城") forState:UIControlStateNormal];

}
- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}
- (IBAction)actionax:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)addPopBackBtn {
    
    UIBarButtonItem *placeBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    placeBarButton.width = -10;
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    backBtn.imageEdgeInsets = UIEdgeInsetsZero;
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"返回(red)"] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    backBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [backBtn addTarget:self action:@selector(popViewConDelay)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItems = @[placeBarButton,bar];
}
- (void)popViewConDelay
{
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length != 0) {
        self.content = textField.text;
        [self reloadData];
        [textField resignFirstResponder];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.cityView.hidden = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.cityView.hidden = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 收起键盘
    [self.view endEditing:YES];
}
- (NSArray *)titleNames {
    if (_titleNames == nil) {
        _titleNames = @[@"商家",
                        @"案例",
                        @"报价",
                        @"商品"];
    }
    return _titleNames;
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return self.titleNames.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titleNames[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {

    SearchsjViewController *sj = [[SearchsjViewController alloc] init];
    sj.content = self.content;
    sj.scope = self.scope;
    sj.currentCityName = self.currentCityName;
    
    SearchalViewController *Anlie = [[SearchalViewController alloc] init];
    Anlie.content = self.content;
  

    SearchbjViewController *Baojia = [[SearchbjViewController alloc] init];
    Baojia.content = self.content;
    
    SearchscViewController *sc = [[SearchscViewController alloc] init];
    sc.content = self.content;
    
    if (index == 0) {
        return sj;
    }else if (index == 1) {
        return Anlie;
    }else if (index == 2) {
        return Baojia;
    }else {
        return sc;
    }

}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    ZL_Navigation_Height(navigationHeight)
    return CGRectMake(leftMargin, navigationHeight, self.view.frame.size.width, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
        originY += 2;
    }
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}


- (IBAction)cityac:(UIButton *)sender {
    [self.search resignFirstResponder];
    if (self.cityView.hidden == YES) {
        self.cityView.hidden = NO;
    }else {
        self.cityView.hidden = YES;
    }
}
- (IBAction)actiontiy:(UIButton *)sender {
    if (sender.tag == 0) {
        [self.cityBtn setTitle:@"同城" forState:UIControlStateNormal];
        self.scope = @"同城";
        types =  1;
    }else {
        [self.cityBtn setTitle:@"全国" forState:UIControlStateNormal];
        self.scope = @"全国";
        types =  2;
    }
    self.cityView.hidden = YES;
    [self reloadData];
}

- (UIToolbar *)addToolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 35)];
    toolbar.tintColor = MAINCOLOR;
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space, bar];
    return toolbar;
}

- (void)textFieldDone {
    self.cityView.hidden = YES;
    [self.search resignFirstResponder];
}

@end
