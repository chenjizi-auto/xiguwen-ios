//
//  DongraiDetilHeader.m
//  BoYi
//
//  Created by heng on 2018/1/5.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "DongraiDetilHeader.h"
#import "DianziQingjianCollectionViewCell.h"

static const CGFloat kDongtaiGridSideInset = 0.0;
static const CGFloat kDongtaiGridInteritemSpacing = 6.0;
static const CGFloat kDongtaiGridLineSpacing = 6.0;
static const CGFloat kDongtaiGridContainerSideMargin = 16.0;

static inline CGFloat DongtaiGridItemWidthForContainer(CGFloat containerWidth) {
    CGFloat total = containerWidth - (kDongtaiGridSideInset * 2.0) - (kDongtaiGridInteritemSpacing * 2.0);
    return floor(total / 3.0);
}

static inline UIEdgeInsets DongtaiGridInsets(void) {
    return UIEdgeInsetsMake(0, kDongtaiGridSideInset, 0, kDongtaiGridSideInset);
}

static inline CGFloat DongtaiGridHeightForCountAndWidth(NSInteger count, CGFloat containerWidth) {
    if (count <= 0) {
        return 0.0;
    }
    NSInteger rows = (count + 2) / 3;
    CGFloat item = DongtaiGridItemWidthForContainer(containerWidth);
    UIEdgeInsets insets = DongtaiGridInsets();
    return insets.top + insets.bottom + (rows * item) + ((rows - 1) * kDongtaiGridLineSpacing);
}

@implementation DongraiDetilHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.scrollEnabled = NO;
    [self.collection registerNib:[UINib nibWithNibName:@"DianziQingjianCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DianziQingjianCollectionViewCell"];
}
- (RACSubject *)gotoNextVc {
    if (!_gotoNextVc) {
        _gotoNextVc = [RACSubject subject];
    }
    return _gotoNextVc;
}
- (RACSubject *)gotoNextVc1 {
    if (!_gotoNextVc1) {
        _gotoNextVc1 = [RACSubject subject];
    }
    return _gotoNextVc1;
}
- (RACSubject *)clickImageSubject {
    if (!_clickImageSubject) {
        _clickImageSubject = [RACSubject subject];
    }
    return _clickImageSubject;
}
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {
        
    }else if (sender.tag == 1) {
        self.pinglunNumber.textColor = MAINCOLOR;
        self.dianzanNumber.textColor = RGBA(137, 137, 137, 1);
        self.view1.hidden = NO;
        self.view2.hidden = YES;
    }else {
        self.pinglunNumber.textColor = RGBA(137, 137, 137, 1);
        self.dianzanNumber.textColor = MAINCOLOR;
        self.view1.hidden = YES;
        self.view2.hidden = NO;
    }
    [self.gotoNextVc sendNext:@(sender.tag)];
}
- (IBAction)guanzhu:(UIButton *)sender {
    [self.gotoNextVc1 sendNext:nil];
}

- (IBAction)jubaoAction:(id)sender {
    [self.gotoNextVc sendNext:@(88)];
}

- (void)setModel:(DongtaiDetilModel *)model{
    _model = model;
    [self.headerimage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"占位图片"]];
    self.name.text = model.nickname;
    if (model.follow == 1) {
        [self.guanzhuBtn setImage:[UIImage imageNamed:@"取消关注"] forState:UIControlStateNormal];
    }else {
        [self.guanzhuBtn setImage:[UIImage imageNamed:@"加关注"] forState:UIControlStateNormal];
    }
    self.time.text = model.create_ti;
    self.jianjie.text = model.content;

    self.pinglunNumber.text = [NSString stringWithFormat:@"评论 %ld",model.commentnum];
    self.dianzanNumber.text = [NSString stringWithFormat:@"赞 %ld",model.zan];
    
    NSMutableArray *safeUrls = [NSMutableArray array];
    NSArray *photos = ([model.photourl isKindOfClass:[NSArray class]] ? model.photourl : @[]);
    for (id item in photos) {
        NSString *urlString = nil;
        if ([item isKindOfClass:[PhotourldongtaiD class]]) {
            urlString = ((PhotourldongtaiD *)item).photourl;
        } else if ([item isKindOfClass:[NSDictionary class]]) {
            urlString = item[@"photourl"] ?: item[@"url"];
        } else if ([item isKindOfClass:[NSString class]]) {
            urlString = (NSString *)item;
        }
        if (urlString.length > 0) {
            [safeUrls addObject:urlString];
        }
    }
    self.hotArray = safeUrls;
    
    CGFloat containerWidth = ScreenWidth - (kDongtaiGridContainerSideMargin * 2.0);
    if (containerWidth <= 0.0) {
        containerWidth = CGRectGetWidth(self.collection.bounds);
    }
    self.height.constant = DongtaiGridHeightForCountAndWidth(self.hotArray.count, containerWidth);
    [self.collection reloadData];
    
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.hotArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    id item = self.hotArray[indexPath.row];
    NSString *urlString = ([item isKindOfClass:[NSString class]] ? (NSString *)item : nil);
    //重用cell
    DianziQingjianCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DianziQingjianCollectionViewCell" forIndexPath:indexPath];
    if (urlString.length > 0) {
        [cell.image sd_setImageWithUrl:urlString placeHolder:[UIImage imageNamed:@"占位图片"]];
    } else {
        cell.image.image = [UIImage imageNamed:@"占位图片"];
    }
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= self.hotArray.count) {
        return;
    }
    [self.clickImageSubject sendNext:indexPath];
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat containerWidth = CGRectGetWidth(collectionView.bounds);
    if (containerWidth <= 0.0) {
        containerWidth = ScreenWidth - (kDongtaiGridSideInset * 2.0);
    }
    CGFloat width = DongtaiGridItemWidthForContainer(containerWidth);
    return CGSizeMake(width, width);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return DongtaiGridInsets();
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kDongtaiGridLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kDongtaiGridInteritemSpacing;
}

+ (CGFloat)gridHeightForPhotoCount:(NSInteger)count {
    CGFloat containerWidth = ScreenWidth - (kDongtaiGridContainerSideMargin * 2.0);
    return DongtaiGridHeightForCountAndWidth(count, containerWidth);
}
@end
