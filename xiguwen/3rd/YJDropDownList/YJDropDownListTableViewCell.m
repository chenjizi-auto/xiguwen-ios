//
//  YJDropDownListTableViewCell.m
//  Base
//
//  Created by junzong on 16/8/31.
//  Copyright © 2016年 bodecn. All rights reserved.
//

#import "YJDropDownListTableViewCell.h"

@implementation YJDropDownListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)yjDropDownListTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *yjDropDownListCell = @"yjDropDownListCell";
    YJDropDownListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:yjDropDownListCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YJDropDownListTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)loadCellDataText:(NSString *)text isSelected:(BOOL)isSelected
{
    _titleLabel.text = text;
    if (isSelected) {
        _titleLabel.textColor = RGBA(254, 217, 0, 1);
    }else {
        _titleLabel.textColor = [UIColor whiteColor];
    }
}

@end
