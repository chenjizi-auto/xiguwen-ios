//
//  MyNewshangjiaCellTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyNewshangjiaCellTableViewCell.h"

@interface MyNewshangjiaCellTableViewCell ()

@property (nonatomic, strong) UIStackView *contentStackView;

@end

@implementation MyNewshangjiaCellTableViewCell

+ (CGFloat)cellHeight {
    return (44.0f + 76.0f)
        + 8.0f
        + (84.0f * 2)
        + 8.0f
        + (44.0f + 84.0f * 2)
        + 8.0f
        + (44.0f + 84.0f * 2)
        + 8.0f
        + 50.0f * 4;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self cw_commonInit];
    }
    return self;
}

- (RACSubject *)gotoNextVc {
    if (!_gotoNextVc) {
        _gotoNextVc = [RACSubject subject];
    }
    return _gotoNextVc;
}

- (void)cw_commonInit {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.97f alpha:1.0f];
    self.contentView.backgroundColor = self.backgroundColor;

    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 0.0f;
    [self.contentView addSubview:stackView];
    self.contentStackView = stackView;

    [NSLayoutConstraint activateConstraints:@[
        [stackView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
        [stackView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        [stackView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        [stackView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor]
    ]];

    [self cw_addArrangedSection:[self cw_makeOrderSectionWithTitle:@"商城接单"
                                                             items:[self cw_orderItems]]];
    [self cw_addSpacer];
    [self cw_addArrangedSection:[self cw_makeGridSectionWithItems:[self cw_quickItems]
                                                          columns:4
                                                      sectionName:nil]];
    [self cw_addSpacer];
    [self cw_addArrangedSection:[self cw_makeGridSectionWithItems:[self cw_managementItems]
                                                          columns:3
                                                      sectionName:@"店铺管理"]];
    [self cw_addSpacer];
    [self cw_addArrangedSection:[self cw_makeGridSectionWithItems:[self cw_toolItems]
                                                          columns:4
                                                      sectionName:@"常用工具"]];
    [self cw_addSpacer];
    [self cw_addArrangedSection:[self cw_makeListSectionWithItems:[self cw_bottomMenuItems]]];
}

- (NSArray<NSDictionary *> *)cw_quickItems {
    return @[
        @{@"tag": @21, @"title": @"实名认证", @"image": @"实名认证", @"iconWidth": @24, @"iconHeight": @24},
        @{@"tag": @22, @"title": @"我的需求", @"image": @"我的需求", @"iconWidth": @24, @"iconHeight": @24},
        @{@"tag": @23, @"title": @"我的社团", @"image": @"我的社团", @"iconWidth": @24, @"iconHeight": @24},
        @{@"tag": @24, @"title": @"我的邀请", @"image": @"我的邀请", @"iconWidth": @24, @"iconHeight": @24},
        @{@"tag": @27, @"title": @"婚礼新闻", @"image": @"婚礼新闻", @"iconWidth": @24, @"iconHeight": @24},
        @{@"tag": @202, @"title": @"活动投票", @"image": @"活动投票", @"iconWidth": @24, @"iconHeight": @24}
    ];
}

- (NSArray<NSDictionary *> *)cw_managementItems {
    return @[
        @{@"tag": @31, @"title": @"店铺信息", @"image": @"信息管理", @"iconWidth": @24, @"iconHeight": @24},
        @{@"tag": @32, @"title": @"我的认证", @"image": @"店铺认证", @"iconWidth": @24, @"iconHeight": @24},
        @{@"tag": @35, @"title": @"我的商品", @"image": @"我的商品", @"iconWidth": @24, @"iconHeight": @24},
        @{@"tag": @40, @"title": @"推荐团队", @"image": @"推荐团队", @"iconWidth": @24, @"iconHeight": @24},
        @{@"tag": @41, @"title": @"查看需求", @"image": @"查看需求", @"iconWidth": @24, @"iconHeight": @24},
        @{@"tag": @49, @"title": @"店铺主页", @"image": @"店铺主页", @"iconWidth": @24, @"iconHeight": @24}
    ];
}

- (NSArray<NSDictionary *> *)cw_toolItems {
    return @[
        @{@"tag": @51, @"title": @"发布需求", @"image": @"发布需求", @"iconWidth": @24, @"iconHeight": @24},
        @{@"tag": @52, @"title": @"黄道吉日", @"image": @"黄道吉日", @"iconWidth": @24, @"iconHeight": @24},
        @{@"tag": @53, @"title": @"电子请柬", @"image": @"电子请柬my", @"iconWidth": @24, @"iconHeight": @24},
        @{@"tag": @54, @"title": @"日程安排", @"image": @"日程安排my", @"iconWidth": @24, @"iconHeight": @24},
        @{@"tag": @55, @"title": @"婚礼宝典", @"image": @"发言稿", @"iconWidth": @24, @"iconHeight": @24},
        @{@"tag": @56, @"title": @"婚礼流程", @"image": @"婚礼流程", @"iconWidth": @24, @"iconHeight": @24},
        @{@"tag": @57, @"title": @"记账助手", @"image": @"记账助手my", @"iconWidth": @24, @"iconHeight": @24},
        @{@"tag": @58, @"title": @"婚姻登记处", @"image": @"婚姻登记处", @"iconWidth": @24, @"iconHeight": @24}
    ];
}

- (NSArray<NSDictionary *> *)cw_orderItems {
    return @[
        @{@"tag": @16, @"title": @"全部订单", @"image": @"商城接单 全部订单1", @"iconWidth": @22, @"iconHeight": @22},
        @{@"tag": @17, @"title": @"待付款", @"image": @"商城接单 待付款1", @"iconWidth": @22, @"iconHeight": @22},
        @{@"tag": @18, @"title": @"待发货", @"image": @"商城接单 待发货1", @"iconWidth": @22, @"iconHeight": @22},
        @{@"tag": @19, @"title": @"待收货", @"image": @"商城接单 待收货1", @"iconWidth": @22, @"iconHeight": @22},
        @{@"tag": @20, @"title": @"待评价", @"image": @"商城接单 待评价1", @"iconWidth": @22, @"iconHeight": @22}
    ];
}

- (NSArray<NSDictionary *> *)cw_bottomMenuItems {
    return @[
        @{@"tag": @102, @"title": @"充值", @"image": @"charge", @"iconWidth": @18, @"iconHeight": @18},
        @{@"tag": @62, @"title": @"商家VIP", @"image": @"商家VIP"},
        @{@"tag": @69, @"title": @"邀请婚嫁商家", @"image": @"邀请商家"},
        @{@"tag": @67, @"title": @"关于我们", @"image": @"关于我们"}
    ];
}

- (void)cw_addSpacer {
    UIView *spacer = [[UIView alloc] init];
    spacer.translatesAutoresizingMaskIntoConstraints = NO;
    spacer.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.94f alpha:1.0f];
    [spacer.heightAnchor constraintEqualToConstant:8.0f].active = YES;
    [self.contentStackView addArrangedSubview:spacer];
}

- (void)cw_addArrangedSection:(UIView *)sectionView {
    [self.contentStackView addArrangedSubview:sectionView];
}

- (UIView *)cw_makeGridSectionWithItems:(NSArray<NSDictionary *> *)items
                                columns:(NSInteger)columns
                            sectionName:(NSString *)sectionName {
    UIView *container = [[UIView alloc] init];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    container.backgroundColor = UIColor.whiteColor;

    UIStackView *sectionStack = [[UIStackView alloc] init];
    sectionStack.translatesAutoresizingMaskIntoConstraints = NO;
    sectionStack.axis = UILayoutConstraintAxisVertical;
    sectionStack.spacing = 0.0f;
    [container addSubview:sectionStack];

    [NSLayoutConstraint activateConstraints:@[
        [sectionStack.topAnchor constraintEqualToAnchor:container.topAnchor],
        [sectionStack.leadingAnchor constraintEqualToAnchor:container.leadingAnchor],
        [sectionStack.trailingAnchor constraintEqualToAnchor:container.trailingAnchor],
        [sectionStack.bottomAnchor constraintEqualToAnchor:container.bottomAnchor]
    ]];

    if (sectionName.length > 0) {
        UIView *titleRow = [self cw_makeTitleRow:sectionName];
        [sectionStack addArrangedSubview:titleRow];
    }

    NSInteger totalRows = (items.count + columns - 1) / columns;
    for (NSInteger row = 0; row < totalRows; row++) {
        NSRange range = NSMakeRange(row * columns, MIN(columns, items.count - row * columns));
        NSArray<NSDictionary *> *rowItems = [items subarrayWithRange:range];
        UIView *rowView = [self cw_makeGridRowWithItems:rowItems columns:columns];
        [sectionStack addArrangedSubview:rowView];
    }

    return container;
}

- (UIView *)cw_makeGridRowWithItems:(NSArray<NSDictionary *> *)items columns:(NSInteger)columns {
    UIView *rowView = [[UIView alloc] init];
    rowView.translatesAutoresizingMaskIntoConstraints = NO;
    rowView.backgroundColor = UIColor.whiteColor;
    [rowView.heightAnchor constraintEqualToConstant:84.0f].active = YES;

    UIStackView *rowStack = [[UIStackView alloc] init];
    rowStack.translatesAutoresizingMaskIntoConstraints = NO;
    rowStack.axis = UILayoutConstraintAxisHorizontal;
    rowStack.alignment = UIStackViewAlignmentFill;
    rowStack.distribution = UIStackViewDistributionFillEqually;
    [rowView addSubview:rowStack];

    [NSLayoutConstraint activateConstraints:@[
        [rowStack.topAnchor constraintEqualToAnchor:rowView.topAnchor],
        [rowStack.leadingAnchor constraintEqualToAnchor:rowView.leadingAnchor constant:4.0f],
        [rowStack.trailingAnchor constraintEqualToAnchor:rowView.trailingAnchor constant:-4.0f],
        [rowStack.bottomAnchor constraintEqualToAnchor:rowView.bottomAnchor]
    ]];

    for (NSInteger index = 0; index < columns; index++) {
        UIView *itemView = index < items.count ? [self cw_makeGridItem:items[index]] : [[UIView alloc] init];
        itemView.translatesAutoresizingMaskIntoConstraints = NO;
        [rowStack addArrangedSubview:itemView];
    }
    return rowView;
}

- (UIView *)cw_makeGridItem:(NSDictionary *)item {
    UIControl *control = [[UIControl alloc] init];
    control.translatesAutoresizingMaskIntoConstraints = NO;
    control.tag = [item[@"tag"] integerValue];
    [control addTarget:self action:@selector(cw_gridItemTapped:) forControlEvents:UIControlEventTouchUpInside];

    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:item[@"image"]]];
    iconView.translatesAutoresizingMaskIntoConstraints = NO;
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    [control addSubview:iconView];

    CGFloat iconWidth = item[@"iconWidth"] ? [item[@"iconWidth"] floatValue] : 24.0f;
    CGFloat iconHeight = item[@"iconHeight"] ? [item[@"iconHeight"] floatValue] : 24.0f;

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.text = item[@"title"];
    titleLabel.font = [UIFont systemFontOfSize:12.0f];
    titleLabel.textColor = [UIColor colorWithRed:0.40f green:0.40f blue:0.40f alpha:1.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 1;
    [control addSubview:titleLabel];

    [NSLayoutConstraint activateConstraints:@[
        [iconView.centerXAnchor constraintEqualToAnchor:control.centerXAnchor],
        [iconView.topAnchor constraintEqualToAnchor:control.topAnchor constant:16.0f],
        [iconView.widthAnchor constraintEqualToConstant:iconWidth],
        [iconView.heightAnchor constraintEqualToConstant:iconHeight],
        [titleLabel.topAnchor constraintEqualToAnchor:iconView.bottomAnchor constant:9.0f],
        [titleLabel.leadingAnchor constraintEqualToAnchor:control.leadingAnchor constant:6.0f],
        [titleLabel.trailingAnchor constraintEqualToAnchor:control.trailingAnchor constant:-6.0f],
        [titleLabel.bottomAnchor constraintLessThanOrEqualToAnchor:control.bottomAnchor constant:-10.0f]
    ]];

    return control;
}

- (UIView *)cw_makeIconStripSectionWithItems:(NSArray<NSDictionary *> *)items {
    UIView *container = [[UIView alloc] init];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    container.backgroundColor = UIColor.whiteColor;
    [container.heightAnchor constraintEqualToConstant:84.0f].active = YES;

    UIStackView *rowStack = [[UIStackView alloc] init];
    rowStack.translatesAutoresizingMaskIntoConstraints = NO;
    rowStack.axis = UILayoutConstraintAxisHorizontal;
    rowStack.alignment = UIStackViewAlignmentFill;
    rowStack.distribution = UIStackViewDistributionEqualSpacing;
    rowStack.spacing = 18.0f;
    [container addSubview:rowStack];

    [NSLayoutConstraint activateConstraints:@[
        [rowStack.leadingAnchor constraintEqualToAnchor:container.leadingAnchor constant:16.0f],
        [rowStack.topAnchor constraintEqualToAnchor:container.topAnchor],
        [rowStack.bottomAnchor constraintEqualToAnchor:container.bottomAnchor],
        [rowStack.trailingAnchor constraintLessThanOrEqualToAnchor:container.trailingAnchor constant:-16.0f]
    ]];

    for (NSDictionary *item in items) {
        UIView *itemView = [self cw_makeGridItem:item];
        [itemView.widthAnchor constraintEqualToConstant:70.0f].active = YES;
        [rowStack addArrangedSubview:itemView];
    }

    UIView *filler = [[UIView alloc] init];
    filler.translatesAutoresizingMaskIntoConstraints = NO;
    [rowStack addArrangedSubview:filler];
    return container;
}

- (UIView *)cw_makeOrderSectionWithTitle:(NSString *)title items:(NSArray<NSDictionary *> *)items {
    UIView *container = [[UIView alloc] init];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    container.backgroundColor = UIColor.whiteColor;

    UIStackView *sectionStack = [[UIStackView alloc] init];
    sectionStack.translatesAutoresizingMaskIntoConstraints = NO;
    sectionStack.axis = UILayoutConstraintAxisVertical;
    sectionStack.spacing = 0.0f;
    [container addSubview:sectionStack];

    [NSLayoutConstraint activateConstraints:@[
        [sectionStack.topAnchor constraintEqualToAnchor:container.topAnchor],
        [sectionStack.leadingAnchor constraintEqualToAnchor:container.leadingAnchor],
        [sectionStack.trailingAnchor constraintEqualToAnchor:container.trailingAnchor],
        [sectionStack.bottomAnchor constraintEqualToAnchor:container.bottomAnchor]
    ]];

    UIView *titleRow = [self cw_makeTitleRow:title];
    [sectionStack addArrangedSubview:titleRow];

    UIView *rowView = [[UIView alloc] init];
    rowView.translatesAutoresizingMaskIntoConstraints = NO;
    rowView.backgroundColor = UIColor.whiteColor;
    [rowView.heightAnchor constraintEqualToConstant:76.0f].active = YES;
    [sectionStack addArrangedSubview:rowView];

    UIStackView *rowStack = [[UIStackView alloc] init];
    rowStack.translatesAutoresizingMaskIntoConstraints = NO;
    rowStack.axis = UILayoutConstraintAxisHorizontal;
    rowStack.alignment = UIStackViewAlignmentFill;
    rowStack.distribution = UIStackViewDistributionFillEqually;
    [rowView addSubview:rowStack];

    [NSLayoutConstraint activateConstraints:@[
        [rowStack.topAnchor constraintEqualToAnchor:rowView.topAnchor],
        [rowStack.leadingAnchor constraintEqualToAnchor:rowView.leadingAnchor],
        [rowStack.trailingAnchor constraintEqualToAnchor:rowView.trailingAnchor],
        [rowStack.bottomAnchor constraintEqualToAnchor:rowView.bottomAnchor]
    ]];

    for (NSDictionary *item in items) {
        [rowStack addArrangedSubview:[self cw_makeGridItem:item]];
    }

    return container;
}

- (UIView *)cw_makeTitleRow:(NSString *)title {
    UIView *titleRow = [[UIView alloc] init];
    titleRow.translatesAutoresizingMaskIntoConstraints = NO;
    titleRow.backgroundColor = UIColor.whiteColor;
    [titleRow.heightAnchor constraintEqualToConstant:44.0f].active = YES;

    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = title;
    label.font = [UIFont systemFontOfSize:16.0f];
    label.textColor = [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.0f];
    [titleRow addSubview:label];

    UIView *divider = [[UIView alloc] init];
    divider.translatesAutoresizingMaskIntoConstraints = NO;
    divider.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.94f alpha:1.0f];
    [titleRow addSubview:divider];

    [NSLayoutConstraint activateConstraints:@[
        [label.leadingAnchor constraintEqualToAnchor:titleRow.leadingAnchor constant:15.0f],
        [label.centerYAnchor constraintEqualToAnchor:titleRow.centerYAnchor],
        [divider.leadingAnchor constraintEqualToAnchor:titleRow.leadingAnchor],
        [divider.trailingAnchor constraintEqualToAnchor:titleRow.trailingAnchor],
        [divider.bottomAnchor constraintEqualToAnchor:titleRow.bottomAnchor],
        [divider.heightAnchor constraintEqualToConstant:1.0f]
    ]];

    return titleRow;
}

- (UIView *)cw_makeListSectionWithItems:(NSArray<NSDictionary *> *)items {
    UIView *container = [[UIView alloc] init];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    container.backgroundColor = UIColor.whiteColor;

    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 0.0f;
    [container addSubview:stackView];

    [NSLayoutConstraint activateConstraints:@[
        [stackView.topAnchor constraintEqualToAnchor:container.topAnchor],
        [stackView.leadingAnchor constraintEqualToAnchor:container.leadingAnchor],
        [stackView.trailingAnchor constraintEqualToAnchor:container.trailingAnchor],
        [stackView.bottomAnchor constraintEqualToAnchor:container.bottomAnchor]
    ]];

    NSInteger total = items.count;
    for (NSInteger index = 0; index < total; index++) {
        [stackView addArrangedSubview:[self cw_makeListRow:items[index] showsDivider:index < total - 1]];
    }
    return container;
}

- (UIView *)cw_makeListRow:(NSDictionary *)item showsDivider:(BOOL)showsDivider {
    UIView *rowView = [[UIView alloc] init];
    rowView.translatesAutoresizingMaskIntoConstraints = NO;
    rowView.backgroundColor = UIColor.whiteColor;
    [rowView.heightAnchor constraintEqualToConstant:50.0f].active = YES;

    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:item[@"image"]]];
    iconView.translatesAutoresizingMaskIntoConstraints = NO;
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    [rowView addSubview:iconView];

    CGFloat iconWidth = item[@"iconWidth"] ? [item[@"iconWidth"] floatValue] : 20.0f;
    CGFloat iconHeight = item[@"iconHeight"] ? [item[@"iconHeight"] floatValue] : 20.0f;

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.text = item[@"title"];
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    titleLabel.textColor = [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.0f];
    [rowView addSubview:titleLabel];

    UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"点击进入"]];
    arrowView.translatesAutoresizingMaskIntoConstraints = NO;
    arrowView.contentMode = UIViewContentModeCenter;
    [rowView addSubview:arrowView];

    UIControl *control = [[UIControl alloc] init];
    control.translatesAutoresizingMaskIntoConstraints = NO;
    control.tag = [item[@"tag"] integerValue];
    [control addTarget:self action:@selector(cw_gridItemTapped:) forControlEvents:UIControlEventTouchUpInside];
    [rowView addSubview:control];

    UIView *divider = [[UIView alloc] init];
    divider.translatesAutoresizingMaskIntoConstraints = NO;
    divider.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.94f alpha:1.0f];
    divider.hidden = !showsDivider;
    [rowView addSubview:divider];

    [NSLayoutConstraint activateConstraints:@[
        [iconView.leadingAnchor constraintEqualToAnchor:rowView.leadingAnchor constant:16.0f],
        [iconView.centerYAnchor constraintEqualToAnchor:rowView.centerYAnchor],
        [iconView.widthAnchor constraintEqualToConstant:iconWidth],
        [iconView.heightAnchor constraintEqualToConstant:iconHeight],
        [titleLabel.leadingAnchor constraintEqualToAnchor:iconView.trailingAnchor constant:10.0f],
        [titleLabel.centerYAnchor constraintEqualToAnchor:iconView.centerYAnchor],
        [arrowView.trailingAnchor constraintEqualToAnchor:rowView.trailingAnchor constant:-16.0f],
        [arrowView.centerYAnchor constraintEqualToAnchor:iconView.centerYAnchor],
        [arrowView.widthAnchor constraintEqualToConstant:9.0f],
        [arrowView.heightAnchor constraintEqualToConstant:14.0f],
        [control.topAnchor constraintEqualToAnchor:rowView.topAnchor],
        [control.leadingAnchor constraintEqualToAnchor:rowView.leadingAnchor],
        [control.trailingAnchor constraintEqualToAnchor:rowView.trailingAnchor],
        [control.bottomAnchor constraintEqualToAnchor:rowView.bottomAnchor],
        [divider.leadingAnchor constraintEqualToAnchor:titleLabel.leadingAnchor],
        [divider.trailingAnchor constraintEqualToAnchor:rowView.trailingAnchor],
        [divider.bottomAnchor constraintEqualToAnchor:rowView.bottomAnchor],
        [divider.heightAnchor constraintEqualToConstant:1.0f]
    ]];

    return rowView;
}

- (void)cw_gridItemTapped:(UIControl *)sender {
    [self.gotoNextVc sendNext:@(sender.tag)];
}

@end
