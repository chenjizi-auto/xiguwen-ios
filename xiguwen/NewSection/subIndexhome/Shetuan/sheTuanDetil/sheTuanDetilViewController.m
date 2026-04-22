//
//  ShetuanDetilViewController.m
//  BoYi
//
//  Created by heng on 2018/2/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "ShetuanDetilViewController.h"
#import "ShetuanDetilViewModel.h"
#import "ShetuanDetilModel.h"
#import "shetuanChengyuanModel.h"
#import "shetuanZuppinModel.h"
#import "ShetuanLinxiModel.h"
#import "HuifuiPL.h"
#import "HunqinQuanModel.h"
#import "DongtaiDetilViewController.h"
#import "UIImageView+Extra.h"
#import "CwShareManager.h"
#import "ShareNewmodel.h"
#import "ShangchengsjNewDetilViewController.h"
#import "NewShangjiaViewController.h"
#import "AnlieNewDetilViewController.h"
#import "NewLoginViewController.h"
#import "UIImage+Additions.h"

typedef NS_ENUM(NSInteger, XGWClubDetailTab) {
    XGWClubDetailTabDynamic = 0,
    XGWClubDetailTabMember,
    XGWClubDetailTabWork,
    XGWClubDetailTabContact,
};

static NSString * const XGWClubHeroCellID = @"XGWClubHeroCell";
static NSString * const XGWClubDynamicCellID = @"XGWClubDynamicCell";
static NSString * const XGWClubMemberCellID = @"XGWClubMemberCell";
static NSString * const XGWClubWorkCellID = @"XGWClubWorkCell";
static NSString * const XGWClubContactCellID = @"XGWClubContactCell";
static NSString * const XGWClubEmptyCellID = @"XGWClubEmptyCell";

static inline UIColor *XGWColorHex(NSUInteger hexValue) {
    return [UIColor colorWithRed:((hexValue >> 16) & 0xFF) / 255.0
                           green:((hexValue >> 8) & 0xFF) / 255.0
                            blue:(hexValue & 0xFF) / 255.0
                           alpha:1.0];
}

static inline UIColor *XGWColorHexAlpha(NSUInteger hexValue, CGFloat alpha) {
    return [UIColor colorWithRed:((hexValue >> 16) & 0xFF) / 255.0
                           green:((hexValue >> 8) & 0xFF) / 255.0
                            blue:(hexValue & 0xFF) / 255.0
                           alpha:alpha];
}

static inline UIFont *XGWRegularFont(CGFloat size) {
    return [UIFont systemFontOfSize:size];
}

static inline UIFont *XGWSemiboldFont(CGFloat size) {
    if (@available(iOS 8.2, *)) {
        return [UIFont systemFontOfSize:size weight:UIFontWeightSemibold];
    }
    return [UIFont boldSystemFontOfSize:size];
}

static inline BOOL XGWHasText(NSString *text) {
    return text != nil && text.length > 0 && ![text isEqual:[NSNull null]];
}

static inline NSString *XGWDisplayText(NSString *text, NSString *fallback) {
    return XGWHasText(text) ? text : fallback;
}

static inline NSString *XGWNumberString(NSInteger value) {
    return value > 0 ? [NSString stringWithFormat:@"%ld", (long)value] : @"0";
}

static inline CGFloat XGWClubHeroCoverHeight(void) {
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat screenWidth = CGRectGetWidth(screenBounds);
    return MAX(screenWidth * 0.75, 240.0);
}

static inline CGFloat XGWClubHeroCardOverlap(void) {
    return 136.0;
}

@interface XGWClubStatView : UIView

@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)updateValue:(NSString *)value title:(NSString *)title;

@end

@implementation XGWClubStatView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;

        _valueLabel = [[UILabel alloc] init];
        _valueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _valueLabel.font = XGWSemiboldFont(18);
        _valueLabel.textColor = XGWColorHex(0x1D2433);
        _valueLabel.textAlignment = NSTextAlignmentCenter;

        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = XGWRegularFont(11);
        _titleLabel.textColor = XGWColorHex(0x8B90A0);
        _titleLabel.textAlignment = NSTextAlignmentCenter;

        [self addSubview:_valueLabel];
        [self addSubview:_titleLabel];

        [NSLayoutConstraint activateConstraints:@[
            [_valueLabel.topAnchor constraintEqualToAnchor:self.topAnchor],
            [_valueLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [_valueLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
            [_titleLabel.topAnchor constraintEqualToAnchor:_valueLabel.bottomAnchor constant:4.0],
            [_titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [_titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
            [_titleLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        ]];
    }
    return self;
}

- (void)updateValue:(NSString *)value title:(NSString *)title {
    self.valueLabel.text = value;
    self.titleLabel.text = title;
}

@end

@interface XGWClubHeroCell : UITableViewCell

@property (nonatomic, copy) dispatch_block_t primaryAction;
@property (nonatomic, copy) dispatch_block_t secondaryAction;

- (void)configureWithInfo:(Infoshetuan *)info
             dynamicCount:(NSInteger)dynamicCount
              memberCount:(NSInteger)memberCount
                workCount:(NSInteger)workCount;

- (void)updateWithScrollOffset:(CGFloat)offset;

@end

@interface XGWClubHeroCell ()

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIView *coverMaskView;
@property (nonatomic, strong) UIView *cardView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *badgeLabel;
@property (nonatomic, strong) UILabel *metaLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *primaryButton;
@property (nonatomic, strong) UIButton *secondaryButton;
@property (nonatomic, strong) XGWClubStatView *dynamicStatView;
@property (nonatomic, strong) XGWClubStatView *viewsStatView;
@property (nonatomic, strong) XGWClubStatView *memberStatView;
@property (nonatomic, strong) XGWClubStatView *workStatView;
@property (nonatomic, strong) NSLayoutConstraint *coverHeightConstraint;

@end

@implementation XGWClubHeroCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];

        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.clipsToBounds = YES;

        _coverMaskView = [[UIView alloc] init];
        _coverMaskView.translatesAutoresizingMaskIntoConstraints = NO;
        _coverMaskView.backgroundColor = XGWColorHexAlpha(0x111827, 0.26);

        _cardView = [[UIView alloc] init];
        _cardView.translatesAutoresizingMaskIntoConstraints = NO;
        _cardView.backgroundColor = [UIColor whiteColor];
        _cardView.layer.cornerRadius = 26.0;
        _cardView.layer.shadowColor = XGWColorHex(0x1F2937).CGColor;
        _cardView.layer.shadowOpacity = 0.08;
        _cardView.layer.shadowRadius = 18.0;
        _cardView.layer.shadowOffset = CGSizeMake(0, 10);

        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.layer.cornerRadius = 36.0;
        _avatarImageView.layer.borderWidth = 3.0;
        _avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;

        _nameLabel = [[UILabel alloc] init];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.font = XGWSemiboldFont(22);
        _nameLabel.textColor = XGWColorHex(0x1D2433);
        _nameLabel.numberOfLines = 2;

        _badgeLabel = [[UILabel alloc] init];
        _badgeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _badgeLabel.font = XGWRegularFont(11);
        _badgeLabel.textColor = XGWColorHex(0xC25D10);
        _badgeLabel.backgroundColor = XGWColorHex(0xFFF3E6);
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.layer.cornerRadius = 10.0;
        _badgeLabel.clipsToBounds = YES;

        _metaLabel = [[UILabel alloc] init];
        _metaLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _metaLabel.font = XGWRegularFont(13);
        _metaLabel.textColor = XGWColorHex(0x687083);
        _metaLabel.numberOfLines = 2;

        _descLabel = [[UILabel alloc] init];
        _descLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _descLabel.font = XGWRegularFont(13);
        _descLabel.textColor = XGWColorHex(0x525A6E);
        _descLabel.numberOfLines = 2;

        UIView *statPanel = [[UIView alloc] init];
        statPanel.translatesAutoresizingMaskIntoConstraints = NO;
        statPanel.backgroundColor = XGWColorHex(0xF7F8FC);
        statPanel.layer.cornerRadius = 18.0;

        _dynamicStatView = [[XGWClubStatView alloc] init];
        _viewsStatView = [[XGWClubStatView alloc] init];
        _memberStatView = [[XGWClubStatView alloc] init];
        _workStatView = [[XGWClubStatView alloc] init];

        UIStackView *statStack = [[UIStackView alloc] initWithArrangedSubviews:@[_dynamicStatView, _viewsStatView, _memberStatView, _workStatView]];
        statStack.translatesAutoresizingMaskIntoConstraints = NO;
        statStack.axis = UILayoutConstraintAxisHorizontal;
        statStack.distribution = UIStackViewDistributionFillEqually;

        _primaryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _primaryButton.translatesAutoresizingMaskIntoConstraints = NO;
        _primaryButton.backgroundColor = XGWColorHex(0xE64340);
        _primaryButton.layer.cornerRadius = 19.0;
        _primaryButton.titleLabel.font = XGWSemiboldFont(14);
        [_primaryButton setTitle:@"联系社团" forState:UIControlStateNormal];
        [_primaryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_primaryButton addTarget:self action:@selector(handlePrimaryAction) forControlEvents:UIControlEventTouchUpInside];

        _secondaryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _secondaryButton.translatesAutoresizingMaskIntoConstraints = NO;
        _secondaryButton.backgroundColor = [UIColor whiteColor];
        _secondaryButton.layer.cornerRadius = 19.0;
        _secondaryButton.layer.borderWidth = 1.0;
        _secondaryButton.layer.borderColor = XGWColorHex(0xE4E7EF).CGColor;
        _secondaryButton.titleLabel.font = XGWSemiboldFont(14);
        [_secondaryButton setTitle:@"社团作品" forState:UIControlStateNormal];
        [_secondaryButton setTitleColor:XGWColorHex(0x1D2433) forState:UIControlStateNormal];
        [_secondaryButton addTarget:self action:@selector(handleSecondaryAction) forControlEvents:UIControlEventTouchUpInside];

        [self.contentView addSubview:_coverImageView];
        [self.contentView addSubview:_coverMaskView];
        [self.contentView addSubview:_cardView];
        [_cardView addSubview:_avatarImageView];
        [_cardView addSubview:_nameLabel];
        [_cardView addSubview:_badgeLabel];
        [_cardView addSubview:_metaLabel];
        [_cardView addSubview:_descLabel];
        [_cardView addSubview:statPanel];
        [statPanel addSubview:statStack];
        [_cardView addSubview:_primaryButton];
        [_cardView addSubview:_secondaryButton];

        self.coverHeightConstraint = [_coverImageView.heightAnchor constraintEqualToConstant:XGWClubHeroCoverHeight()];

        [NSLayoutConstraint activateConstraints:@[
            [_coverImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
            [_coverImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
            [_coverImageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
            self.coverHeightConstraint,

            [_coverMaskView.topAnchor constraintEqualToAnchor:_coverImageView.topAnchor],
            [_coverMaskView.leadingAnchor constraintEqualToAnchor:_coverImageView.leadingAnchor],
            [_coverMaskView.trailingAnchor constraintEqualToAnchor:_coverImageView.trailingAnchor],
            [_coverMaskView.bottomAnchor constraintEqualToAnchor:_coverImageView.bottomAnchor],

            [_cardView.topAnchor constraintEqualToAnchor:_coverImageView.bottomAnchor constant:-XGWClubHeroCardOverlap()],
            [_cardView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16.0],
            [_cardView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16.0],
            [_cardView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-12.0],

            [_avatarImageView.topAnchor constraintEqualToAnchor:_cardView.topAnchor constant:18.0],
            [_avatarImageView.leadingAnchor constraintEqualToAnchor:_cardView.leadingAnchor constant:18.0],
            [_avatarImageView.widthAnchor constraintEqualToConstant:72.0],
            [_avatarImageView.heightAnchor constraintEqualToConstant:72.0],

            [_nameLabel.topAnchor constraintEqualToAnchor:_cardView.topAnchor constant:20.0],
            [_nameLabel.leadingAnchor constraintEqualToAnchor:_avatarImageView.trailingAnchor constant:16.0],
            [_nameLabel.trailingAnchor constraintEqualToAnchor:_cardView.trailingAnchor constant:-18.0],

            [_badgeLabel.topAnchor constraintEqualToAnchor:_nameLabel.bottomAnchor constant:8.0],
            [_badgeLabel.leadingAnchor constraintEqualToAnchor:_nameLabel.leadingAnchor],
            [_badgeLabel.heightAnchor constraintEqualToConstant:20.0],
            [_badgeLabel.widthAnchor constraintGreaterThanOrEqualToConstant:64.0],

            [_metaLabel.centerYAnchor constraintEqualToAnchor:_badgeLabel.centerYAnchor],
            [_metaLabel.leadingAnchor constraintEqualToAnchor:_badgeLabel.trailingAnchor constant:10.0],
            [_metaLabel.trailingAnchor constraintEqualToAnchor:_cardView.trailingAnchor constant:-18.0],

            [_descLabel.topAnchor constraintEqualToAnchor:_avatarImageView.bottomAnchor constant:14.0],
            [_descLabel.leadingAnchor constraintEqualToAnchor:_cardView.leadingAnchor constant:18.0],
            [_descLabel.trailingAnchor constraintEqualToAnchor:_cardView.trailingAnchor constant:-18.0],

            [statPanel.topAnchor constraintEqualToAnchor:_descLabel.bottomAnchor constant:14.0],
            [statPanel.leadingAnchor constraintEqualToAnchor:_cardView.leadingAnchor constant:18.0],
            [statPanel.trailingAnchor constraintEqualToAnchor:_cardView.trailingAnchor constant:-18.0],

            [statStack.topAnchor constraintEqualToAnchor:statPanel.topAnchor constant:14.0],
            [statStack.leadingAnchor constraintEqualToAnchor:statPanel.leadingAnchor constant:12.0],
            [statStack.trailingAnchor constraintEqualToAnchor:statPanel.trailingAnchor constant:-12.0],
            [statStack.bottomAnchor constraintEqualToAnchor:statPanel.bottomAnchor constant:-14.0],

            [_secondaryButton.topAnchor constraintEqualToAnchor:statPanel.bottomAnchor constant:14.0],
            [_secondaryButton.leadingAnchor constraintEqualToAnchor:_cardView.leadingAnchor constant:18.0],
            [_secondaryButton.heightAnchor constraintEqualToConstant:42.0],

            [_primaryButton.topAnchor constraintEqualToAnchor:_secondaryButton.topAnchor],
            [_primaryButton.leadingAnchor constraintEqualToAnchor:_secondaryButton.trailingAnchor constant:12.0],
            [_primaryButton.trailingAnchor constraintEqualToAnchor:_cardView.trailingAnchor constant:-18.0],
            [_primaryButton.widthAnchor constraintEqualToAnchor:_secondaryButton.widthAnchor],
            [_primaryButton.heightAnchor constraintEqualToConstant:42.0],
            [_primaryButton.bottomAnchor constraintEqualToAnchor:_cardView.bottomAnchor constant:-18.0],
        ]];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.primaryAction = nil;
    self.secondaryAction = nil;
    self.coverImageView.transform = CGAffineTransformIdentity;
    self.coverMaskView.transform = CGAffineTransformIdentity;
    self.coverMaskView.backgroundColor = XGWColorHexAlpha(0x111827, 0.26);
    self.coverHeightConstraint.constant = XGWClubHeroCoverHeight();
}

- (void)configureWithInfo:(Infoshetuan *)info
             dynamicCount:(NSInteger)dynamicCount
              memberCount:(NSInteger)memberCount
                workCount:(NSInteger)workCount {
    self.coverImageView.transform = CGAffineTransformIdentity;
    self.coverMaskView.transform = CGAffineTransformIdentity;
    self.coverMaskView.backgroundColor = XGWColorHexAlpha(0x111827, 0.18);
    [self.coverImageView sd_setImageWithUrl:info.appphotourl placeHolder:[UIImage imageNamed:@"占位图片"]];
    [self.avatarImageView sd_setImageWithUrl:info.logourl placeHolder:[UIImage imageNamed:@"头像"]];
    self.nameLabel.text = XGWDisplayText(info.name, @"社团详情");
    self.badgeLabel.text = [NSString stringWithFormat:@"  %@  ", [self badgeTextForType:info.type]];
    self.metaLabel.text = [NSString stringWithFormat:@"%@  ·  %@ 浏览",
                           XGWDisplayText(info.address, @"地址待补充"),
                           XGWNumberString(info.clicked)];
    self.descLabel.text = XGWDisplayText(info.profile, @"该社团暂未填写简介信息。");

    [self.dynamicStatView updateValue:XGWNumberString(dynamicCount) title:@"动态"];
    [self.viewsStatView updateValue:XGWNumberString(info.clicked) title:@"浏览"];
    [self.memberStatView updateValue:memberCount >= 0 ? XGWNumberString(memberCount) : @"--" title:@"成员"];
    [self.workStatView updateValue:workCount >= 0 ? XGWNumberString(workCount) : @"--" title:@"作品"];
}

- (NSString *)badgeTextForType:(NSInteger)type {
    switch (type) {
        case 1:
            return @"商家社团";
        case 2:
            return @"婚礼社团";
        default:
            return @"品牌社团";
    }
}

- (void)handlePrimaryAction {
    if (self.primaryAction) {
        self.primaryAction();
    }
}

- (void)handleSecondaryAction {
    if (self.secondaryAction) {
        self.secondaryAction();
    }
}

- (void)updateWithScrollOffset:(CGFloat)offset {
    if (offset <= 0) {
        self.coverImageView.transform = CGAffineTransformIdentity;
        self.coverMaskView.transform = CGAffineTransformIdentity;
    } else {
        CGFloat translateY = MIN(offset * 0.16, 40.0);
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, translateY);
        self.coverImageView.transform = transform;
        self.coverMaskView.transform = transform;
    }
    CGFloat alpha = MIN(0.42, 0.18 + MAX(offset, 0.0) / 640.0);
    self.coverMaskView.backgroundColor = XGWColorHexAlpha(0x111827, alpha);
}

@end

@interface XGWClubTabsHeaderView : UIView

@property (nonatomic, copy) void (^tabChanged)(NSInteger index);

- (void)configureWithSelectedIndex:(NSInteger)selectedIndex
                      dynamicCount:(NSInteger)dynamicCount
                       memberCount:(NSInteger)memberCount
                         workCount:(NSInteger)workCount;

@end

@interface XGWClubTabsHeaderView ()

@property (nonatomic, strong) NSArray<UIButton *> *buttons;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation XGWClubTabsHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        NSMutableArray *buttons = [NSMutableArray array];
        NSArray *titles = @[@"动态", @"成员", @"作品", @"联系"];
        for (NSInteger i = 0; i < titles.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            button.titleLabel.font = XGWSemiboldFont(15);
            [button setTitle:titles[i] forState:UIControlStateNormal];
            [button setTitleColor:XGWColorHex(0x7A8194) forState:UIControlStateNormal];
            [button setTitleColor:XGWColorHex(0xE64340) forState:UIControlStateSelected];
            [button addTarget:self action:@selector(handleButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [buttons addObject:button];
        }
        self.buttons = buttons;

        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = XGWColorHex(0xE64340);
        _indicatorView.layer.cornerRadius = 2.0;
        [self addSubview:_indicatorView];

        UIView *topLine = [[UIView alloc] init];
        topLine.backgroundColor = XGWColorHex(0xF2F4F8);
        topLine.frame = CGRectZero;
        topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        topLine.tag = 8021;
        [self addSubview:topLine];

        UIView *bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = XGWColorHex(0xF2F4F8);
        bottomLine.frame = CGRectZero;
        bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        bottomLine.tag = 8022;
        [self addSubview:bottomLine];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat buttonWidth = CGRectGetWidth(self.bounds) / MAX(self.buttons.count, 1);
    CGFloat buttonHeight = CGRectGetHeight(self.bounds) - 1.0;
    [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        button.frame = CGRectMake(buttonWidth * idx, 0, buttonWidth, buttonHeight);
    }];
    UIButton *selectedButton = self.buttons.count > self.selectedIndex ? self.buttons[self.selectedIndex] : self.buttons.firstObject;
    CGFloat indicatorWidth = 28.0;
    self.indicatorView.frame = CGRectMake(CGRectGetMidX(selectedButton.frame) - indicatorWidth / 2.0,
                                          CGRectGetHeight(self.bounds) - 4.0,
                                          indicatorWidth,
                                          4.0);
    UIView *topLine = [self viewWithTag:8021];
    topLine.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 1.0);
    UIView *bottomLine = [self viewWithTag:8022];
    bottomLine.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - 1.0, CGRectGetWidth(self.bounds), 1.0);
}

- (void)configureWithSelectedIndex:(NSInteger)selectedIndex
                      dynamicCount:(NSInteger)dynamicCount
                       memberCount:(NSInteger)memberCount
                         workCount:(NSInteger)workCount {
    self.selectedIndex = selectedIndex;
    NSArray *titles = @[
        [NSString stringWithFormat:@"动态 %@", XGWNumberString(dynamicCount)],
        [NSString stringWithFormat:@"成员 %@", memberCount >= 0 ? XGWNumberString(memberCount) : @"--"],
        [NSString stringWithFormat:@"作品 %@", workCount >= 0 ? XGWNumberString(workCount) : @"--"],
        @"联系"
    ];
    [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        [button setTitle:titles[idx] forState:UIControlStateNormal];
        button.selected = idx == selectedIndex;
    }];
    [self setNeedsLayout];
}

- (void)handleButtonTapped:(UIButton *)sender {
    if (sender.tag == self.selectedIndex) {
        return;
    }
    self.selectedIndex = sender.tag;
    if (self.tabChanged) {
        self.tabChanged(sender.tag);
    }
}

@end

@interface XGWClubEmptyCell : UITableViewCell

- (void)configureWithText:(NSString *)text;

@end

@interface XGWClubEmptyCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation XGWClubEmptyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];

        UIView *cardView = [[UIView alloc] init];
        cardView.translatesAutoresizingMaskIntoConstraints = NO;
        cardView.backgroundColor = [UIColor whiteColor];
        cardView.layer.cornerRadius = 20.0;

        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = XGWRegularFont(14);
        _titleLabel.textColor = XGWColorHex(0x8B90A0);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;

        [self.contentView addSubview:cardView];
        [cardView addSubview:_titleLabel];

        [NSLayoutConstraint activateConstraints:@[
            [cardView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:12.0],
            [cardView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16.0],
            [cardView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16.0],
            [cardView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-8.0],

            [_titleLabel.topAnchor constraintEqualToAnchor:cardView.topAnchor constant:36.0],
            [_titleLabel.leadingAnchor constraintEqualToAnchor:cardView.leadingAnchor constant:16.0],
            [_titleLabel.trailingAnchor constraintEqualToAnchor:cardView.trailingAnchor constant:-16.0],
            [_titleLabel.bottomAnchor constraintEqualToAnchor:cardView.bottomAnchor constant:-36.0],
        ]];
    }
    return self;
}

- (void)configureWithText:(NSString *)text {
    self.titleLabel.text = text;
}

@end

@interface XGWClubDynamicCell : UITableViewCell

@property (nonatomic, copy) dispatch_block_t likeAction;
@property (nonatomic, copy) dispatch_block_t commentAction;

- (void)configureWithModel:(Dynamiclist *)model;

@end

@interface XGWClubDynamicCell ()

@property (nonatomic, strong) UIView *cardView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) NSLayoutConstraint *coverHeightConstraint;
@property (nonatomic, strong) UILabel *statsLabel;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *likeButton;

@end

@implementation XGWClubDynamicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];

        _cardView = [[UIView alloc] init];
        _cardView.translatesAutoresizingMaskIntoConstraints = NO;
        _cardView.backgroundColor = [UIColor whiteColor];
        _cardView.layer.cornerRadius = 20.0;

        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.layer.cornerRadius = 20.0;

        _nameLabel = [[UILabel alloc] init];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.font = XGWSemiboldFont(15);
        _nameLabel.textColor = XGWColorHex(0x1D2433);

        _timeLabel = [[UILabel alloc] init];
        _timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _timeLabel.font = XGWRegularFont(12);
        _timeLabel.textColor = XGWColorHex(0x8B90A0);

        _contentLabel = [[UILabel alloc] init];
        _contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _contentLabel.font = XGWRegularFont(14);
        _contentLabel.textColor = XGWColorHex(0x374151);
        _contentLabel.numberOfLines = 0;

        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.clipsToBounds = YES;
        _coverImageView.layer.cornerRadius = 16.0;

        _statsLabel = [[UILabel alloc] init];
        _statsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _statsLabel.font = XGWRegularFont(12);
        _statsLabel.textColor = XGWColorHex(0x8B90A0);

        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.translatesAutoresizingMaskIntoConstraints = NO;
        _commentButton.layer.cornerRadius = 15.0;
        _commentButton.backgroundColor = XGWColorHex(0xF6F7FB);
        _commentButton.titleLabel.font = XGWRegularFont(12);
        [_commentButton setTitleColor:XGWColorHex(0x4B5563) forState:UIControlStateNormal];
        [_commentButton addTarget:self action:@selector(handleCommentAction) forControlEvents:UIControlEventTouchUpInside];

        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeButton.translatesAutoresizingMaskIntoConstraints = NO;
        _likeButton.layer.cornerRadius = 15.0;
        _likeButton.backgroundColor = XGWColorHex(0xFFF1F1);
        _likeButton.titleLabel.font = XGWRegularFont(12);
        [_likeButton setTitleColor:XGWColorHex(0xE64340) forState:UIControlStateNormal];
        [_likeButton addTarget:self action:@selector(handleLikeAction) forControlEvents:UIControlEventTouchUpInside];

        [self.contentView addSubview:_cardView];
        [_cardView addSubview:_avatarImageView];
        [_cardView addSubview:_nameLabel];
        [_cardView addSubview:_timeLabel];
        [_cardView addSubview:_contentLabel];
        [_cardView addSubview:_coverImageView];
        [_cardView addSubview:_statsLabel];
        [_cardView addSubview:_commentButton];
        [_cardView addSubview:_likeButton];

        self.coverHeightConstraint = [_coverImageView.heightAnchor constraintEqualToConstant:176.0];

        [NSLayoutConstraint activateConstraints:@[
            [_cardView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:12.0],
            [_cardView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16.0],
            [_cardView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16.0],
            [_cardView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-4.0],

            [_avatarImageView.topAnchor constraintEqualToAnchor:_cardView.topAnchor constant:16.0],
            [_avatarImageView.leadingAnchor constraintEqualToAnchor:_cardView.leadingAnchor constant:16.0],
            [_avatarImageView.widthAnchor constraintEqualToConstant:40.0],
            [_avatarImageView.heightAnchor constraintEqualToConstant:40.0],

            [_nameLabel.topAnchor constraintEqualToAnchor:_avatarImageView.topAnchor constant:1.0],
            [_nameLabel.leadingAnchor constraintEqualToAnchor:_avatarImageView.trailingAnchor constant:12.0],
            [_nameLabel.trailingAnchor constraintEqualToAnchor:_cardView.trailingAnchor constant:-16.0],

            [_timeLabel.topAnchor constraintEqualToAnchor:_nameLabel.bottomAnchor constant:4.0],
            [_timeLabel.leadingAnchor constraintEqualToAnchor:_nameLabel.leadingAnchor],
            [_timeLabel.trailingAnchor constraintEqualToAnchor:_nameLabel.trailingAnchor],

            [_contentLabel.topAnchor constraintEqualToAnchor:_avatarImageView.bottomAnchor constant:14.0],
            [_contentLabel.leadingAnchor constraintEqualToAnchor:_cardView.leadingAnchor constant:16.0],
            [_contentLabel.trailingAnchor constraintEqualToAnchor:_cardView.trailingAnchor constant:-16.0],

            [_coverImageView.topAnchor constraintEqualToAnchor:_contentLabel.bottomAnchor constant:12.0],
            [_coverImageView.leadingAnchor constraintEqualToAnchor:_cardView.leadingAnchor constant:16.0],
            [_coverImageView.trailingAnchor constraintEqualToAnchor:_cardView.trailingAnchor constant:-16.0],
            self.coverHeightConstraint,

            [_statsLabel.topAnchor constraintEqualToAnchor:_coverImageView.bottomAnchor constant:12.0],
            [_statsLabel.leadingAnchor constraintEqualToAnchor:_cardView.leadingAnchor constant:16.0],

            [_likeButton.centerYAnchor constraintEqualToAnchor:_statsLabel.centerYAnchor],
            [_likeButton.trailingAnchor constraintEqualToAnchor:_cardView.trailingAnchor constant:-16.0],
            [_likeButton.heightAnchor constraintEqualToConstant:30.0],
            [_likeButton.widthAnchor constraintGreaterThanOrEqualToConstant:68.0],

            [_commentButton.centerYAnchor constraintEqualToAnchor:_statsLabel.centerYAnchor],
            [_commentButton.trailingAnchor constraintEqualToAnchor:_likeButton.leadingAnchor constant:-8.0],
            [_commentButton.heightAnchor constraintEqualToConstant:30.0],
            [_commentButton.widthAnchor constraintGreaterThanOrEqualToConstant:68.0],
            [_statsLabel.bottomAnchor constraintEqualToAnchor:_cardView.bottomAnchor constant:-16.0],
        ]];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.likeAction = nil;
    self.commentAction = nil;
}

- (void)configureWithModel:(Dynamiclist *)model {
    [self.avatarImageView sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"头像"]];
    self.nameLabel.text = XGWDisplayText(model.nickname, @"社团动态");
    self.timeLabel.text = XGWDisplayText(model.create_ti, @"刚刚更新");
    self.contentLabel.text = XGWDisplayText(model.content, @"暂无动态内容");
    self.statsLabel.text = [NSString stringWithFormat:@"浏览 %@  ·  评论 %@  ·  点赞 %@",
                            XGWNumberString(model.pv),
                            XGWNumberString(model.pls),
                            XGWNumberString(model.zan)];
    [self.commentButton setTitle:[NSString stringWithFormat:@"评论 %@", XGWNumberString(model.pls)] forState:UIControlStateNormal];
    [self.likeButton setTitle:[NSString stringWithFormat:@"点赞 %@", XGWNumberString(model.zan)] forState:UIControlStateNormal];
    [self.likeButton setTitleColor:model.myzan ? XGWColorHex(0xB42318) : XGWColorHex(0xE64340) forState:UIControlStateNormal];

    Pics *firstPic = model.pics.firstObject;
    BOOL hasPic = firstPic != nil && XGWHasText(firstPic.photourl);
    self.coverImageView.hidden = !hasPic;
    self.coverHeightConstraint.constant = hasPic ? 176.0 : 0.0;
    if (hasPic) {
        [self.coverImageView sd_setImageWithUrl:firstPic.photourl placeHolder:[UIImage imageNamed:@"占位图片"]];
    } else {
        self.coverImageView.image = nil;
    }
}

- (void)handleLikeAction {
    if (self.likeAction) {
        self.likeAction();
    }
}

- (void)handleCommentAction {
    if (self.commentAction) {
        self.commentAction();
    }
}

@end

@interface XGWClubMemberCell : UITableViewCell

- (void)configureWithAvatar:(NSString *)avatar
                       name:(NSString *)name
                       role:(NSString *)role
                      price:(NSString *)price
                      badge:(NSString *)badge;

@end

@interface XGWClubMemberCell ()

@property (nonatomic, strong) UIView *cardView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *badgeLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *roleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation XGWClubMemberCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        _cardView = [[UIView alloc] init];
        _cardView.translatesAutoresizingMaskIntoConstraints = NO;
        _cardView.backgroundColor = [UIColor whiteColor];
        _cardView.layer.cornerRadius = 18.0;

        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.layer.cornerRadius = 28.0;

        _badgeLabel = [[UILabel alloc] init];
        _badgeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _badgeLabel.font = XGWRegularFont(11);
        _badgeLabel.textColor = XGWColorHex(0xC25D10);
        _badgeLabel.backgroundColor = XGWColorHex(0xFFF4E8);
        _badgeLabel.layer.cornerRadius = 10.0;
        _badgeLabel.clipsToBounds = YES;
        _badgeLabel.textAlignment = NSTextAlignmentCenter;

        _nameLabel = [[UILabel alloc] init];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.font = XGWSemiboldFont(15);
        _nameLabel.textColor = XGWColorHex(0x1D2433);
        _nameLabel.numberOfLines = 2;

        _roleLabel = [[UILabel alloc] init];
        _roleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _roleLabel.font = XGWRegularFont(13);
        _roleLabel.textColor = XGWColorHex(0x687083);
        _roleLabel.numberOfLines = 2;

        _priceLabel = [[UILabel alloc] init];
        _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _priceLabel.font = XGWSemiboldFont(13);
        _priceLabel.textColor = XGWColorHex(0xE64340);
        _priceLabel.textAlignment = NSTextAlignmentRight;
        [_priceLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_priceLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"更多"]];
        arrowView.translatesAutoresizingMaskIntoConstraints = NO;
        arrowView.contentMode = UIViewContentModeScaleAspectFit;

        [self.contentView addSubview:_cardView];
        [_cardView addSubview:_avatarImageView];
        [_cardView addSubview:_badgeLabel];
        [_cardView addSubview:_nameLabel];
        [_cardView addSubview:_roleLabel];
        [_cardView addSubview:_priceLabel];
        [_cardView addSubview:arrowView];

        [NSLayoutConstraint activateConstraints:@[
            [_cardView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:12.0],
            [_cardView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16.0],
            [_cardView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16.0],
            [_cardView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-4.0],

            [_avatarImageView.topAnchor constraintEqualToAnchor:_cardView.topAnchor constant:16.0],
            [_avatarImageView.leadingAnchor constraintEqualToAnchor:_cardView.leadingAnchor constant:16.0],
            [_avatarImageView.bottomAnchor constraintLessThanOrEqualToAnchor:_cardView.bottomAnchor constant:-16.0],
            [_avatarImageView.widthAnchor constraintEqualToConstant:56.0],
            [_avatarImageView.heightAnchor constraintEqualToConstant:56.0],

            [_badgeLabel.topAnchor constraintEqualToAnchor:_cardView.topAnchor constant:16.0],
            [_badgeLabel.leadingAnchor constraintEqualToAnchor:_avatarImageView.trailingAnchor constant:12.0],
            [_badgeLabel.heightAnchor constraintEqualToConstant:20.0],
            [_badgeLabel.widthAnchor constraintGreaterThanOrEqualToConstant:52.0],

            [_nameLabel.topAnchor constraintEqualToAnchor:_badgeLabel.bottomAnchor constant:8.0],
            [_nameLabel.leadingAnchor constraintEqualToAnchor:_badgeLabel.leadingAnchor],
            [_nameLabel.trailingAnchor constraintLessThanOrEqualToAnchor:_priceLabel.leadingAnchor constant:-12.0],

            [_roleLabel.topAnchor constraintEqualToAnchor:_nameLabel.bottomAnchor constant:6.0],
            [_roleLabel.leadingAnchor constraintEqualToAnchor:_nameLabel.leadingAnchor],
            [_roleLabel.trailingAnchor constraintEqualToAnchor:arrowView.leadingAnchor constant:-8.0],
            [_roleLabel.bottomAnchor constraintEqualToAnchor:_cardView.bottomAnchor constant:-16.0],

            [_priceLabel.centerYAnchor constraintEqualToAnchor:_nameLabel.centerYAnchor],
            [_priceLabel.trailingAnchor constraintEqualToAnchor:arrowView.leadingAnchor constant:-8.0],

            [arrowView.centerYAnchor constraintEqualToAnchor:_cardView.centerYAnchor],
            [arrowView.trailingAnchor constraintEqualToAnchor:_cardView.trailingAnchor constant:-16.0],
            [arrowView.widthAnchor constraintEqualToConstant:12.0],
            [arrowView.heightAnchor constraintEqualToConstant:12.0],
        ]];
    }
    return self;
}

- (void)configureWithAvatar:(NSString *)avatar
                       name:(NSString *)name
                       role:(NSString *)role
                      price:(NSString *)price
                      badge:(NSString *)badge {
    [self.avatarImageView sd_setImageWithUrl:avatar placeHolder:[UIImage imageNamed:@"头像"]];
    self.badgeLabel.text = [NSString stringWithFormat:@"  %@  ", badge];
    self.nameLabel.text = XGWDisplayText(name, @"未命名成员");
    self.roleLabel.text = XGWDisplayText(role, @"暂未填写职位");
    self.priceLabel.text = XGWHasText(price) ? [NSString stringWithFormat:@"¥%@", price] : @"";
}

@end

@interface XGWClubWorkCell : UITableViewCell

- (void)configureWithCover:(NSString *)cover
                     title:(NSString *)title
                      meta:(NSString *)meta
                    budget:(NSString *)budget
                       tag:(NSString *)tag;

@end

@interface XGWClubWorkCell ()

@property (nonatomic, strong) UIView *cardView;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *metaLabel;
@property (nonatomic, strong) UILabel *budgetLabel;

@end

@implementation XGWClubWorkCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        _cardView = [[UIView alloc] init];
        _cardView.translatesAutoresizingMaskIntoConstraints = NO;
        _cardView.backgroundColor = [UIColor whiteColor];
        _cardView.layer.cornerRadius = 18.0;

        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.clipsToBounds = YES;
        _coverImageView.layer.cornerRadius = 14.0;

        _tagLabel = [[UILabel alloc] init];
        _tagLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _tagLabel.font = XGWRegularFont(11);
        _tagLabel.textColor = XGWColorHex(0xC25D10);
        _tagLabel.backgroundColor = XGWColorHex(0xFFF3E6);
        _tagLabel.layer.cornerRadius = 10.0;
        _tagLabel.clipsToBounds = YES;
        _tagLabel.textAlignment = NSTextAlignmentCenter;

        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = XGWSemiboldFont(15);
        _titleLabel.textColor = XGWColorHex(0x1D2433);
        _titleLabel.numberOfLines = 2;

        _metaLabel = [[UILabel alloc] init];
        _metaLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _metaLabel.font = XGWRegularFont(12);
        _metaLabel.textColor = XGWColorHex(0x687083);
        _metaLabel.numberOfLines = 2;

        _budgetLabel = [[UILabel alloc] init];
        _budgetLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _budgetLabel.font = XGWSemiboldFont(13);
        _budgetLabel.textColor = XGWColorHex(0xE64340);
        _budgetLabel.numberOfLines = 2;

        [self.contentView addSubview:_cardView];
        [_cardView addSubview:_coverImageView];
        [_cardView addSubview:_tagLabel];
        [_cardView addSubview:_titleLabel];
        [_cardView addSubview:_metaLabel];
        [_cardView addSubview:_budgetLabel];

        [NSLayoutConstraint activateConstraints:@[
            [_cardView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:12.0],
            [_cardView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16.0],
            [_cardView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16.0],
            [_cardView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-4.0],

            [_coverImageView.topAnchor constraintEqualToAnchor:_cardView.topAnchor constant:14.0],
            [_coverImageView.leadingAnchor constraintEqualToAnchor:_cardView.leadingAnchor constant:14.0],
            [_coverImageView.bottomAnchor constraintLessThanOrEqualToAnchor:_cardView.bottomAnchor constant:-14.0],
            [_coverImageView.widthAnchor constraintEqualToConstant:118.0],
            [_coverImageView.heightAnchor constraintEqualToConstant:90.0],

            [_tagLabel.topAnchor constraintEqualToAnchor:_coverImageView.topAnchor],
            [_tagLabel.leadingAnchor constraintEqualToAnchor:_coverImageView.trailingAnchor constant:12.0],
            [_tagLabel.heightAnchor constraintEqualToConstant:20.0],
            [_tagLabel.widthAnchor constraintGreaterThanOrEqualToConstant:52.0],

            [_titleLabel.topAnchor constraintEqualToAnchor:_tagLabel.bottomAnchor constant:8.0],
            [_titleLabel.leadingAnchor constraintEqualToAnchor:_tagLabel.leadingAnchor],
            [_titleLabel.trailingAnchor constraintEqualToAnchor:_cardView.trailingAnchor constant:-14.0],

            [_metaLabel.topAnchor constraintEqualToAnchor:_titleLabel.bottomAnchor constant:8.0],
            [_metaLabel.leadingAnchor constraintEqualToAnchor:_titleLabel.leadingAnchor],
            [_metaLabel.trailingAnchor constraintEqualToAnchor:_titleLabel.trailingAnchor],

            [_budgetLabel.topAnchor constraintEqualToAnchor:_metaLabel.bottomAnchor constant:8.0],
            [_budgetLabel.leadingAnchor constraintEqualToAnchor:_metaLabel.leadingAnchor],
            [_budgetLabel.trailingAnchor constraintEqualToAnchor:_metaLabel.trailingAnchor],
            [_budgetLabel.bottomAnchor constraintEqualToAnchor:_cardView.bottomAnchor constant:-14.0],
        ]];
    }
    return self;
}

- (void)configureWithCover:(NSString *)cover
                     title:(NSString *)title
                      meta:(NSString *)meta
                    budget:(NSString *)budget
                       tag:(NSString *)tag {
    [self.coverImageView sd_setImageWithUrl:cover placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.tagLabel.text = [NSString stringWithFormat:@"  %@  ", tag];
    self.titleLabel.text = XGWDisplayText(title, @"未命名作品");
    self.metaLabel.text = meta;
    self.budgetLabel.text = budget;
}

@end

@interface XGWClubContactCell : UITableViewCell

@property (nonatomic, copy) dispatch_block_t callAction;

- (void)configureWithName:(NSString *)name
                    badge:(NSString *)badge
                    phone:(NSString *)phone;

@end

@interface XGWClubContactCell ()

@property (nonatomic, strong) UIView *cardView;
@property (nonatomic, strong) UILabel *badgeLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIButton *callButton;

@end

@implementation XGWClubContactCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        _cardView = [[UIView alloc] init];
        _cardView.translatesAutoresizingMaskIntoConstraints = NO;
        _cardView.backgroundColor = [UIColor whiteColor];
        _cardView.layer.cornerRadius = 18.0;

        _badgeLabel = [[UILabel alloc] init];
        _badgeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _badgeLabel.font = XGWRegularFont(11);
        _badgeLabel.textColor = XGWColorHex(0x1760A5);
        _badgeLabel.backgroundColor = XGWColorHex(0xEAF4FF);
        _badgeLabel.layer.cornerRadius = 10.0;
        _badgeLabel.clipsToBounds = YES;
        _badgeLabel.textAlignment = NSTextAlignmentCenter;

        _nameLabel = [[UILabel alloc] init];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.font = XGWSemiboldFont(15);
        _nameLabel.textColor = XGWColorHex(0x1D2433);

        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _phoneLabel.font = XGWRegularFont(13);
        _phoneLabel.textColor = XGWColorHex(0x687083);

        _callButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _callButton.translatesAutoresizingMaskIntoConstraints = NO;
        _callButton.backgroundColor = XGWColorHex(0xE64340);
        _callButton.layer.cornerRadius = 16.0;
        _callButton.titleLabel.font = XGWSemiboldFont(13);
        [_callButton setTitle:@"拨打" forState:UIControlStateNormal];
        [_callButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_callButton addTarget:self action:@selector(handleCallAction) forControlEvents:UIControlEventTouchUpInside];

        [self.contentView addSubview:_cardView];
        [_cardView addSubview:_badgeLabel];
        [_cardView addSubview:_nameLabel];
        [_cardView addSubview:_phoneLabel];
        [_cardView addSubview:_callButton];

        [NSLayoutConstraint activateConstraints:@[
            [_cardView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:12.0],
            [_cardView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16.0],
            [_cardView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16.0],
            [_cardView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-4.0],

            [_badgeLabel.topAnchor constraintEqualToAnchor:_cardView.topAnchor constant:16.0],
            [_badgeLabel.leadingAnchor constraintEqualToAnchor:_cardView.leadingAnchor constant:16.0],
            [_badgeLabel.heightAnchor constraintEqualToConstant:20.0],
            [_badgeLabel.widthAnchor constraintGreaterThanOrEqualToConstant:52.0],

            [_nameLabel.topAnchor constraintEqualToAnchor:_badgeLabel.bottomAnchor constant:8.0],
            [_nameLabel.leadingAnchor constraintEqualToAnchor:_badgeLabel.leadingAnchor],
            [_nameLabel.trailingAnchor constraintLessThanOrEqualToAnchor:_callButton.leadingAnchor constant:-12.0],

            [_phoneLabel.topAnchor constraintEqualToAnchor:_nameLabel.bottomAnchor constant:6.0],
            [_phoneLabel.leadingAnchor constraintEqualToAnchor:_nameLabel.leadingAnchor],
            [_phoneLabel.bottomAnchor constraintEqualToAnchor:_cardView.bottomAnchor constant:-16.0],

            [_callButton.centerYAnchor constraintEqualToAnchor:_cardView.centerYAnchor],
            [_callButton.trailingAnchor constraintEqualToAnchor:_cardView.trailingAnchor constant:-16.0],
            [_callButton.widthAnchor constraintEqualToConstant:72.0],
            [_callButton.heightAnchor constraintEqualToConstant:32.0],
        ]];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.callAction = nil;
}

- (void)configureWithName:(NSString *)name
                    badge:(NSString *)badge
                    phone:(NSString *)phone {
    self.badgeLabel.text = [NSString stringWithFormat:@"  %@  ", badge];
    self.nameLabel.text = XGWDisplayText(name, @"未命名联系人");
    self.phoneLabel.text = XGWDisplayText(phone, @"未填写联系电话");
}

- (void)handleCallAction {
    if (self.callAction) {
        self.callAction();
    }
}

@end

@interface ShetuanDetilViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomBar;
@property (nonatomic, strong) UIButton *bottomActionButton;
@property (nonatomic, strong) UIView *topBarView;
@property (nonatomic, strong) UIView *topBarBackgroundView;
@property (nonatomic, strong) UILabel *topTitleLabel;
@property (nonatomic, strong) UIButton *floatingBackButton;
@property (nonatomic, strong) UIButton *floatingShareButton;
@property (nonatomic, strong) ShetuanDetilViewModel *viewModel;
@property (nonatomic, strong) ShareNewmodel *sharemodel;
@property (nonatomic, assign) XGWClubDetailTab currentTab;
@property (nonatomic, strong) NSLayoutConstraint *bottomActionBottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint *topBarHeightConstraint;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGesture;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGesture;

@end

@implementation ShetuanDetilViewController

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.currentTab = XGWClubDetailTabDynamic;
    self.view.backgroundColor = XGWColorHex(0xF5F6FA);
    self.title = @"";
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;

    [self setupViews];
    [self bindViewModel];
    [self shareData];
    [self requestAllData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self updateNavigationAppearanceForOffset:self.tableView.contentOffset.y];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (@available(iOS 11.0, *)) {
    } else {
        self.topBarHeightConstraint.constant = [self resolvedTopBarHeight];
    }
    [self updateNavigationAppearanceForOffset:self.tableView.contentOffset.y];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    UIViewController *targetViewController = [self targetViewControllerForNavigationTransition];
    BOOL targetPrefersHiddenNavigationBar = [self prefersHiddenNavigationBarForViewController:targetViewController];
    [self.navigationController setNavigationBarHidden:targetPrefersHiddenNavigationBar animated:NO];
}

- (void)setupViews {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 180.0;
    self.tableView.sectionHeaderHeight = 0.0;
    self.tableView.sectionFooterHeight = 0.0;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 92.0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
    }
    if (@available(iOS 15.0, *)) {
        self.tableView.sectionHeaderTopPadding = 0.0;
    }

    [self.tableView registerClass:[XGWClubHeroCell class] forCellReuseIdentifier:XGWClubHeroCellID];
    [self.tableView registerClass:[XGWClubDynamicCell class] forCellReuseIdentifier:XGWClubDynamicCellID];
    [self.tableView registerClass:[XGWClubMemberCell class] forCellReuseIdentifier:XGWClubMemberCellID];
    [self.tableView registerClass:[XGWClubWorkCell class] forCellReuseIdentifier:XGWClubWorkCellID];
    [self.tableView registerClass:[XGWClubContactCell class] forCellReuseIdentifier:XGWClubContactCellID];
    [self.tableView registerClass:[XGWClubEmptyCell class] forCellReuseIdentifier:XGWClubEmptyCellID];

    self.topBarView = [[UIView alloc] init];
    self.topBarView.translatesAutoresizingMaskIntoConstraints = NO;
    self.topBarView.backgroundColor = [UIColor clearColor];

    self.topBarBackgroundView = [[UIView alloc] init];
    self.topBarBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    self.topBarBackgroundView.backgroundColor = [UIColor whiteColor];
    self.topBarBackgroundView.alpha = 0.0;

    self.topTitleLabel = [[UILabel alloc] init];
    self.topTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.topTitleLabel.font = XGWSemiboldFont(17);
    self.topTitleLabel.textColor = XGWColorHex(0x1D2433);
    self.topTitleLabel.alpha = 0.0;
    self.topTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.topTitleLabel.text = @"";

    self.floatingBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.floatingBackButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.floatingBackButton.layer.cornerRadius = 18.0;
    self.floatingBackButton.backgroundColor = XGWColorHexAlpha(0x111827, 0.26);
    [self.floatingBackButton setImage:[[UIImage imageNamed:@"返回(white)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.floatingBackButton addTarget:self action:@selector(popViewConDelay) forControlEvents:UIControlEventTouchUpInside];

    self.floatingShareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.floatingShareButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.floatingShareButton.layer.cornerRadius = 18.0;
    self.floatingShareButton.backgroundColor = XGWColorHexAlpha(0x111827, 0.26);
    [self.floatingShareButton setImage:[[UIImage imageNamed:@"分享的副本"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.floatingShareButton addTarget:self action:@selector(respondsToRightBtn) forControlEvents:UIControlEventTouchUpInside];

    self.bottomBar = [[UIView alloc] init];
    self.bottomBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomBar.backgroundColor = [UIColor whiteColor];
    self.bottomBar.userInteractionEnabled = YES;

    self.bottomActionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomActionButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomActionButton.backgroundColor = XGWColorHex(0xE64340);
    self.bottomActionButton.layer.cornerRadius = 23.0;
    self.bottomActionButton.titleLabel.font = XGWSemiboldFont(16);
    [self.bottomActionButton setTitle:@"电话咨询" forState:UIControlStateNormal];
    [self.bottomActionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.bottomActionButton.layer.shadowColor = XGWColorHex(0x8F2B2A).CGColor;
    self.bottomActionButton.layer.shadowOpacity = 0.22;
    self.bottomActionButton.layer.shadowRadius = 16.0;
    self.bottomActionButton.layer.shadowOffset = CGSizeMake(0, 8);
    [self.bottomActionButton addTarget:self action:@selector(handleBottomAction) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.topBarView];
    [self.view addSubview:self.bottomBar];
    [self.topBarView addSubview:self.topBarBackgroundView];
    [self.topBarView addSubview:self.topTitleLabel];
    [self.topBarView addSubview:self.floatingBackButton];
    [self.topBarView addSubview:self.floatingShareButton];
    [self.bottomBar addSubview:self.bottomActionButton];

    self.leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleHorizontalSwipe:)];
    self.leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    self.leftSwipeGesture.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:self.leftSwipeGesture];

    self.rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleHorizontalSwipe:)];
    self.rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    self.rightSwipeGesture.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:self.rightSwipeGesture];

    CGFloat statusBarHeight = [self currentStatusBarHeight];
    NSMutableArray<NSLayoutConstraint *> *constraints = [NSMutableArray arrayWithArray:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],

        [self.topBarView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.topBarView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.topBarView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],

        [self.topBarBackgroundView.topAnchor constraintEqualToAnchor:self.topBarView.topAnchor],
        [self.topBarBackgroundView.leadingAnchor constraintEqualToAnchor:self.topBarView.leadingAnchor],
        [self.topBarBackgroundView.trailingAnchor constraintEqualToAnchor:self.topBarView.trailingAnchor],
        [self.topBarBackgroundView.bottomAnchor constraintEqualToAnchor:self.topBarView.bottomAnchor],

        [self.topTitleLabel.centerXAnchor constraintEqualToAnchor:self.topBarView.centerXAnchor],
        [self.topTitleLabel.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.topBarView.leadingAnchor constant:72.0],
        [self.topTitleLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.topBarView.trailingAnchor constant:-72.0],

        [self.floatingBackButton.widthAnchor constraintEqualToConstant:36.0],
        [self.floatingBackButton.heightAnchor constraintEqualToConstant:36.0],

        [self.floatingShareButton.widthAnchor constraintEqualToConstant:36.0],
        [self.floatingShareButton.heightAnchor constraintEqualToConstant:36.0],

        [self.bottomBar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.bottomBar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.bottomBar.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],

        [self.bottomActionButton.leadingAnchor constraintEqualToAnchor:self.bottomBar.leadingAnchor constant:16.0],
        [self.bottomActionButton.trailingAnchor constraintEqualToAnchor:self.bottomBar.trailingAnchor constant:-16.0],
        [self.bottomActionButton.topAnchor constraintEqualToAnchor:self.bottomBar.topAnchor constant:12.0],
        [self.bottomActionButton.heightAnchor constraintEqualToConstant:46.0],
    ]];
    if (@available(iOS 11.0, *)) {
        self.topBarHeightConstraint = [self.topBarView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:52.0];
        [constraints addObjectsFromArray:@[
            self.topBarHeightConstraint,
            [self.floatingBackButton.leadingAnchor constraintEqualToAnchor:self.topBarView.leadingAnchor constant:16.0],
            [self.floatingBackButton.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:8.0],
            [self.floatingShareButton.trailingAnchor constraintEqualToAnchor:self.topBarView.trailingAnchor constant:-16.0],
            [self.floatingShareButton.centerYAnchor constraintEqualToAnchor:self.floatingBackButton.centerYAnchor],
            [self.topTitleLabel.centerYAnchor constraintEqualToAnchor:self.floatingBackButton.centerYAnchor],
        ]];
    } else {
        self.topBarHeightConstraint = [self.topBarView.heightAnchor constraintEqualToConstant:statusBarHeight + 52.0];
        [constraints addObjectsFromArray:@[
            self.topBarHeightConstraint,
            [self.floatingBackButton.leadingAnchor constraintEqualToAnchor:self.topBarView.leadingAnchor constant:16.0],
            [self.floatingBackButton.topAnchor constraintEqualToAnchor:self.topBarView.topAnchor constant:statusBarHeight + 8.0],
            [self.floatingShareButton.trailingAnchor constraintEqualToAnchor:self.topBarView.trailingAnchor constant:-16.0],
            [self.floatingShareButton.centerYAnchor constraintEqualToAnchor:self.floatingBackButton.centerYAnchor],
            [self.topTitleLabel.centerYAnchor constraintEqualToAnchor:self.floatingBackButton.centerYAnchor],
        ]];
    }
    [NSLayoutConstraint activateConstraints:constraints];
    if (@available(iOS 11.0, *)) {
        self.bottomActionBottomConstraint = [self.bottomActionButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-12.0];
    } else {
        self.bottomActionBottomConstraint = [self.bottomActionButton.bottomAnchor constraintEqualToAnchor:self.bottomBar.bottomAnchor constant:-12.0];
    }
    self.bottomActionBottomConstraint.active = YES;

    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self requestAllData];
    }];
}

- (void)bindViewModel {
    @weakify(self);
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.viewModel.modelIndex = [ShetuanDetilModel mj_objectWithKeyValues:x];
        self.topTitleLabel.text = XGWDisplayText(self.viewModel.modelIndex.info.name, @"社团详情");
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        [self updateNavigationAppearanceForOffset:self.tableView.contentOffset.y];
    }];

    [self.viewModel.chengyuanUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.viewModel.modelChengyuan = [shetuanChengyuanModel mj_objectWithKeyValues:x];
        [self.tableView reloadData];
    }];

    [self.viewModel.zuopinUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.viewModel.modelZuopin = [shetuanZuppinModel mj_objectWithKeyValues:x];
        [self.tableView reloadData];
    }];

    [self.viewModel.lianxifangshiUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.viewModel.modellianxi = [ShetuanLinxiModel mj_objectWithKeyValues:x];
        [self.tableView reloadData];
    }];

    [self.viewModel.refreshDataCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)requestAllData {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if ([UserDataNew UserLoginState]) {
        [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
        [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    }
    [dic setValue:@(self.id) forKey:@"id"];
    [dic setValue:@"100" forKey:@"rows"];

    [self.viewModel.refreshDataCommand execute:dic];
    [self.viewModel.chengyuanDataCommand execute:dic];
    [self.viewModel.zuopinDataCommand execute:@{@"id": @(self.id)}];
    [self.viewModel.lianxifangshiDataCommand execute:@{@"id": @(self.id)}];
}

- (void)respondsToRightBtn {
    if (self.sharemodel) {
        [CwShareManager shareWebPageToPlatformWithUrl:self.sharemodel.url
                                                image:self.sharemodel.image
                                                title:self.sharemodel.title
                                                descr:self.sharemodel.descr
                                                   vc:self
                                           completion:^(id data, NSError *error) {
                                           }];
    }
}

- (void)shareData {
    NSDictionary *dic = @{@"id": @(self.id)};
    [[RequestManager sharedManager] requestUrl:[HOMEURL stringByAppendingString:@"appapi/share/fenxiangassociation"]
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager hiddenLoadingMessage];
                                               self.sharemodel = [ShareNewmodel mj_objectWithKeyValues:response[@"data"]];
                                           } else {
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           [NavigateManager hiddenLoadingMessage];
                                       }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.viewModel.modelIndex) {
        return 0;
    }
    if (section == 0) {
        return 1;
    }
    switch (self.currentTab) {
        case XGWClubDetailTabDynamic:
            return MAX(self.viewModel.modelIndex.dynamiclist.count, 1);
        case XGWClubDetailTabMember:
            return MAX([self memberRowCount], 1);
        case XGWClubDetailTabWork:
            return MAX([self workRowCount], 1);
        case XGWClubDetailTabContact:
            return MAX([self contactRowCount], 1);
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 && self.viewModel.modelIndex) {
        return 64.0;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1 && self.viewModel.modelIndex && ![self isCurrentTabEmpty]) {
        return [self contentFillFooterHeight];
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && [self isCurrentTabEmpty]) {
        return [self emptyTabContentHeight];
    }
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section != 1 || !self.viewModel.modelIndex) {
        return [UIView new];
    }
    XGWClubTabsHeaderView *headerView = [[XGWClubTabsHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 64.0)];
    [headerView configureWithSelectedIndex:self.currentTab
                              dynamicCount:self.viewModel.modelIndex.dynamiclist.count
                               memberCount:[self totalMemberCount]
                                 workCount:[self totalWorkCount]];
    @weakify(self);
    headerView.tabChanged = ^(NSInteger index) {
        @strongify(self);
        [self selectTab:index scrollToSection:NO];
    };
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        XGWClubHeroCell *cell = [tableView dequeueReusableCellWithIdentifier:XGWClubHeroCellID forIndexPath:indexPath];
        [cell configureWithInfo:self.viewModel.modelIndex.info
                   dynamicCount:self.viewModel.modelIndex.dynamiclist.count
                    memberCount:[self totalMemberCount]
                      workCount:[self totalWorkCount]];
        @weakify(self);
        cell.primaryAction = ^{
            @strongify(self);
            [self handleBottomAction];
        };
        cell.secondaryAction = ^{
            @strongify(self);
            [self selectTab:XGWClubDetailTabWork scrollToSection:YES];
        };
        return cell;
    }

    switch (self.currentTab) {
        case XGWClubDetailTabDynamic:
            return [self dynamicCellAtIndexPath:indexPath tableView:tableView];
        case XGWClubDetailTabMember:
            return [self memberCellAtIndexPath:indexPath tableView:tableView];
        case XGWClubDetailTabWork:
            return [self workCellAtIndexPath:indexPath tableView:tableView];
        case XGWClubDetailTabContact:
            return [self contactCellAtIndexPath:indexPath tableView:tableView];
    }
    return [UITableViewCell new];
}

- (UITableViewCell *)dynamicCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    if (self.viewModel.modelIndex.dynamiclist.count == 0) {
        XGWClubEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:XGWClubEmptyCellID forIndexPath:indexPath];
        [cell configureWithText:@"暂时还没有社团动态"];
        return cell;
    }

    Dynamiclist *model = self.viewModel.modelIndex.dynamiclist[indexPath.row];
    XGWClubDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:XGWClubDynamicCellID forIndexPath:indexPath];
    [cell configureWithModel:model];
    @weakify(self);
    cell.likeAction = ^{
        @strongify(self);
        [self handleLikeForDynamicAtIndex:indexPath.row];
    };
    cell.commentAction = ^{
        @strongify(self);
        [self handleCommentForDynamic:model];
    };
    return cell;
}

- (UITableViewCell *)memberCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    NSInteger totalCount = [self memberRowCount];
    if (totalCount == 0) {
        XGWClubEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:XGWClubEmptyCellID forIndexPath:indexPath];
        [cell configureWithText:@"暂时还没有成员信息"];
        return cell;
    }

    XGWClubMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:XGWClubMemberCellID forIndexPath:indexPath];
    if ([self hasFounderMember] && indexPath.row == 0) {
        Chuangshiren *model = self.viewModel.modelChengyuan.chuangshiren;
        [cell configureWithAvatar:model.head
                             name:model.nickname
                             role:model.occupation
                            price:model.zuidijia
                            badge:@"创始人"];
    } else {
        NSInteger offset = [self hasFounderMember] ? 1 : 0;
        Chengyuan *model = self.viewModel.modelChengyuan.chengyuan[indexPath.row - offset];
        [cell configureWithAvatar:model.head
                             name:model.nickname
                             role:model.occupation
                            price:model.zuidijia
                            badge:@"团队成员"];
    }
    return cell;
}

- (UITableViewCell *)workCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    NSInteger totalCount = [self workRowCount];
    if (totalCount == 0) {
        XGWClubEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:XGWClubEmptyCellID forIndexPath:indexPath];
        [cell configureWithText:@"暂时还没有作品展示"];
        return cell;
    }

    XGWClubWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:XGWClubWorkCellID forIndexPath:indexPath];
    if ([self hasFounderWork] && indexPath.row == 0) {
        Chuangshirenzuopin *model = self.viewModel.modelZuopin.chuangshiren;
        [cell configureWithCover:model.weddingcover
                           title:model.title
                            meta:[self metaTextForWorkPlace:model.weddingplace views:model.clicked time:model.weddingtime]
                          budget:[self budgetText:model.weddingexpenses]
                             tag:@"创始人作品"];
    } else {
        NSInteger offset = [self hasFounderWork] ? 1 : 0;
        Chengyuanzuopin *model = self.viewModel.modelZuopin.chengyuan[indexPath.row - offset];
        [cell configureWithCover:model.weddingcover
                           title:model.title
                            meta:[self metaTextForWorkPlace:model.weddingplace views:model.clicked time:model.weddingtime]
                          budget:[self budgetText:model.weddingexpenses]
                             tag:@"团队作品"];
    }
    return cell;
}

- (UITableViewCell *)contactCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    NSInteger totalCount = [self contactRowCount];
    if (totalCount == 0) {
        XGWClubEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:XGWClubEmptyCellID forIndexPath:indexPath];
        [cell configureWithText:@"暂时还没有联系方式"];
        return cell;
    }

    XGWClubContactCell *cell = [tableView dequeueReusableCellWithIdentifier:XGWClubContactCellID forIndexPath:indexPath];
    NSString *mobile = nil;
    if ([self hasFounderContact] && indexPath.row == 0) {
        ChuangshirenLianxi *model = self.viewModel.modellianxi.chuangshiren;
        mobile = model.mobile;
        [cell configureWithName:model.nickname badge:@"创始人" phone:model.mobile];
    } else {
        NSInteger offset = [self hasFounderContact] ? 1 : 0;
        ChengyuanLianxi *model = self.viewModel.modellianxi.chengyuan[indexPath.row - offset];
        mobile = model.mobile;
        [cell configureWithName:model.nickname badge:@"团队成员" phone:model.mobile];
    }
    @weakify(self);
    cell.callAction = ^{
        @strongify(self);
        [self attemptCallPhone:mobile];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 1) {
        return;
    }

    switch (self.currentTab) {
        case XGWClubDetailTabDynamic: {
            if (self.viewModel.modelIndex.dynamiclist.count == 0) {
                return;
            }
            Dynamiclist *model = self.viewModel.modelIndex.dynamiclist[indexPath.row];
            Hunqinnewarray *modelnew = [[Hunqinnewarray alloc] init];
            modelnew.zan = model.myzan;
            modelnew.follow = model.follow;

            DongtaiDetilViewController *dongtai = [[DongtaiDetilViewController alloc] init];
            dongtai.id = model.id;
            dongtai.superModel = modelnew;
            dongtai.hidesBottomBarWhenPushed = YES;
            [self pushToNextVCWithNextVC:dongtai];
            break;
        }
        case XGWClubDetailTabMember: {
            NSDictionary *personInfo = [self personInfoForRow:indexPath.row];
            if (personInfo) {
                [self openPersonDetail:personInfo];
            }
            break;
        }
        case XGWClubDetailTabWork: {
            NSNumber *workId = [self workIdForRow:indexPath.row];
            if (workId) {
                AnlieNewDetilViewController *vc = [[AnlieNewDetilViewController alloc] init];
                vc.anlieID = workId.integerValue;
                [self pushToNextVCWithNextVC:vc];
            }
            break;
        }
        case XGWClubDetailTabContact: {
            NSString *phone = [self phoneForContactRow:indexPath.row];
            [self attemptCallPhone:phone];
            break;
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.viewModel.modelIndex) {
        [self updateNavigationAppearanceForOffset:scrollView.contentOffset.y];
        return;
    }
    [self updateNavigationAppearanceForOffset:scrollView.contentOffset.y];
    XGWClubHeroCell *heroCell = (XGWClubHeroCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if ([heroCell isKindOfClass:[XGWClubHeroCell class]]) {
        [heroCell updateWithScrollOffset:scrollView.contentOffset.y];
    }
}

- (void)handleBottomAction {
    NSString *phone = self.viewModel.modellianxi.chuangshiren.mobile;
    if (XGWHasText(phone)) {
        [self attemptCallPhone:phone];
        return;
    }
    [self selectTab:XGWClubDetailTabContact scrollToSection:YES];
}

- (void)updateNavigationAppearanceForOffset:(CGFloat)offsetY {
    CGFloat fadeDistance = 96.0;
    CGFloat stickyOffset = [self tabStickyOffset];
    CGFloat fadeStart = MAX(stickyOffset - fadeDistance, 0.0);
    CGFloat progress = MIN(MAX((offsetY - fadeStart) / fadeDistance, 0.0), 1.0);
    CGFloat easedProgress = MIN(MAX(progress, 0.0), 1.0);
    self.topBarBackgroundView.alpha = easedProgress;
    self.topTitleLabel.alpha = easedProgress;

    UIColor *buttonBackground = easedProgress < 0.58
        ? XGWColorHexAlpha(0x111827, 0.26)
        : [UIColor colorWithWhite:1.0 alpha:0.92];
    self.floatingBackButton.backgroundColor = buttonBackground;
    self.floatingShareButton.backgroundColor = buttonBackground;

    BOOL showsDarkIcon = easedProgress > 0.58;
    UIColor *iconColor = showsDarkIcon ? XGWColorHex(0x111827) : XGWColorHex(0xE64340);
    self.floatingBackButton.tintColor = iconColor;
    self.floatingShareButton.tintColor = iconColor;

    UIImage *backImage = [UIImage imageNamed:@"返回(white)"];
    UIImage *shareImage = [UIImage imageNamed:@"分享的副本"];
    UIImageRenderingMode mode = UIImageRenderingModeAlwaysTemplate;
    [self.floatingBackButton setImage:[backImage imageWithRenderingMode:mode] forState:UIControlStateNormal];
    [self.floatingShareButton setImage:[shareImage imageWithRenderingMode:mode] forState:UIControlStateNormal];
}

- (CGFloat)tabStickyOffset {
    CGFloat stickyOffset = MAX(XGWClubHeroCoverHeight() - [self resolvedTopBarHeight], 0.0);
    if (self.viewModel.modelIndex && [self.tableView numberOfSections] > 1) {
        CGRect headerRect = [self.tableView rectForHeaderInSection:1];
        if (!CGRectIsEmpty(headerRect)) {
            stickyOffset = MAX(headerRect.origin.y - [self resolvedTopBarHeight], 0.0);
        }
    }
    return stickyOffset;
}

- (CGFloat)minimumTabContentHeight {
    CGFloat visibleHeight = [self tabVisibleContentHeight];
    return MAX(visibleHeight + 12.0, 280.0);
}

- (CGFloat)emptyTabContentHeight {
    CGFloat visibleHeight = [self tabVisibleContentHeight];
    return MAX(visibleHeight + 140.0, 420.0);
}

- (CGFloat)tabVisibleContentHeight {
    CGFloat viewportHeight = CGRectGetHeight(self.tableView.bounds);
    if (viewportHeight <= 0.0) {
        viewportHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    }

    CGFloat bottomInset = self.tableView.contentInset.bottom;
    if (@available(iOS 11.0, *)) {
        bottomInset = self.tableView.adjustedContentInset.bottom;
    }

    return viewportHeight - [self resolvedTopBarHeight] - 64.0 - bottomInset;
}

- (CGFloat)contentFillFooterHeight {
    CGFloat minimumHeight = [self minimumTabContentHeight];
    CGFloat estimatedHeight = 0.0;
    switch (self.currentTab) {
        case XGWClubDetailTabDynamic:
            estimatedHeight = self.viewModel.modelIndex.dynamiclist.count * 308.0;
            break;
        case XGWClubDetailTabMember:
            estimatedHeight = [self memberRowCount] * 128.0;
            break;
        case XGWClubDetailTabWork:
            estimatedHeight = [self workRowCount] * 156.0;
            break;
        case XGWClubDetailTabContact:
            estimatedHeight = [self contactRowCount] * 98.0;
            break;
    }
    return MAX(minimumHeight - estimatedHeight, 0.0001);
}

- (BOOL)isCurrentTabEmpty {
    switch (self.currentTab) {
        case XGWClubDetailTabDynamic:
            return self.viewModel.modelIndex.dynamiclist.count == 0;
        case XGWClubDetailTabMember:
            return [self memberRowCount] == 0;
        case XGWClubDetailTabWork:
            return [self workRowCount] == 0;
        case XGWClubDetailTabContact:
            return [self contactRowCount] == 0;
    }
    return NO;
}

- (CGFloat)resolvedTopBarHeight {
    CGFloat safeTop = 0.0;
    if (@available(iOS 11.0, *)) {
        safeTop = self.view.safeAreaInsets.top;
    }
    if (safeTop <= 0.0) {
        safeTop = [self currentStatusBarHeight];
    }
    return safeTop + 52.0;
}

- (CGFloat)currentStatusBarHeight {
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = self.view.window.windowScene;
        if (!windowScene) {
            for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
                if ([scene isKindOfClass:[UIWindowScene class]]) {
                    windowScene = (UIWindowScene *)scene;
                    if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                        break;
                    }
                }
            }
        }
        UIStatusBarManager *manager = windowScene.statusBarManager;
        if (manager) {
            return manager.statusBarFrame.size.height;
        }
    }
    return UIApplication.sharedApplication.statusBarFrame.size.height ?: 20.0;
}

- (UIViewController *)targetViewControllerForNavigationTransition {
    UINavigationController *navigationController = self.navigationController;
    if (!navigationController) {
        return nil;
    }

    NSArray<UIViewController *> *viewControllers = navigationController.viewControllers;
    NSUInteger currentIndex = [viewControllers indexOfObject:self];
    if (currentIndex == NSNotFound) {
        return navigationController.topViewController;
    }

    if (self.isMovingFromParentViewController || self.isBeingDismissed) {
        if (currentIndex > 0) {
            return viewControllers[currentIndex - 1];
        }
        return nil;
    }

    UIViewController *topViewController = navigationController.topViewController;
    if (topViewController != self) {
        return topViewController;
    }

    if (viewControllers.count > currentIndex + 1) {
        return viewControllers[currentIndex + 1];
    }
    return nil;
}

- (BOOL)prefersHiddenNavigationBarForViewController:(UIViewController *)viewController {
    if (!viewController) {
        return NO;
    }

    static NSSet<NSString *> *hiddenNavigationBarClasses;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hiddenNavigationBarClasses = [NSSet setWithArray:@[
            @"IndexViewController",
            @"IndexSubViewController"
        ]];
    });

    UIViewController *candidate = viewController;
    while (candidate) {
        NSString *className = NSStringFromClass([candidate class]);
        if ([hiddenNavigationBarClasses containsObject:className]) {
            return YES;
        }
        candidate = candidate.parentViewController;
    }
    return NO;
}

- (void)handleHorizontalSwipe:(UISwipeGestureRecognizer *)gesture {
    if (!self.viewModel.modelIndex) {
        return;
    }
    CGFloat stickyOffset = [self tabStickyOffset];
    if (self.tableView.contentOffset.y + 2.0 < stickyOffset) {
        return;
    }

    NSInteger delta = gesture.direction == UISwipeGestureRecognizerDirectionLeft ? 1 : -1;
    NSInteger targetIndex = self.currentTab + delta;
    if (targetIndex < XGWClubDetailTabDynamic || targetIndex > XGWClubDetailTabContact) {
        return;
    }

    [self selectTab:(XGWClubDetailTab)targetIndex scrollToSection:NO];
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat fixedOffset = MAX(self.tableView.contentOffset.y, stickyOffset);
        [self.tableView setContentOffset:CGPointMake(0, fixedOffset) animated:NO];
    });
}

- (void)selectTab:(XGWClubDetailTab)tab scrollToSection:(BOOL)scrollToSection {
    self.currentTab = tab;
    [self.tableView reloadData];
    if (scrollToSection) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.tableView numberOfSections] > 1) {
                CGRect headerRect = [self.tableView rectForHeaderInSection:1];
                if (!CGRectIsEmpty(headerRect)) {
                    CGFloat offsetY = MAX(headerRect.origin.y - [self resolvedTopBarHeight], 0.0);
                    [self.tableView setContentOffset:CGPointMake(0, offsetY) animated:YES];
                }
            }
        });
    }
}

- (void)handleLikeForDynamicAtIndex:(NSInteger)index {
    if (index >= self.viewModel.modelIndex.dynamiclist.count) {
        return;
    }
    if (![UserDataNew UserLoginState]) {
        [self openLoginIfNeeded];
        return;
    }

    Dynamiclist *model = self.viewModel.modelIndex.dynamiclist[index];
    if (model.myzan) {
        [NavigateManager showMessage:@"您已点过赞"];
        return;
    }

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[UserDataNew sharedManager].userInfoModel.token.token forKey:@"token"];
    [dic setValue:@([UserDataNew sharedManager].userInfoModel.token.userid) forKey:@"userid"];
    [dic setValue:[NSString stringWithFormat:@"%ld", (long)model.id] forKey:@"id"];
    [self.viewModel.dianzanCommand execute:dic];
    model.myzan = 1;
    model.zan += 1;

    NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:1];
    if ([[self.tableView indexPathsForVisibleRows] containsObject:path]) {
        [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)handleCommentForDynamic:(Dynamiclist *)model {
    [HuifuiPL showInView:self.view setid:model.id block:^(NSString *date) {
        [self.tableView.mj_header beginRefreshing];
    }];
}

- (void)attemptCallPhone:(NSString *)phone {
    if (!XGWHasText(phone)) {
        [self selectTab:XGWClubDetailTabContact scrollToSection:YES];
        return;
    }
    if (![UserDataNew UserLoginState]) {
        [self openLoginIfNeeded];
        return;
    }

    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phone];
    NSURL *url = [NSURL URLWithString:callPhone];
    if (!url) {
        return;
    }
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 10.0) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)openLoginIfNeeded {
    NewLoginViewController *vc = [[NewLoginViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self pushToNextVCWithNextVC:vc];
}

- (void)openPersonDetail:(NSDictionary *)info {
    if ([info[@"usertype"] isEqualToString:@"1"]) {
        ShangchengsjNewDetilViewController *vc = [[ShangchengsjNewDetilViewController alloc] init];
        vc.id = [info[@"userid"] integerValue];
        [self pushToNextVCWithNextVC:vc];
    } else {
        NewShangjiaViewController *vc = [[NewShangjiaViewController alloc] init];
        vc.shopid = [info[@"userid"] integerValue];
        [self pushToNextVCWithNextVC:vc];
    }
}

- (NSDictionary *)personInfoForRow:(NSInteger)row {
    if ([self hasFounderMember] && row == 0) {
        Chuangshiren *model = self.viewModel.modelChengyuan.chuangshiren;
        if (model.userid <= 0) {
            return nil;
        }
        return @{
            @"userid": @(model.userid),
            @"usertype": [NSString stringWithFormat:@"%ld", (long)model.usertype]
        };
    }
    NSInteger offset = [self hasFounderMember] ? 1 : 0;
    NSInteger index = row - offset;
    if (index < 0 || index >= self.viewModel.modelChengyuan.chengyuan.count) {
        return nil;
    }
    Chengyuan *model = self.viewModel.modelChengyuan.chengyuan[index];
    return @{
        @"userid": @(model.userid),
        @"usertype": [NSString stringWithFormat:@"%ld", (long)model.usertype]
    };
}

- (NSNumber *)workIdForRow:(NSInteger)row {
    if ([self hasFounderWork] && row == 0) {
        return @(self.viewModel.modelZuopin.chuangshiren.id);
    }
    NSInteger offset = [self hasFounderWork] ? 1 : 0;
    NSInteger index = row - offset;
    if (index < 0 || index >= self.viewModel.modelZuopin.chengyuan.count) {
        return nil;
    }
    Chengyuanzuopin *model = self.viewModel.modelZuopin.chengyuan[index];
    return @(model.id);
}

- (NSString *)phoneForContactRow:(NSInteger)row {
    if ([self hasFounderContact] && row == 0) {
        return self.viewModel.modellianxi.chuangshiren.mobile;
    }
    NSInteger offset = [self hasFounderContact] ? 1 : 0;
    NSInteger index = row - offset;
    if (index < 0 || index >= self.viewModel.modellianxi.chengyuan.count) {
        return nil;
    }
    return self.viewModel.modellianxi.chengyuan[index].mobile;
}

- (NSInteger)memberRowCount {
    NSInteger count = self.viewModel.modelChengyuan.chengyuan.count;
    if ([self hasFounderMember]) {
        count += 1;
    }
    return count;
}

- (NSInteger)workRowCount {
    NSInteger count = self.viewModel.modelZuopin.chengyuan.count;
    if ([self hasFounderWork]) {
        count += 1;
    }
    return count;
}

- (NSInteger)contactRowCount {
    NSInteger count = self.viewModel.modellianxi.chengyuan.count;
    if ([self hasFounderContact]) {
        count += 1;
    }
    return count;
}

- (NSInteger)totalMemberCount {
    return [self memberRowCount];
}

- (NSInteger)totalWorkCount {
    return [self workRowCount];
}

- (BOOL)hasFounderMember {
    Chuangshiren *model = self.viewModel.modelChengyuan.chuangshiren;
    return model != nil && (model.userid > 0 || XGWHasText(model.nickname) || XGWHasText(model.head));
}

- (BOOL)hasFounderWork {
    Chuangshirenzuopin *model = self.viewModel.modelZuopin.chuangshiren;
    return model != nil && (model.id > 0 || XGWHasText(model.title) || XGWHasText(model.weddingcover));
}

- (BOOL)hasFounderContact {
    ChuangshirenLianxi *model = self.viewModel.modellianxi.chuangshiren;
    return model != nil && (model.userid > 0 || XGWHasText(model.mobile) || XGWHasText(model.nickname));
}

- (NSString *)metaTextForWorkPlace:(NSString *)place views:(NSInteger)views time:(NSString *)time {
    NSMutableArray *parts = [NSMutableArray array];
    if (XGWHasText(place)) {
        [parts addObject:place];
    }
    if (XGWHasText(time)) {
        [parts addObject:time];
    }
    [parts addObject:[NSString stringWithFormat:@"%@ 浏览", XGWNumberString(views)]];
    return [parts componentsJoinedByString:@"  ·  "];
}

- (NSString *)budgetText:(NSInteger)budget {
    if (budget > 0) {
        return [NSString stringWithFormat:@"预算 ¥%ld", (long)budget];
    }
    return @"预算待沟通";
}

- (ShetuanDetilViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ShetuanDetilViewModel alloc] init];
    }
    return _viewModel;
}

@end
