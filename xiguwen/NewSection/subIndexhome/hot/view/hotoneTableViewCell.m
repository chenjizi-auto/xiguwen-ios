//
//  hotoneTableViewCell.m
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/20.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "hotoneTableViewCell.h"
#import "SDCycleScrollView.h"
@implementation hotoneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 170)];
    header.backgroundColor = [UIColor whiteColor];
    self.adView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 170) delegate:self placeholderImage:[UIImage imageNamed:@"占位图片"]];
    self.adView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.adView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    self.adView.pageDotColor = RGBA(220, 146, 196, 1);
    self.adView.autoScrollTimeInterval = 5.0;
    self.adView.showPageControl = YES;
    [self.vieww addSubview:self.adView];
}

- (RACSubject *)gotoNextVc {
    
    if (!_gotoNextVc) _gotoNextVc = [RACSubject subject];
    
    return _gotoNextVc;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setPhotos:(NSMutableArray *)photos{
    _photos = photos;
    self.adView.imageURLStringsGroup = photos;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    [self.gotoNextVc sendNext:@(index)];
}
@end
