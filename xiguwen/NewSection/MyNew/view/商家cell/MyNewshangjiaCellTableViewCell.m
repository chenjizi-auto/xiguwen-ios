//
//  MyNewshangjiaCellTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/8.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "MyNewshangjiaCellTableViewCell.h"

@interface MyNewshangjiaCellTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *aDemandBar;

@end

@implementation MyNewshangjiaCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSArray *tags = @[@27,@202];
    NSArray *titles = @[@"婚礼新闻",@"活动投票"];
    NSArray *imageNames = @[@"婚礼新闻",@"活动投票"];
    CGFloat width = 70.0;
    CGFloat height = CGRectGetHeight(self.aDemandBar.frame);
    CGFloat leftInset = 16.0;
    CGFloat itemSpacing = 18.0;
    for (NSInteger index = 0; index < tags.count; index++) {
        CGFloat originX = leftInset + (width + itemSpacing) * index;
        UIView *unitView = [[UIView alloc] initWithFrame:CGRectMake(originX, 0, width, height)];
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

- (IBAction)action:(UIButton *)sender {
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
    [self.gotoNextVc sendNext:@(tap.view.tag)];
}

@end
