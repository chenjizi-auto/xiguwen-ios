//
//  MyNewshangjiaCellTwoTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/4/25.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyNewshangjiaCellTwoTableViewCell.h"

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
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)alletion:(UIButton *)sender {
    
    [self.gotoNextVc sendNext:@(sender.tag)];
    
    
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
