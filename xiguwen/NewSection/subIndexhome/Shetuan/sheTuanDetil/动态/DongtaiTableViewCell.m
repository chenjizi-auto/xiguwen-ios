//
//  DongtaiTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/13.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "DongtaiTableViewCell.h"
#import "DianziQingjianCollectionViewCell.h"

static const CGFloat kShetuanDynamicHorizontalMargin = 16.0;
static const CGFloat kShetuanDynamicGridInteritemSpacing = 6.0;
static const CGFloat kShetuanDynamicGridLineSpacing = 6.0;
static const CGFloat kShetuanDynamicTopBlockHeight = 50.0;
static const CGFloat kShetuanDynamicTextTopSpacing = 13.0;
static const CGFloat kShetuanDynamicGridTopSpacing = 10.0;
static const CGFloat kShetuanDynamicDividerHeight = 1.0;
static const CGFloat kShetuanDynamicActionBarHeight = 30.0;
static const CGFloat kShetuanDynamicBottomSpacerHeight = 9.0;

static inline CGFloat ShetuanDynamicGridItemWidth(CGFloat containerWidth) {
    CGFloat availableWidth = containerWidth - (kShetuanDynamicGridInteritemSpacing * 2.0);
    return floor(availableWidth / 3.0);
}

@implementation DongtaiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.hotCollection.delegate = self;
    self.hotCollection.dataSource = self;
    self.hotCollection.scrollEnabled = NO;
    self.hotCollection.backgroundColor = [UIColor clearColor];
    [self.hotCollection registerNib:[UINib nibWithNibName:@"DianziQingjianCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DianziQingjianCollectionViewCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(Dynamiclist *)model{
    _model = model;
    [self.headrimage sd_setImageWithUrl:model.head placeHolder:[UIImage imageNamed:@"头像"]];
    self.name.text = [NSString stringWithFormat:@"%@",model.nickname];
//    self.zhiwei.text = [NSString stringWithFormat:@"%@",model.type];
    self.time.text = model.create_ti;
    self.content.text = [NSString stringWithFormat:@"%@",model.content];
    [self.liulanBtn setTitle:S_Integer(model.pv) forState:UIControlStateNormal];
    [self.pinglunBtn setTitle:S_Integer(model.pls) forState:UIControlStateNormal];
    [self.dianzanBtn setTitle:S_Integer(model.zan) forState:UIControlStateNormal];
    [self.dianzanBtn setImage:[UIImage imageNamed:model.myzan == 1 ? @"点赞" : @"未点赞"] forState:UIControlStateNormal];
    [self.isGunazhuBTn setImage:[UIImage imageNamed:model.follow == 1 ? @"取消关注" :@"加关注"] forState:UIControlStateNormal];
    self.hotArray = [NSMutableArray arrayWithArray:model.pics];
    CGFloat containerWidth = CGRectGetWidth(self.hotCollection.bounds);
    if (containerWidth <= 0.0) {
        containerWidth = ScreenWidth - (kShetuanDynamicHorizontalMargin * 2.0);
    }
    self.collectionHeight.constant = [DongtaiTableViewCell gridHeightForPhotoCount:self.hotArray.count containerWidth:containerWidth];
    [self.hotCollection reloadData];
}
#pragma mark - collection

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.hotArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    DianziQingjianCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DianziQingjianCollectionViewCell" forIndexPath:indexPath];
    [cell.image sd_setImageWithUrl:self.hotArray[indexPath.row].photourl placeHolder:[UIImage imageNamed:@"占位图片"]];
    return cell;
}
//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ShetuanDynamicGridItemWidth(CGRectGetWidth(collectionView.bounds));
    return CGSizeMake(width, width);
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kShetuanDynamicGridLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kShetuanDynamicGridInteritemSpacing;
}

+ (CGFloat)gridHeightForPhotoCount:(NSInteger)count containerWidth:(CGFloat)containerWidth {
    if (count <= 0) {
        return 0.0;
    }
    NSInteger rows = (count + 2) / 3;
    CGFloat itemWidth = ShetuanDynamicGridItemWidth(containerWidth);
    return rows * itemWidth + (rows - 1) * kShetuanDynamicGridLineSpacing;
}

+ (CGFloat)cellHeightForModel:(Dynamiclist *)model tableWidth:(CGFloat)tableWidth {
    if (!model) {
        return 0.0;
    }
    CGFloat contentWidth = tableWidth - (kShetuanDynamicHorizontalMargin * 2.0);
    if (contentWidth <= 0.0) {
        contentWidth = ScreenWidth - (kShetuanDynamicHorizontalMargin * 2.0);
    }
    CGSize contentSize = [[NSString stringWithFormat:@"%@", model.content] sizeWithFont:[UIFont systemFontOfSize:15]
                                                                                   Size:CGSizeMake(contentWidth, CGFLOAT_MAX)];
    CGFloat gridHeight = [self gridHeightForPhotoCount:model.pics.count containerWidth:contentWidth];
    return kShetuanDynamicTopBlockHeight
         + kShetuanDynamicTextTopSpacing
         + contentSize.height
         + kShetuanDynamicGridTopSpacing
         + gridHeight
         + kShetuanDynamicDividerHeight
         + kShetuanDynamicActionBarHeight
         + kShetuanDynamicBottomSpacerHeight;
}
@end
