//
//  CXHunqingquanTableViewCell.m
//  BoYi
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "CXHunqingquanTableViewCell.h"

static const CGFloat kCardHorizontalInset = 12.0;
static const CGFloat kCardVerticalInset = 8.0;
static const CGFloat kCardInnerInset = 14.0;
static const CGFloat kAvatarSize = 44.0;
static const CGFloat kMetaRowHeight = 28.0;
static const CGFloat kImageSpacing = 8.0;
static const NSInteger kMaxPhotoViews = 9;

@interface CXHunqingquanTableViewCell ()

@property (nonatomic, strong) UIView *cardView;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *contentTextLabel;
@property (nonatomic, strong) NSMutableArray<UIImageView *> *photoViews;
@property (nonatomic, strong) Hunqinnewarray *currentModel;

@end

@implementation CXHunqingquanTableViewCell

+ (UIFont *)nameFont {
    return [UIFont systemFontOfSize:16.0 weight:UIFontWeightSemibold];
}

+ (UIFont *)subtitleFont {
    return [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
}

+ (UIFont *)contentFont {
    return [UIFont systemFontOfSize:15.0 weight:UIFontWeightRegular];
}

+ (UIFont *)timeFont {
    return [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
}

+ (UIFont *)metaFont {
    return [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
}

+ (UIColor *)primaryTextColor {
    return [UIColor colorWithRed:0.07 green:0.09 blue:0.13 alpha:1.0];
}

+ (UIColor *)secondaryTextColor {
    return [UIColor colorWithRed:0.60 green:0.62 blue:0.67 alpha:1.0];
}

+ (UIColor *)brandColor {
    return [UIColor colorWithRed:0.90 green:0.26 blue:0.25 alpha:1.0];
}

+ (NSInteger)gridColumnsForCount:(NSInteger)count {
    count = MIN(MAX(count, 0), kMaxPhotoViews);
    if (count <= 1) {
        return 1;
    }
    if (count == 2 || count == 4) {
        return 2;
    }
    return 3;
}

+ (CGFloat)contentHeightForText:(NSString *)text width:(CGFloat)width {
    if (text.length == 0 || width <= 0.0) {
        return 0.0;
    }
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName: [self contentFont]}
                                     context:nil];
    return ceil(rect.size.height);
}

+ (CGFloat)subtitleHeightForText:(NSString *)text width:(CGFloat)width {
    if (text.length == 0 || width <= 0.0) {
        return 0.0;
    }
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName: [self subtitleFont]}
                                     context:nil];
    return ceil(rect.size.height);
}

+ (CGFloat)photoGridHeightForCount:(NSInteger)count width:(CGFloat)width {
    count = MIN(MAX(count, 0), kMaxPhotoViews);
    if (count <= 0 || width <= 0.0) {
        return 0.0;
    }
    NSInteger columns = [self gridColumnsForCount:count];
    CGFloat itemWidth = floor((width - (columns - 1) * kImageSpacing) / columns);
    NSInteger rows = (count + columns - 1) / columns;
    return rows * itemWidth + MAX(rows - 1, 0) * kImageSpacing;
}

+ (NSInteger)safePhotoCountForModel:(Hunqinnewarray *)model {
    return [model.photourl isKindOfClass:[NSArray class]] ? MIN(model.photourl.count, kMaxPhotoViews) : 0;
}

+ (NSString *)photoURLStringFromObject:(id)object {
    if ([object isKindOfClass:[PhotourlFaxian class]]) {
        return ((PhotourlFaxian *)object).photourl;
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
        id url = object[@"photourl"] ?: object[@"url"] ?: object[@"src"];
        return [url isKindOfClass:[NSString class]] ? url : nil;
    }
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    }
    return nil;
}

+ (CGFloat)heightForModel:(Hunqinnewarray *)model constrainedToWidth:(CGFloat)width {
    CGFloat cardWidth = MAX(width - kCardHorizontalInset * 2.0, 0.0);
    CGFloat contentWidth = MAX(cardWidth - kCardInnerInset * 2.0, 0.0);
    CGFloat rightReservedWidth = 80.0;
    CGFloat textWidth = MAX(contentWidth - kAvatarSize - 12.0 - rightReservedWidth, 84.0);
    CGFloat timeHeight = 18.0;
    CGFloat subtitleHeight = [self subtitleHeightForText:model.theteam width:textWidth];
    CGFloat textBlockHeight = 20.0 + 4.0 + timeHeight + (subtitleHeight > 0.0 ? (4.0 + subtitleHeight) : 0.0);
    CGFloat topBlockHeight = MAX(kAvatarSize, textBlockHeight);

    CGFloat totalHeight = kCardVerticalInset * 2.0 + kCardInnerInset + topBlockHeight;

    CGFloat contentHeight = [self contentHeightForText:model.content width:contentWidth];
    if (contentHeight > 0.0) {
        totalHeight += 12.0 + contentHeight;
    }

    CGFloat photoHeight = [self photoGridHeightForCount:[self safePhotoCountForModel:model] width:contentWidth];
    if (photoHeight > 0.0) {
        totalHeight += 12.0 + photoHeight;
    }

    totalHeight += 12.0 + kMetaRowHeight + kCardInnerInset;
    return ceil(totalHeight);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }

    self.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.clearColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _cardView = [[UIView alloc] initWithFrame:CGRectZero];
    _cardView.backgroundColor = UIColor.whiteColor;
    _cardView.layer.cornerRadius = 18.0;
    _cardView.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.06].CGColor;
    _cardView.layer.shadowOpacity = 1.0;
    _cardView.layer.shadowOffset = CGSizeMake(0.0, 8.0);
    _cardView.layer.shadowRadius = 18.0;
    [self.contentView addSubview:_cardView];

    _header = [UIButton buttonWithType:UIButtonTypeCustom];
    _header.clipsToBounds = YES;
    _header.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.18];
    [_header addTarget:self action:@selector(selectHeader:) forControlEvents:UIControlEventTouchUpInside];
    [_cardView addSubview:_header];

    _name = [[UILabel alloc] initWithFrame:CGRectZero];
    _name.font = [CXHunqingquanTableViewCell nameFont];
    _name.textColor = [CXHunqingquanTableViewCell primaryTextColor];
    [_cardView addSubview:_name];

    _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _subtitleLabel.font = [CXHunqingquanTableViewCell subtitleFont];
    _subtitleLabel.textColor = [CXHunqingquanTableViewCell secondaryTextColor];
    [_cardView addSubview:_subtitleLabel];

    _time = [[UILabel alloc] initWithFrame:CGRectZero];
    _time.font = [CXHunqingquanTableViewCell timeFont];
    _time.textColor = [CXHunqingquanTableViewCell secondaryTextColor];
    _time.textAlignment = NSTextAlignmentLeft;
    [_cardView addSubview:_time];

    _careBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _careBtn.titleLabel.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightSemibold];
    _careBtn.layer.cornerRadius = 14.0;
    _careBtn.layer.borderWidth = 1.0;
    [_cardView addSubview:_careBtn];

    _jubaoBtn = [self buildMetaButton];
    _jubaoBtn.userInteractionEnabled = YES;
    [_jubaoBtn addTarget:self action:@selector(jubaoBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_cardView addSubview:_jubaoBtn];

    _deslabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _deslabel.font = [CXHunqingquanTableViewCell contentFont];
    _deslabel.textColor = [CXHunqingquanTableViewCell primaryTextColor];
    _deslabel.numberOfLines = 0;
    [_cardView addSubview:_deslabel];
    _contentTextLabel = _deslabel;

    _photoViews = [NSMutableArray array];
    for (NSInteger index = 0; index < kMaxPhotoViews; index++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 12.0;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.12];
        imageView.hidden = YES;
        imageView.userInteractionEnabled = YES;
        imageView.tag = index;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage:)];
        [imageView addGestureRecognizer:tap];
        [_cardView addSubview:imageView];
        [_photoViews addObject:imageView];
    }

    _sees = [self buildMetaButton];
    _talks = [self buildMetaButton];
    _goods = [self buildMetaButton];
    [_goods addTarget:self action:@selector(operationTaped:) forControlEvents:UIControlEventTouchUpInside];
    [_cardView addSubview:_sees];
    [_cardView addSubview:_talks];
    [_cardView addSubview:_goods];

    self.usesRoundedRectHeader = YES;
    return self;
}

- (UIButton *)buildMetaButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.userInteractionEnabled = NO;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.titleLabel.font = [CXHunqingquanTableViewCell metaFont];
    [button setTitleColor:[CXHunqingquanTableViewCell secondaryTextColor] forState:UIControlStateNormal];
    return button;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.currentModel = nil;
    self.onSelectedImg = nil;
    self.onSelectedHeader = nil;
    self.onJubao = nil;
    for (UIImageView *imageView in self.photoViews) {
        imageView.hidden = YES;
        imageView.image = nil;
    }
}

- (void)setUsesRoundedRectHeader:(BOOL)usesRoundedRectHeader {
    _usesRoundedRectHeader = usesRoundedRectHeader;
    [self updateHeaderCornerRadius];
}

- (void)updateHeaderCornerRadius {
    if (CGRectIsEmpty(self.header.bounds)) {
        return;
    }
    self.header.layer.cornerRadius = self.usesRoundedRectHeader ? 10.0 : CGRectGetHeight(self.header.bounds) / 2.0;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat cardX = kCardHorizontalInset;
    CGFloat cardY = kCardVerticalInset;
    CGFloat cardWidth = CGRectGetWidth(self.contentView.bounds) - kCardHorizontalInset * 2.0;
    CGFloat cardHeight = CGRectGetHeight(self.contentView.bounds) - kCardVerticalInset * 2.0;
    self.cardView.frame = CGRectMake(cardX, cardY, MAX(cardWidth, 0.0), MAX(cardHeight, 0.0));
    self.cardView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.cardView.bounds cornerRadius:self.cardView.layer.cornerRadius].CGPath;

    CGFloat contentWidth = CGRectGetWidth(self.cardView.bounds) - kCardInnerInset * 2.0;
    CGFloat currentY = kCardInnerInset;

    self.header.frame = CGRectMake(kCardInnerInset, currentY, kAvatarSize, kAvatarSize);
    [self updateHeaderCornerRadius];

    CGFloat followWidth = self.careBtn.hidden ? 0.0 : 62.0;
    CGFloat rightStart = CGRectGetWidth(self.cardView.bounds) - kCardInnerInset;
    self.careBtn.frame = CGRectMake(rightStart - followWidth,
                                    currentY - 1.0,
                                    followWidth,
                                    28.0);

    CGFloat textX = CGRectGetMaxX(self.header.frame) + 12.0;
    CGFloat textRightLimit = self.careBtn.hidden ? rightStart : CGRectGetMinX(self.careBtn.frame) - 8.0;
    CGFloat textWidth = textRightLimit - textX;
    if (textWidth < 84.0) {
        textWidth = contentWidth - kAvatarSize - 12.0;
    }

    self.name.frame = CGRectMake(textX, currentY, textWidth, 20.0);
    self.time.frame = CGRectMake(textX,
                                 CGRectGetMaxY(self.name.frame) + 4.0,
                                 textWidth,
                                 18.0);
    CGFloat subtitleHeight = [[self class] subtitleHeightForText:self.subtitleLabel.text width:textWidth];
    self.subtitleLabel.hidden = subtitleHeight <= 0.0;
    self.subtitleLabel.frame = CGRectMake(textX, CGRectGetMaxY(self.time.frame) + 4.0, textWidth, subtitleHeight);

    CGFloat headerBottom = MAX(CGRectGetMaxY(self.header.frame),
                               self.subtitleLabel.hidden ? CGRectGetMaxY(self.time.frame) : CGRectGetMaxY(self.subtitleLabel.frame));
    currentY = headerBottom + 12.0;

    CGFloat contentHeight = [[self class] contentHeightForText:self.contentTextLabel.text width:contentWidth];
    self.contentTextLabel.frame = CGRectMake(kCardInnerInset, currentY, contentWidth, contentHeight);
    if (contentHeight > 0.0) {
        currentY = CGRectGetMaxY(self.contentTextLabel.frame) + 12.0;
    }

    NSInteger photoCount = [[self class] safePhotoCountForModel:self.currentModel];
    if (photoCount > 0) {
        NSInteger columns = [[self class] gridColumnsForCount:photoCount];
        CGFloat itemWidth = floor((contentWidth - (columns - 1) * kImageSpacing) / columns);
        for (NSInteger index = 0; index < self.photoViews.count; index++) {
            UIImageView *imageView = self.photoViews[index];
            if (index >= photoCount) {
                imageView.hidden = YES;
                continue;
            }
            NSInteger row = index / columns;
            NSInteger column = index % columns;
            imageView.hidden = NO;
            imageView.frame = CGRectMake(kCardInnerInset + column * (itemWidth + kImageSpacing),
                                         currentY + row * (itemWidth + kImageSpacing),
                                         itemWidth,
                                         itemWidth);
        }
        currentY += [[self class] photoGridHeightForCount:photoCount width:contentWidth] + 12.0;
    }

    CGFloat metaItemWidth = floor(contentWidth / 4.0);
    CGFloat metaStartX = kCardInnerInset;
    self.sees.frame = CGRectMake(metaStartX,
                                 currentY,
                                 metaItemWidth,
                                 kMetaRowHeight);
    self.talks.frame = CGRectMake(CGRectGetMaxX(self.sees.frame),
                                  currentY,
                                  metaItemWidth,
                                  kMetaRowHeight);
    self.goods.frame = CGRectMake(CGRectGetMaxX(self.talks.frame),
                                  currentY,
                                  metaItemWidth,
                                  kMetaRowHeight);
    self.jubaoBtn.frame = CGRectMake(CGRectGetMaxX(self.goods.frame),
                                     currentY,
                                     CGRectGetWidth(self.cardView.bounds) - kCardInnerInset - CGRectGetMaxX(self.goods.frame),
                                     kMetaRowHeight);
}

- (void)loadwithModel:(Hunqinnewarray *)model {
    self.currentModel = model;

    UIImage *headerPlaceholder = [UIImage imageNamed:@"头像"];
    UIImage *contentPlaceholder = [UIImage imageNamed:@"占位图片"];
    [self.header sd_setImageWithURL:[NSURL URLWithString:model.head]
                           forState:UIControlStateNormal
                   placeholderImage:headerPlaceholder];

    self.name.text = [model.nickname xgw_maskedDynamicDisplayName];
    self.subtitleLabel.text = model.theteam;
    self.time.text = model.create_ti;
    self.contentTextLabel.text = model.content;

    NSInteger currentUserId = [UserDataNew sharedManager].userInfoModel.token.userid;
    BOOL isOwnDynamic = currentUserId > 0 && model.userid == currentUserId;
    self.careBtn.hidden = isOwnDynamic;
    NSString *followTitle = model.follow == 1 ? @"已关注" : @"关注";
    [self.careBtn setTitle:followTitle forState:UIControlStateNormal];
    [self.careBtn setTitleColor:model.follow == 1 ? [CXHunqingquanTableViewCell secondaryTextColor] : [CXHunqingquanTableViewCell brandColor]
                       forState:UIControlStateNormal];
    self.careBtn.layer.borderColor = (model.follow == 1 ? [UIColor colorWithRed:0.86 green:0.88 blue:0.91 alpha:1.0] : [CXHunqingquanTableViewCell brandColor]).CGColor;
    self.careBtn.backgroundColor = model.follow == 1 ? [UIColor colorWithRed:0.97 green:0.98 blue:0.99 alpha:1.0] : [UIColor colorWithRed:1.0 green:0.95 blue:0.95 alpha:1.0];

    [self applyMetaButton:self.sees
                    title:[NSString stringWithFormat:@"%ld", model.pv]
                   symbol:@"eye"
                 selected:NO];
    [self applyMetaButton:self.talks
                    title:[NSString stringWithFormat:@"%ld", model.commentnum]
                   symbol:@"bubble.left"
                 selected:NO];
    [self applyMetaButton:self.goods
                    title:[NSString stringWithFormat:@"%ld", model.zan]
                   symbol:model.shifouzan == 1 ? @"hand.thumbsup.fill" : @"hand.thumbsup"
                 selected:model.shifouzan == 1];
    self.goods.userInteractionEnabled = YES;
    [self applyMetaButton:self.jubaoBtn
                    title:@"举报"
                   symbol:nil
                 selected:NO];

    NSInteger photoCount = [[self class] safePhotoCountForModel:model];
    for (NSInteger index = 0; index < self.photoViews.count; index++) {
        UIImageView *imageView = self.photoViews[index];
        if (index >= photoCount) {
            imageView.hidden = YES;
            imageView.image = nil;
            continue;
        }
        NSString *imageURL = [[self class] photoURLStringFromObject:model.photourl[index]];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:contentPlaceholder];
        imageView.hidden = NO;
    }

    [self setNeedsLayout];
}

- (void)applyMetaButton:(UIButton *)button title:(NSString *)title symbol:(NSString *)symbol selected:(BOOL)selected {
    UIColor *color = selected ? [CXHunqingquanTableViewCell brandColor] : [CXHunqingquanTableViewCell secondaryTextColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.selected = selected;
    BOOL showsIcon = symbol.length > 0;
    [button setTitleEdgeInsets:showsIcon ? UIEdgeInsetsMake(0, 6.0, 0, 0) : UIEdgeInsetsZero];
    if (@available(iOS 13.0, *)) {
        if (showsIcon) {
            UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithPointSize:12.0 weight:(selected ? UIImageSymbolWeightSemibold : UIImageSymbolWeightRegular)];
            UIImage *image = [[UIImage systemImageNamed:symbol withConfiguration:config] imageWithTintColor:color renderingMode:UIImageRenderingModeAlwaysOriginal];
            [button setImage:image forState:UIControlStateNormal];
        } else {
            [button setImage:nil forState:UIControlStateNormal];
        }
    } else {
        if (showsIcon) {
            NSString *fallbackImageName = @"";
            if ([symbol isEqualToString:@"eye"]) {
                fallbackImageName = @"浏览";
            } else if ([symbol isEqualToString:@"bubble.left"]) {
                fallbackImageName = @"评论";
            } else {
                fallbackImageName = selected ? @"点赞" : @"未点赞";
            }
            [button setImage:[UIImage imageNamed:fallbackImageName] forState:UIControlStateNormal];
        } else {
            [button setImage:nil forState:UIControlStateNormal];
        }
    }
}

- (void)selectImage:(UITapGestureRecognizer *)sender {
    if (self.onSelectedImg) {
        self.onSelectedImg(sender.view.tag);
    }
}

- (void)selectHeader:(UIButton *)sender {
    if (self.onSelectedHeader) {
        self.onSelectedHeader();
    }
}

- (void)jubaoBtnAction {
    if (self.onJubao) {
        self.onJubao();
    }
}

- (void)operationTaped:(UIButton *)sender {
    if (self.partTpaed) {
        self.partTpaed(@"good");
    }
}

@end
