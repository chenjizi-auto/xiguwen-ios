//
//  MynewUserWHTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/2/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MynewUserWHTableViewCell.h"

@interface MynewUserWHTableViewCell ()

///上部分
@property (nonatomic,weak) UIView *topBlockView;
///中间部分
@property (nonatomic,weak) UIView *centerBlockView;
///底部分
@property (nonatomic,weak) UIView *bottomBlockView;
///信号索引
@property (nonatomic,strong) NSArray *RAC_Signal_Index;
///标题
@property (nonatomic,strong) NSArray *titles;
///图片名
@property (nonatomic,strong) NSArray *imageNames;

@end

@implementation MynewUserWHTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self topBlockView];
        [self centerBlockView];
        [self bottomBlockView];
    }
    return self;
}

#pragma mark - Lazy
- (UIView *)topBlockView {
    if (!_topBlockView) {
        UIView *topBlockView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 156.0)];
        
        //分割线
        [self showLayerWithSuperLayer:topBlockView.layer Frame:CGRectMake(0, 0, CGRectGetWidth(topBlockView.frame), 8.0)];
        
        //展示单元视图
        [self showItemsWithTags:self.RAC_Signal_Index[0] Titles:self.titles[0] ImageNames:self.imageNames[0] SuperView:topBlockView MaxY:8];
        
        //分割线
        [self showLayerWithSuperLayer:topBlockView.layer Frame:CGRectMake(0, CGRectGetHeight(topBlockView.frame) - 8.0, CGRectGetWidth(topBlockView.frame), 8.0)];
        
        [self.contentView addSubview:topBlockView];
        _topBlockView = topBlockView;
    }
    return _topBlockView;
}
- (UIView *)centerBlockView {
    if (!_centerBlockView) {
        UIView *centerBlockView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topBlockView.frame), CGRectGetWidth(self.topBlockView.frame), 198.0)];
        
        //标题
        CGFloat height = 50.0;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 0, CGRectGetWidth(centerBlockView.frame) - 30.0, height)];
        titleLabel.text = @"常备工具";
        titleLabel.font = [UIFont systemFontOfSize:16.0];
        titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [centerBlockView addSubview:titleLabel];
        
        //分割线
        [self showLayerWithSuperLayer:centerBlockView.layer Frame:CGRectMake(0, 49.0, CGRectGetWidth(centerBlockView.frame), 1.0)];
        
        //展示单元视图
        [self showItemsWithTags:self.RAC_Signal_Index[1] Titles:self.titles[1] ImageNames:self.imageNames[1] SuperView:centerBlockView MaxY:height];
        
        //分割线
        [self showLayerWithSuperLayer:centerBlockView.layer Frame:CGRectMake(0, CGRectGetHeight(centerBlockView.frame) - 8.0, CGRectGetWidth(centerBlockView.frame), 8.0)];
        
        [self.contentView addSubview:centerBlockView];
        _centerBlockView = centerBlockView;
    }
    return _centerBlockView;
}
- (UIView *)bottomBlockView {
    if (!_bottomBlockView) {
        UIView *bottomBlockView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.centerBlockView.frame), CGRectGetWidth(self.centerBlockView.frame), 300.0)];
        
        //展示单元视图
        [self showFunctionBarWithTags:self.RAC_Signal_Index[2] Titles:self.titles[2] ImageNames:self.imageNames[2] SuperView:bottomBlockView];
        
        [self.contentView addSubview:bottomBlockView];
        _bottomBlockView = bottomBlockView;
    }
    return _bottomBlockView;
}
- (NSArray *)RAC_Signal_Index {
    if (!_RAC_Signal_Index) {
        NSArray *array = [UserDataNew sharedManager].userInfoModel.token.userid == 76
        ? @[@24,@29,@28,@27]
        : @[@23,@24,@29,@28,@27];
        //依次赋值
        _RAC_Signal_Index = @[@[@1,@2,@4,@7,
                                @201,@202,],//上部分
                              
                              @[@11,@12,@13,@14,
                                @15,@16,@17,@18],//中间部分
                              
                              array];//下部分
    }
    return _RAC_Signal_Index;
}
- (NSArray *)titles {
    if (!_titles) {
        NSArray *array = [UserDataNew sharedManager].userInfoModel.token.userid == 76
        ? @[@"邀请新人客户",@"邀请婚嫁商家2",@"申请成为商家",@"关于我们"]
        : @[@"用户VIP",@"邀请新人客户",@"邀请婚嫁商家3",@"申请成为商家",@"关于我们"];
        _titles = @[@[@"实名认证",@"我的需求",@"我的邀请",@"婚礼新闻",
                      @"积分商城",@"活动投票"],//上部分
                    
                    @[@"发布需求",@"黄道吉日",@"电子请柬",@"日程安排",
                      @"婚礼宝典",@"婚礼流程",@"记账助手",@"婚礼登记处"],//中间部分
                    
                    array];//下部分
    }
    return _titles;
}
- (NSArray *)imageNames {
    if (!_imageNames) {
        NSArray *array = [UserDataNew sharedManager].userInfoModel.token.userid == 76
        ? @[@"邀请朋友",@"邀请商家",@"申请成为商家",@"关于我们"]
        : @[@"用户vip",@"邀请朋友",@"邀请商家",@"申请成为商家",@"关于我们"];
        _imageNames = @[@[@"实名认证",@"我的需求",@"我的邀请",@"婚礼新闻",
                          @"积分商城",@"活动投票"],//上部分
                        
                        @[@"发布需求",@"黄道吉日",@"电子请柬_noText",@"日程安排1",
                          @"婚礼宝典_noText",@"婚礼流程",@"记账助手_noText",@"婚姻登记处"],//中间部分
                        
                        array];//下部分
    }
    return _imageNames;
}
- (RACSubject *)gotoNextVc {
    if (!_gotoNextVc) {
        _gotoNextVc = [RACSubject subject];
    }
    return _gotoNextVc;
}

#pragma mark - Separate
- (void)showItemsWithTags:(NSArray *)tags Titles:(NSArray *)titles ImageNames:(NSArray *)imageNames SuperView:(UIView *)superView MaxY:(CGFloat)maxY {
    CGFloat width = 70.0;
    CGFloat height = 70.0;
    CGFloat spacing = (UIScreen.mainScreen.bounds.size.width - width * 4) / 8;
    for (NSInteger index = 0; index < tags.count; index++) {
        UIView *unitView = [[UIView alloc] initWithFrame:CGRectMake(spacing + (width + spacing * 2) * (index % 4), maxY +  height * (index / 4), width, height)];
        unitView.tag = [tags[index] integerValue];
        [unitView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction:)]];
        
        //子控件
        UIButton *sender = [[UIButton alloc] initWithFrame:CGRectMake(0, 10.0, CGRectGetWidth(unitView.frame), 30.0)];
        [sender setImage:[UIImage imageNamed:imageNames[index]] forState:UIControlStateNormal];
        sender.userInteractionEnabled = NO;
        [unitView addSubview:sender];
        
        //子控件
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(unitView.frame) - 30.0, CGRectGetWidth(unitView.frame), 20.0)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12.0];
        label.text = titles[index];
        label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        [unitView addSubview:label];
        
        [superView addSubview:unitView];
    }
}
- (void)showFunctionBarWithTags:(NSArray *)tags Titles:(NSArray *)titles ImageNames:(NSArray *)imageNames SuperView:(UIView *)superView {
    CGFloat width = CGRectGetWidth(superView.frame);
    CGFloat height = 50.0;
    for (NSInteger index = 0; index < tags.count; index++) {
        UIView *unitView = [[UIView alloc] initWithFrame:CGRectMake(0, height * index, width, height)];
        unitView.tag = [tags[index] integerValue];
        [unitView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction:)]];
        
        //子控件
        UIButton *sender = [[UIButton alloc] initWithFrame:CGRectMake(15.0, 0, CGRectGetWidth(superView.frame) - 55.0, 50.0)];
        sender.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [sender setImage:[UIImage imageNamed:imageNames[index]] forState:UIControlStateNormal];
        [sender setTitle:[NSString stringWithFormat:@"  %@",titles[index]] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
        sender.titleLabel.font = [UIFont systemFontOfSize:16.0];
        sender.userInteractionEnabled = NO;
        [unitView addSubview:sender];
        
        //子控件
        sender = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(sender.frame), CGRectGetMinY(sender.frame), 40.0, 50.0)];
        [sender setImage:[UIImage imageNamed:@"点击进入"] forState:UIControlStateNormal];
        sender.userInteractionEnabled = NO;
        [unitView addSubview:sender];
        
        //分割线
        [self showLayerWithSuperLayer:superView.layer Frame:CGRectMake(40.0, CGRectGetMaxY(unitView.frame) - 1.0, CGRectGetWidth(superView.frame) - 40.0, 1.0)];
        
        [superView addSubview:unitView];
    }
}
- (void)showLayerWithSuperLayer:(CALayer *)superLayer Frame:(CGRect)frame {
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0].CGColor;
    [superLayer addSublayer:layer];
}

#pragma mark - Action
- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)tap {
    [self.gotoNextVc sendNext:@(tap.view.tag)];
}

@end
