//
//  MyNewshangjiaCellTwoTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/4/25.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyNewshangjiaCellTwoTableViewCell.h"
#import "ControlCreator.h"

@interface MyNewshangjiaCellTwoTableViewCell ()

//新需求需要添加的位置
@property (weak, nonatomic) IBOutlet UIView *aDemandBar;


@end

@implementation MyNewshangjiaCellTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSArray *tags = @[@27,@201,@202];
    NSArray *titles = @[@"婚礼新闻",@"积分商城",@"活动投票"];
    NSArray *imageNames = @[@"婚礼新闻",@"积分商城",@"活动投票"];
    CGFloat width = 70.0;
    CGFloat height = CGRectGetHeight(self.aDemandBar.frame);
    CGFloat spacing = (UIScreen.mainScreen.bounds.size.width - width * 4) / 8;
    for (NSInteger index = 0; index < tags.count; index++) {
        UIView *unitView = [[UIView alloc] initWithFrame:CGRectMake(spacing + (width + spacing * 2) * index, 0, width, height)];
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
        
        [self.aDemandBar addSubview:unitView];
       UIView *topView =  [self.contentView viewWithTag:67];
       UIView *view =   [ControlCreator createView:self.contentView rect:CGRectMake(0, 0, SCREEN_WIDTH, 50) backguoundColor:UIColorWhite];
        
//        UIView *view =   [ControlCreator createButton:self.contentView rect:CGRectZero text:@"" font:nil color:UIColorClear backguoundColor:nil imageName:nil target:self action:nil];
        
        [view setTag:62];
        UIImageView *icoVIew =  [ControlCreator createImageView:view rect:CGRectMake(0, 0, 30, 30) image:[UIImage imageNamed:@"商家VIP"] backguoundColor:UIColorClear];
        QMUILabel *labelView =   [ControlCreator createQMLabel:view rect:CGRectMake(0, 0, 100, 20) text:@"充值" font:UIFontMake(16) color:UIColorBlack backguoundColor:nil align:NSTextAlignmentLeft lines:1];
            UIImageView *enterView =  [ControlCreator createImageView:view rect:CGRectMake(0, 0, 30, 30) image:[UIImage imageNamed:@"点击进入"] backguoundColor:UIColorClear];
            [ControlCreator createView:view rect:CGRectZero backguoundColor:UIColorGray];

        [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(topView.mas_bottom);
                    make.left.and.right.equalTo(self.contentView);
                    make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
        }];
        [view.subviews[0] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.left.equalTo(view).offset(15);
        }];
        [view.subviews[1] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(100, 20));
            make.left.equalTo(view.subviews[0].mas_right).offset(10);
        }];
        [view.subviews[2] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.right.equalTo(view).offset(-10);
        }]; 
        [view.subviews[3] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(view);
            make.left.equalTo(view.subviews[1]);
            make.right.equalTo(view);
        }];
        
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alletion2:)]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)alletion:(UIButton *)sender {
    [self.gotoNextVc sendNext:@(sender.tag)];
}

- (void)alletion2:(UITapGestureRecognizer *)tap {
    [self.gotoNextVc sendNext:@(tap.view.tag)];
}


- (RACSubject *)gotoNextVc {
    if (!_gotoNextVc) {
        _gotoNextVc = [RACSubject subject];
    }
    return _gotoNextVc;
}

#pragma mark - Action
- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)tap {
    NSLog(@"-------------%ld",tap.view.tag);
    [self.gotoNextVc sendNext:@(tap.view.tag)];
}

@end
