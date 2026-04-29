//
//  HunqinQuanViewController.m
//  BoYi
//
//  Created by heng on 2018/1/5.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunqinQuanViewController.h"
#import "HunqinQuanViewModel.h"
#import "HunqinQuanModel.h"
#import "DongtaiDetilViewController.h"
#import "FindReportViewController.h"
#import "fenLeiModel.h"
#import "DopTableViewCell.h"
#import "CXHunqingquanTableViewCell.h"
#import "MJPhotoBrowser.h"
#import "WriteDongtaiViewController.h"

static NSString *CXHunqingquanTableViewCellIndentifier = @"CXHunqingquanTableViewCellIndentifier";

typedef NS_ENUM(NSInteger, XGWFindSheetMode) {
    XGWFindSheetModeNone = 0,
    XGWFindSheetModeCategory,
    XGWFindSheetModeSort,
    XGWFindSheetModeArea,
    XGWFindSheetModeFilter
};

@interface HunqinQuanViewController (){
    NSInteger follow,p,type;
    NSString *hot,*newest;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) HunqinQuanViewModel *viewModel;
@property (nonatomic ,strong) NSMutableArray *Data;

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UIView *codeFilterBar;
@property (nonatomic, strong) NSArray<UIButton *> *filterButtons;
@property (nonatomic, strong) UIControl *sheetOverlayView;
@property (nonatomic, strong) UIView *sheetDimView;
@property (nonatomic, strong) UIView *sheetContainerView;
@property (nonatomic, strong) UILabel *sheetTitleLabel;
@property (nonatomic, strong) UITableView *sheetTableView;
@property (nonatomic, strong) NSLayoutConstraint *sheetTableHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *sheetTableBottomConstraint;
@property (nonatomic, strong) UIView *sheetMessageView;
@property (nonatomic, strong) UILabel *sheetMessageLabel;
@property (nonatomic, strong) UIButton *sheetSecondaryButton;
@property (nonatomic, strong) UIButton *sheetPrimaryButton;
@property (nonatomic, strong) NSLayoutConstraint *sheetMessageBottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint *sheetBottomConstraint;
@property (nonatomic, assign) XGWFindSheetMode currentSheetMode;
@property (nonatomic, copy) NSString *selectedCategoryTitle;
@property (nonatomic, copy) NSString *selectedSortTitle;
@property (nonatomic, strong) NSArray<NSDictionary *> *sortItems;

@end

@implementation HunqinQuanViewController

- (NSArray *)imageArray {
	if (!_imageArray) {
		_imageArray = [[NSArray alloc] init];
	}
	return _imageArray;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    follow = 0;
    type = -1;
    hot = @"";
    newest = @"desc";
    self.selectedCategoryTitle = @"全部";
    self.selectedSortTitle = @"综合排序";
    self.sortItems = @[
        @{@"key": @"latest", @"title": @"最新"},
        @{@"key": @"hot", @"title": @"热门"},
        @{@"key": @"follow", @"title": @"关注"}
    ];
    [self setupFilterBarAppearance];
    [self cellClick];
    [self setupTableView];
    [self.table.mj_header beginRefreshing];
}

- (void)setupFilterBarAppearance {
    UIView *filterBar = self.btn1.superview.superview;
    filterBar.backgroundColor = [UIColor whiteColor];
    self.view1.hidden = YES;
    self.view2.hidden = YES;
    self.view3.hidden = YES;
    self.view4.hidden = YES;
    self.zuixinImage.hidden = YES;
    self.remenImage.hidden = YES;
    self.btn1.hidden = YES;
    self.btn2.hidden = YES;
    self.btn3.hidden = YES;
    self.btn4.hidden = YES;
    self.tablexiala.hidden = YES;
    self.tabheightview.hidden = YES;

    if (!self.codeFilterBar) {
        UIView *codeFilterBar = [[UIView alloc] initWithFrame:filterBar.bounds];
        codeFilterBar.translatesAutoresizingMaskIntoConstraints = NO;
        codeFilterBar.backgroundColor = UIColor.whiteColor;
        [filterBar addSubview:codeFilterBar];
        [NSLayoutConstraint activateConstraints:@[
            [codeFilterBar.leadingAnchor constraintEqualToAnchor:filterBar.leadingAnchor],
            [codeFilterBar.trailingAnchor constraintEqualToAnchor:filterBar.trailingAnchor],
            [codeFilterBar.topAnchor constraintEqualToAnchor:filterBar.topAnchor],
            [codeFilterBar.bottomAnchor constraintEqualToAnchor:filterBar.bottomAnchor]
        ]];
        self.codeFilterBar = codeFilterBar;

        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.backgroundColor = UIColor.clearColor;
        [codeFilterBar addSubview:scrollView];
        [NSLayoutConstraint activateConstraints:@[
            [scrollView.leadingAnchor constraintEqualToAnchor:codeFilterBar.leadingAnchor],
            [scrollView.trailingAnchor constraintEqualToAnchor:codeFilterBar.trailingAnchor],
            [scrollView.topAnchor constraintEqualToAnchor:codeFilterBar.topAnchor],
            [scrollView.bottomAnchor constraintEqualToAnchor:codeFilterBar.bottomAnchor]
        ]];

        UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [scrollView addSubview:contentView];
        [NSLayoutConstraint activateConstraints:@[
            [contentView.leadingAnchor constraintEqualToAnchor:scrollView.leadingAnchor],
            [contentView.trailingAnchor constraintEqualToAnchor:scrollView.trailingAnchor],
            [contentView.topAnchor constraintEqualToAnchor:scrollView.topAnchor],
            [contentView.bottomAnchor constraintEqualToAnchor:scrollView.bottomAnchor],
            [contentView.heightAnchor constraintEqualToAnchor:scrollView.heightAnchor]
        ]];

        UIStackView *stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
        stackView.translatesAutoresizingMaskIntoConstraints = NO;
        stackView.axis = UILayoutConstraintAxisHorizontal;
        stackView.spacing = 10.0;
        stackView.alignment = UIStackViewAlignmentCenter;
        [contentView addSubview:stackView];
        [NSLayoutConstraint activateConstraints:@[
            [stackView.leadingAnchor constraintEqualToAnchor:contentView.leadingAnchor constant:16.0],
            [stackView.trailingAnchor constraintEqualToAnchor:contentView.trailingAnchor constant:-16.0],
            [stackView.topAnchor constraintEqualToAnchor:contentView.topAnchor constant:10.0],
            [stackView.bottomAnchor constraintEqualToAnchor:contentView.bottomAnchor constant:-10.0]
        ]];

        NSMutableArray *buttons = [NSMutableArray array];
        NSArray<NSNumber *> *modes = @[
            @(XGWFindSheetModeCategory),
            @(XGWFindSheetModeSort)
        ];
        for (NSNumber *modeNumber in modes) {
            UIButton *button = [self buildFilterChipButtonForMode:modeNumber.integerValue];
            [stackView addArrangedSubview:button];
            [buttons addObject:button];
        }
        self.filterButtons = [buttons copy];
    }

    self.table.backgroundColor = [UIColor colorWithRed:0.97 green:0.98 blue:0.98 alpha:1.0];
    [self setupBottomSheetIfNeeded];
    [self updateFilterBarState];
}

- (UIButton *)buildFilterChipButtonForMode:(XGWFindSheetMode)mode {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = mode;
    button.layer.cornerRadius = 18.0;
    button.layer.masksToBounds = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
    button.contentEdgeInsets = UIEdgeInsetsMake(10.0, 14.0, 10.0, 14.0);
    button.backgroundColor = [UIColor colorWithRed:0.97 green:0.98 blue:0.98 alpha:1.0];
    [button setTitleColor:[UIColor colorWithRed:0.40 green:0.42 blue:0.46 alpha:1.0] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleFilterChipTapped:) forControlEvents:UIControlEventTouchUpInside];
    if (@available(iOS 13.0, *)) {
        UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithPointSize:11.0 weight:UIImageSymbolWeightSemibold];
        UIImage *image = [UIImage systemImageNamed:(mode == XGWFindSheetModeFilter ? @"line.3.horizontal.decrease.circle" : @"chevron.down") withConfiguration:config];
        [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        button.tintColor = [UIColor colorWithRed:0.40 green:0.42 blue:0.46 alpha:1.0];
        button.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 6.0, 0, -6.0);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -6.0, 0, 6.0);
    }
    return button;
}

- (void)setupBottomSheetIfNeeded {
    if (self.sheetOverlayView) {
        return;
    }

    UIControl *overlayView = [[UIControl alloc] initWithFrame:CGRectZero];
    overlayView.translatesAutoresizingMaskIntoConstraints = NO;
    overlayView.hidden = YES;
    overlayView.alpha = 0.0;
    overlayView.userInteractionEnabled = NO;
    [overlayView addTarget:self action:@selector(dismissBottomSheet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:overlayView];
    [NSLayoutConstraint activateConstraints:@[
        [overlayView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [overlayView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [overlayView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [overlayView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];

    UIView *dimView = [[UIView alloc] initWithFrame:CGRectZero];
    dimView.translatesAutoresizingMaskIntoConstraints = NO;
    dimView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.24];
    dimView.userInteractionEnabled = NO;
    [overlayView addSubview:dimView];
    [NSLayoutConstraint activateConstraints:@[
        [dimView.leadingAnchor constraintEqualToAnchor:overlayView.leadingAnchor],
        [dimView.trailingAnchor constraintEqualToAnchor:overlayView.trailingAnchor],
        [dimView.topAnchor constraintEqualToAnchor:overlayView.topAnchor],
        [dimView.bottomAnchor constraintEqualToAnchor:overlayView.bottomAnchor]
    ]];

    UIView *sheetView = [[UIView alloc] initWithFrame:CGRectZero];
    sheetView.translatesAutoresizingMaskIntoConstraints = NO;
    sheetView.backgroundColor = UIColor.whiteColor;
    sheetView.userInteractionEnabled = YES;
    sheetView.layer.cornerRadius = 24.0;
    sheetView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    [overlayView addSubview:sheetView];
    self.sheetBottomConstraint = [sheetView.bottomAnchor constraintEqualToAnchor:overlayView.bottomAnchor constant:420.0];
    [NSLayoutConstraint activateConstraints:@[
        [sheetView.leadingAnchor constraintEqualToAnchor:overlayView.leadingAnchor],
        [sheetView.trailingAnchor constraintEqualToAnchor:overlayView.trailingAnchor],
        self.sheetBottomConstraint
    ]];

    UIView *handle = [[UIView alloc] initWithFrame:CGRectZero];
    handle.translatesAutoresizingMaskIntoConstraints = NO;
    handle.backgroundColor = [UIColor colorWithRed:0.87 green:0.88 blue:0.91 alpha:1.0];
    handle.layer.cornerRadius = 2.5;
    [sheetView addSubview:handle];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightSemibold];
    titleLabel.textColor = [UIColor colorWithRed:0.07 green:0.09 blue:0.13 alpha:1.0];
    [sheetView addSubview:titleLabel];

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.scrollEnabled = NO;
    [sheetView addSubview:tableView];
    self.sheetTableHeightConstraint = [tableView.heightAnchor constraintEqualToConstant:0.0];
    self.sheetTableBottomConstraint = [tableView.bottomAnchor constraintEqualToAnchor:sheetView.safeAreaLayoutGuide.bottomAnchor constant:-20.0];

    UIView *messageView = [[UIView alloc] initWithFrame:CGRectZero];
    messageView.translatesAutoresizingMaskIntoConstraints = NO;
    messageView.hidden = YES;
    [sheetView addSubview:messageView];
    self.sheetMessageBottomConstraint = [messageView.bottomAnchor constraintEqualToAnchor:sheetView.safeAreaLayoutGuide.bottomAnchor constant:-20.0];

    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    messageLabel.numberOfLines = 0;
    messageLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    messageLabel.textColor = [UIColor colorWithRed:0.40 green:0.42 blue:0.46 alpha:1.0];
    [messageView addSubview:messageLabel];

    UIButton *secondaryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    secondaryButton.translatesAutoresizingMaskIntoConstraints = NO;
    secondaryButton.layer.cornerRadius = 24.0;
    secondaryButton.layer.borderWidth = 1.0;
    secondaryButton.layer.borderColor = [UIColor colorWithRed:0.90 green:0.91 blue:0.93 alpha:1.0].CGColor;
    [secondaryButton setTitle:@"关闭" forState:UIControlStateNormal];
    [secondaryButton setTitleColor:[UIColor colorWithRed:0.40 green:0.42 blue:0.46 alpha:1.0] forState:UIControlStateNormal];
    secondaryButton.titleLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightSemibold];
    [secondaryButton addTarget:self action:@selector(handleSheetSecondaryAction) forControlEvents:UIControlEventTouchUpInside];
    [messageView addSubview:secondaryButton];

    UIButton *primaryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    primaryButton.translatesAutoresizingMaskIntoConstraints = NO;
    primaryButton.layer.cornerRadius = 24.0;
    primaryButton.backgroundColor = MAINCOLOR;
    [primaryButton setTitle:@"重置分类" forState:UIControlStateNormal];
    [primaryButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    primaryButton.titleLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightSemibold];
    [primaryButton addTarget:self action:@selector(handleSheetPrimaryAction) forControlEvents:UIControlEventTouchUpInside];
    [messageView addSubview:primaryButton];

    [NSLayoutConstraint activateConstraints:@[
        [handle.topAnchor constraintEqualToAnchor:sheetView.topAnchor constant:10.0],
        [handle.centerXAnchor constraintEqualToAnchor:sheetView.centerXAnchor],
        [handle.widthAnchor constraintEqualToConstant:38.0],
        [handle.heightAnchor constraintEqualToConstant:5.0],

        [titleLabel.topAnchor constraintEqualToAnchor:sheetView.topAnchor constant:28.0],
        [titleLabel.centerXAnchor constraintEqualToAnchor:sheetView.centerXAnchor],

        [tableView.leadingAnchor constraintEqualToAnchor:sheetView.leadingAnchor],
        [tableView.trailingAnchor constraintEqualToAnchor:sheetView.trailingAnchor],
        [tableView.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:18.0],
        self.sheetTableHeightConstraint,
        self.sheetTableBottomConstraint,

        [messageView.leadingAnchor constraintEqualToAnchor:sheetView.leadingAnchor constant:20.0],
        [messageView.trailingAnchor constraintEqualToAnchor:sheetView.trailingAnchor constant:-20.0],
        [messageView.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:18.0],

        [messageLabel.leadingAnchor constraintEqualToAnchor:messageView.leadingAnchor],
        [messageLabel.trailingAnchor constraintEqualToAnchor:messageView.trailingAnchor],
        [messageLabel.topAnchor constraintEqualToAnchor:messageView.topAnchor],

        [secondaryButton.leadingAnchor constraintEqualToAnchor:messageView.leadingAnchor],
        [secondaryButton.topAnchor constraintEqualToAnchor:messageLabel.bottomAnchor constant:20.0],
        [secondaryButton.heightAnchor constraintEqualToConstant:48.0],
        [secondaryButton.bottomAnchor constraintEqualToAnchor:messageView.bottomAnchor],

        [primaryButton.leadingAnchor constraintEqualToAnchor:secondaryButton.trailingAnchor constant:12.0],
        [primaryButton.trailingAnchor constraintEqualToAnchor:messageView.trailingAnchor],
        [primaryButton.widthAnchor constraintEqualToAnchor:secondaryButton.widthAnchor],
        [primaryButton.centerYAnchor constraintEqualToAnchor:secondaryButton.centerYAnchor],
        [primaryButton.heightAnchor constraintEqualToAnchor:secondaryButton.heightAnchor]
    ]];

    self.sheetMessageBottomConstraint.active = NO;

    self.sheetOverlayView = overlayView;
    self.sheetDimView = dimView;
    self.sheetContainerView = sheetView;
    self.sheetTitleLabel = titleLabel;
    self.sheetTableView = tableView;
    self.sheetMessageView = messageView;
    self.sheetMessageLabel = messageLabel;
    self.sheetSecondaryButton = secondaryButton;
    self.sheetPrimaryButton = primaryButton;
}

- (void)updateFilterBarState {
    for (UIButton *button in self.filterButtons) {
        NSString *title = @"";
        BOOL active = NO;
        switch (button.tag) {
            case XGWFindSheetModeCategory:
                title = self.selectedCategoryTitle ?: @"全部";
                active = ![title isEqualToString:@"全部"];
                break;
            case XGWFindSheetModeSort:
                title = self.selectedSortTitle ?: @"综合排序";
                active = ![title isEqualToString:@"综合排序"];
                break;
            case XGWFindSheetModeArea:
                title = @"全区域";
                active = NO;
                break;
            case XGWFindSheetModeFilter:
                title = @"筛选";
                active = ![self.selectedCategoryTitle isEqualToString:@"全部"];
                break;
            default:
                break;
        }
        [button setTitle:title forState:UIControlStateNormal];
        button.backgroundColor = active ? [MAINCOLOR colorWithAlphaComponent:0.10] : [UIColor colorWithRed:0.97 green:0.98 blue:0.98 alpha:1.0];
        UIColor *textColor = active ? MAINCOLOR : [UIColor colorWithRed:0.40 green:0.42 blue:0.46 alpha:1.0];
        [button setTitleColor:textColor forState:UIControlStateNormal];
        button.tintColor = textColor;
    }
}

- (void)handleFilterChipTapped:(UIButton *)sender {
    XGWFindSheetMode mode = (XGWFindSheetMode)sender.tag;
    if (mode == XGWFindSheetModeSort) {
        [self presentBottomSheetForMode:mode];
        return;
    }
    if (mode == XGWFindSheetModeCategory) {
        [self presentBottomSheetForMode:mode];
        return;
    }
    if (mode == XGWFindSheetModeArea) {
        [self presentBottomSheetForMode:mode];
        return;
    }
    [self presentBottomSheetForMode:XGWFindSheetModeFilter];
}

- (void)presentBottomSheetForMode:(XGWFindSheetMode)mode {
    [self setupBottomSheetIfNeeded];
    self.currentSheetMode = mode;
    self.sheetOverlayView.hidden = NO;
    self.sheetOverlayView.userInteractionEnabled = YES;
    self.sheetTableView.hidden = YES;
    self.sheetMessageView.hidden = YES;
    self.sheetTableHeightConstraint.constant = 0.0;
    self.sheetTableBottomConstraint.active = NO;
    self.sheetMessageBottomConstraint.active = NO;
    self.sheetPrimaryButton.hidden = NO;

    if (mode == XGWFindSheetModeCategory) {
        if (self.quanbuArray.count > 0) {
            self.sheetTitleLabel.text = @"选择职业";
            self.sheetTableView.hidden = NO;
            self.sheetTableHeightConstraint.constant = MIN(self.quanbuArray.count * 52.0, 312.0);
            self.sheetTableView.scrollEnabled = self.quanbuArray.count > 6;
            self.sheetTableBottomConstraint.active = YES;
            [self.sheetTableView reloadData];
        } else {
            self.sheetTitleLabel.text = @"选择职业";
            self.sheetMessageView.hidden = NO;
            self.sheetMessageBottomConstraint.active = YES;
            self.sheetMessageLabel.text = @"分类数据加载中，请稍后再试。";
            [self.sheetSecondaryButton setTitle:@"关闭" forState:UIControlStateNormal];
            self.sheetPrimaryButton.hidden = YES;
        }
    } else if (mode == XGWFindSheetModeSort) {
        self.sheetTitleLabel.text = @"综合排序";
        self.sheetTableView.hidden = NO;
        self.sheetTableHeightConstraint.constant = self.sortItems.count * 52.0;
        self.sheetTableView.scrollEnabled = NO;
        self.sheetTableBottomConstraint.active = YES;
        [self.sheetTableView reloadData];
    } else if (mode == XGWFindSheetModeArea) {
        self.sheetTitleLabel.text = @"区域";
        self.sheetMessageView.hidden = NO;
        self.sheetMessageBottomConstraint.active = YES;
        self.sheetMessageLabel.text = @"当前 iOS 发现页还没有接入区域选择，先保留与小程序一致的筛选入口。";
        [self.sheetSecondaryButton setTitle:@"关闭" forState:UIControlStateNormal];
        self.sheetPrimaryButton.hidden = YES;
    } else {
        self.sheetTitleLabel.text = @"筛选";
        self.sheetMessageView.hidden = NO;
        self.sheetMessageBottomConstraint.active = YES;
        self.sheetMessageLabel.text = @"当前发现页后台只接了分类和排序。更多高级筛选先保留小程序的交互入口。";
        [self.sheetSecondaryButton setTitle:@"关闭" forState:UIControlStateNormal];
        [self.sheetPrimaryButton setTitle:@"重置分类" forState:UIControlStateNormal];
    }

    [self.view layoutIfNeeded];
    self.sheetBottomConstraint.constant = 0.0;
    [UIView animateWithDuration:0.25 animations:^{
        self.sheetOverlayView.alpha = 1.0;
        [self.view layoutIfNeeded];
    }];
}

- (void)dismissBottomSheet {
    if (!self.sheetOverlayView || self.sheetOverlayView.hidden) {
        return;
    }
    self.sheetBottomConstraint.constant = 420.0;
    [UIView animateWithDuration:0.22 animations:^{
        self.sheetOverlayView.alpha = 0.0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.sheetOverlayView.hidden = YES;
        self.sheetOverlayView.userInteractionEnabled = NO;
        self.currentSheetMode = XGWFindSheetModeNone;
    }];
}

- (void)handleSheetSecondaryAction {
    [self dismissBottomSheet];
}

- (void)handleSheetPrimaryAction {
    type = -1;
    self.selectedCategoryTitle = @"全部";
    for (Fenleiarray *item in self.quanbuArray) {
        item.isSelete = [item.proname isEqualToString:@"全部"];
    }
    [self updateFilterBarState];
    [self dismissBottomSheet];
    [self.table.mj_header beginRefreshing];
}

- (void)selectSortItemAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.sortItems.count) {
        return;
    }
    NSDictionary *item = self.sortItems[index];
    NSString *key = item[@"key"];
    if ([key isEqualToString:@"follow"] && ![UserDataNew UserLoginState]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserNotLoginIn_ToLogin" object:nil];
        return;
    }

    self.selectedSortTitle = item[@"title"];
    follow = [key isEqualToString:@"follow"] ? 1 : 0;
    hot = [key isEqualToString:@"hot"] ? @"desc" : @"";
    newest = [key isEqualToString:@"latest"] ? @"desc" : @"";
    [self updateFilterBarState];
    [self dismissBottomSheet];
    [self.table.mj_header beginRefreshing];
}

- (IBAction)actionall:(UIButton *)sender {
    if (sender.tag == 0) {//全部
        [self selemoren];
        return;
    }else if (sender.tag == 1) {//最新
        if (sender.selected) {
            [self seleZuixinGao];
        }else {
            [self seleZuixinDi];
        }
        sender.selected = !sender.selected;
    }else if (sender.tag == 2){//热门
        if (sender.selected) {
            [self seleRemenGao];
        }else {
            [self seleRemenDi];
        }
        sender.selected = !sender.selected;
    }else {
        [self seleguanzhu];
    }
    [self.table.mj_header beginRefreshing];
}
- (void)selemoren{
    follow = 0;
    hot = @"";//desc asc
    newest = @"";
    self.view1.hidden = YES;
    self.view2.hidden = YES;
    self.view3.hidden = YES;
    self.view4.hidden = YES;
    self.zuixinImage.hidden = YES;
    self.remenImage.hidden = YES;
    [self.btn1 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn2 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn3 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn4 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    self.tabheightview.hidden = NO;
}
- (void)seleguanzhu{
    follow = 1;
    hot = @"";//desc asc
    newest = @"";
    self.view1.hidden = YES;
    self.view2.hidden = YES;
    self.view3.hidden = YES;
    self.view4.hidden = YES;
    self.zuixinImage.hidden = YES;
    self.remenImage.hidden = YES;
    [self.btn1 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn2 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn3 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn4 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    self.tabheightview.hidden = YES;
}
- (void)seleZuixinGao{
    follow = 0;
    hot = @"";//desc asc
    newest = @"desc";
    self.view1.hidden = YES;
    self.view2.hidden = YES;
    self.view3.hidden = YES;
    self.view4.hidden = YES;
    self.zuixinImage.hidden = NO;
    self.zuixinImage.image = [UIImage imageNamed:@"价格从高到低"];
    self.remenImage.hidden = YES;
    [self.btn1 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn2 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn3 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn4 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    self.tabheightview.hidden = YES;
}
- (void)seleZuixinDi{
    follow = 0;
    hot = @"";//desc asc
    newest = @"asc";
    self.view1.hidden = YES;
    self.view2.hidden = YES;
    self.view3.hidden = YES;
    self.view4.hidden = YES;
    self.zuixinImage.hidden = NO;
    self.zuixinImage.image = [UIImage imageNamed:@"价格从低到高"];
    self.remenImage.hidden = YES;
    [self.btn1 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn2 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn3 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn4 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    self.tabheightview.hidden = YES;
}
- (void)seleRemenGao{
    follow = 0;
    hot = @"";//desc asc
    newest = @"desc";
    self.view1.hidden = YES;
    self.view2.hidden = YES;
    self.view3.hidden = YES;
    self.view4.hidden = YES;
    self.zuixinImage.hidden = YES;
    self.remenImage.image = [UIImage imageNamed:@"价格从高到低"];
    self.remenImage.hidden = NO;
    [self.btn1 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn2 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn3 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn4 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    self.tabheightview.hidden = YES;
}
- (void)seleRemenDi{
    follow = 0;
    hot = @"";//desc asc
    newest = @"asc";
    self.view1.hidden = YES;
    self.view2.hidden = YES;
    self.view3.hidden = YES;
    self.view4.hidden = YES;
    self.zuixinImage.hidden = YES;
    self.remenImage.image = [UIImage imageNamed:@"价格从低到高"];
    self.remenImage.hidden = NO;
    [self.btn1 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn2 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    [self.btn3 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [self.btn4 setTitleColor:RGBA(83, 83, 83, 1) forState:UIControlStateNormal];
    self.tabheightview.hidden = YES;
}

#pragma mark - 点击事件
- (IBAction)writeDongtai:(id)sender {
    
    WriteDongtaiViewController *vc = [[WriteDongtaiViewController alloc] init];
    [self pushToNextVCWithNextVC:vc];
}
#pragma mark - 点击事件
- (void)cellClick {
    
    @weakify(self);
    [self.viewModel.selectItemSubject subscribeNext:^(Hunqinnewarray *x) {
        @strongify(self);
        DongtaiDetilViewController *dongtai = [[DongtaiDetilViewController alloc] init];
        dongtai.id = x.id;
        dongtai.superModel = x;
        dongtai.hidesBottomBarWhenPushed = YES;
        dongtai.didShieldReload = ^{
            @strongify(self);
            [self.table.mj_header beginRefreshing];
        };
        [self pushToNextVCWithNextVC:dongtai];
        @weakify(self);
        [dongtai.refreshDataSubject subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.table reloadData];
        }];
    }];
    [self.viewModel.fenleilistUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        _Data = [x mutableCopy];
        //分类数据处理
        self.quanbuArray = [NSMutableArray array];
        self.quanbuArray = [Fenleiarray mj_objectArrayWithKeyValuesArray:x];
        Fenleiarray *model = [[Fenleiarray alloc] init];
        model.proname = @"全部";
        model.isSelete = YES;
        model.occupationid = -1;
        NSLog(@"-=-%@",model.wapimg);
        [self.quanbuArray insertObject:model atIndex:0];

        [self.tablexiala reloadData];
        [self.sheetTableView reloadData];
        [self updateFilterBarState];
    }];
//    [self.viewModel.refreshdateSubject subscribeNext:^(Hunqinnewarray *x) {
//        @strongify(self);
//        [self.table.mj_header beginRefreshing];
//    }];
    //评论
    [self.viewModel.pinglunseleUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSInteger i = [x integerValue];
        [HuifuiPL showInView:self.view setid:i block:^(NSString *date) {
            [self.table.mj_header beginRefreshing];
        }];
    }];
    
    [self.viewModel.dianzanSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.table reloadData];
    }];
    [self.viewModel.refreshdateSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.table reloadData];
    }];
}

#pragma mark - public api

#pragma mark - private api
//配置tableView
- (void)setupTableView {
    
    [self.tablexiala registerNib:[UINib nibWithNibName:@"DopTableViewCell" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"DopTableViewCell"];
    self.tablexiala.delegate             = self;
    self.tablexiala.dataSource           = self;
    [self.table registerNib:[UINib nibWithNibName:@"HunqinQuanTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HunqinQuanTableViewCell"];
    [self.table registerClass:[CXHunqingquanTableViewCell class] forCellReuseIdentifier:CXHunqingquanTableViewCellIndentifier];
    //    [self.table registerNib:[UINib nibWithNibName:@"" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@""];
    
    self.table.delegate             = self.viewModel;
    self.table.dataSource           = self.viewModel;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.backgroundColor = [UIColor colorWithRed:0.97 green:0.98 blue:0.98 alpha:1.0];
    self.table.emptyDataSetDelegate = self.viewModel;
    self.table.emptyDataSetSource   = self.viewModel;
    self.table.tableFooterView      = [UIView new];
    
    @weakify(self);
    [self.viewModel.fenleilistDataCommand execute:@{}];
    //下拉刷新
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        //传入参数 进行刷新
        p = 1;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if (follow != 0) {
            [dic setObject:@(follow) forKey:@"follow"];
        }
        if (![hot isEqualToString:@""]) {
            [dic setObject:hot forKey:@"hot"];
        }
        if (![newest isEqualToString:@""]) {
            [dic setObject:newest forKey:@"newest"];
        }
        if (type != -1 ) {
            [dic setObject:@(type) forKey:@"type"];
        }
        
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
        [dic setObject:@(p) forKey:@"p"];
        
        
        
        [self.viewModel.refreshDataCommand execute:dic];
    }];
    
    //请求结束
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        //数据处理
        [self.viewModel ConvertingToObject:x isHeaderRefersh:self.table.mj_header.isRefreshing];
        
        //正在下啦
        if (self.table.mj_header.isRefreshing) {
            
            if (!self.table.mj_footer) {
                
                //上啦加载
                self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    //传入参数 进行刷新
                    p ++;
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    if (follow != 0) {
                        [dic setObject:@(follow) forKey:@"follow"];
                    }
                    if (![hot isEqualToString:@""]) {
                        [dic setObject:hot forKey:@"hot"];
                    }
                    if (![newest isEqualToString:@""]) {
                        [dic setObject:newest forKey:@"newest"];
                    }
                    if (type != -1) {
                        [dic setObject:@(type) forKey:@"type"];
                    }
                    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
                    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
                    [dic setObject:@(p) forKey:@"p"];
                    
                    
                    
                    [self.viewModel.refreshDataCommand execute:dic];
                }];
            }
            [self.table.mj_header endRefreshing];
        }
        
        //判断，如果item < size 显示已获取完成
        if ([x count] < 10) {
            
            [self.table.mj_footer endRefreshingWithNoMoreData];
        } else {
            
            self.table.mj_footer.state == MJRefreshStateNoMoreData ? [self.table.mj_footer resetNoMoreData] : [self.table.mj_footer endRefreshing];
            
        }
        //刷新视图
        [self.table reloadData];
        [self.table reloadEmptyDataSet];
        
    }];
    //处理请求失败
    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        if (self.table.mj_header.isRefreshing) [self.table.mj_header endRefreshing];
        if (self.table.mj_footer.isRefreshing) [self.table.mj_footer endRefreshing];
        [self.table reloadEmptyDataSet];
    }];
}

//初始化viewModel
- (HunqinQuanViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[HunqinQuanViewModel alloc] init];
		WeakSelf(self);
		[_viewModel setOnSelectedImage:^(NSArray *array, NSInteger index) {
//			weakSelf.imageArray = array;
            [weakSelf tapImage:array];
		}];
        [_viewModel setOnSelectedHeader:^(NSInteger index) {
            NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
            vc.shopid = index;
            [weakSelf pushToNextVCWithNextVC:vc];
        }];
        [_viewModel setOnJubao:^(NSInteger dyid) {
            [FindReportViewController showDiscomfortContentAlertWithNav:weakSelf.navigationController dyid:dyid results:^(BOOL isSuccess) {
                [weakSelf.table.mj_header beginRefreshing];
            }];
        }];
        
    }
    return _viewModel;
}
#pragma mark -  tableView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.sheetTableView) {
        if (self.currentSheetMode == XGWFindSheetModeCategory) {
            return self.quanbuArray.count;
        }
        if (self.currentSheetMode == XGWFindSheetModeSort) {
            return self.sortItems.count;
        }
        return 0;
    }
    return self.quanbuArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.sheetTableView) {
        return 52.0;
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.sheetTableView) {
        if (self.currentSheetMode == XGWFindSheetModeCategory) {
            for (Fenleiarray *item in self.quanbuArray) {
                item.isSelete = NO;
            }
            Fenleiarray *selected = self.quanbuArray[indexPath.row];
            selected.isSelete = YES;
            self.selectedCategoryTitle = selected.proname ?: @"全部";
            type = [selected.proname isEqualToString:@"全部"] ? -1 : selected.occupationid;
            [self updateFilterBarState];
            [self.sheetTableView reloadData];
            [self dismissBottomSheet];
            [self.table.mj_header beginRefreshing];
            return;
        }
        if (self.currentSheetMode == XGWFindSheetModeSort) {
            [self selectSortItemAtIndex:indexPath.row];
            return;
        }
    }

    for (int i = 0; i < self.quanbuArray.count; i ++) {
        self.quanbuArray[i].isSelete = NO;
    }
    self.quanbuArray[indexPath.row].isSelete = YES;
    [self.allBTN setTitle:self.quanbuArray[indexPath.row].proname forState:UIControlStateNormal];
    self.selectedCategoryTitle = self.quanbuArray[indexPath.row].proname ?: @"全部";
    if ([self.quanbuArray[indexPath.row].proname isEqualToString:@"全部"]) {
        type = -1;
    }else {
        type = self.quanbuArray[indexPath.row].occupationid;
    }

    self.btn2.selected = NO;
    self.btn3.selected = NO;
    newest = @"desc";
    hot = @"";
    follow = 0;
    [self seleZuixinGao];
    self.selectedSortTitle = @"最新";
    self.tabheightview.hidden = YES;
    [self.tablexiala reloadData];
    [self updateFilterBarState];
    [self.table.mj_header beginRefreshing];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.sheetTableView) {
        static NSString *identifier = @"XGWFindSheetOptionCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium];
        cell.textLabel.textColor = [UIColor colorWithRed:0.07 green:0.09 blue:0.13 alpha:1.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (self.currentSheetMode == XGWFindSheetModeCategory) {
            Fenleiarray *item = self.quanbuArray[indexPath.row];
            cell.textLabel.text = item.proname;
            cell.accessoryType = item.isSelete ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
            cell.tintColor = MAINCOLOR;
        } else {
            NSDictionary *item = self.sortItems[indexPath.row];
            cell.textLabel.text = item[@"title"];
            cell.accessoryType = [self.selectedSortTitle isEqualToString:item[@"title"]] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
            cell.tintColor = MAINCOLOR;
        }
        return cell;
    }

    NSInteger row = indexPath.row;
    DopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DopTableViewCell"];
    if (!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DopTableViewCell" owner:nil options:nil].firstObject;
    }
    cell.name.text = self.quanbuArray[indexPath.row].proname;
    if (self.quanbuArray[indexPath.row].isSelete) {
        cell.gouxuanImage.hidden = NO;
    }else {
        cell.gouxuanImage.hidden = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
//	self.imageArray = self.quanbuArray[indexPath.row].;
//	[cell set];
	
	
    return  cell;
    //    CXHunqingquanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CXHunqingquanTableViewCellIndentifier];
    //    [cell imagesLoadwithData:@[] withDes:@""];
    //    return cell;
}
- (void)tapImage:(NSArray *)urls
{
    NSInteger count = urls.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        
        
        // 替换为中等尺寸图片
        NSString *url = urls[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        photo.srcImageView = nil;//self.view.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0;//tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}
@end
