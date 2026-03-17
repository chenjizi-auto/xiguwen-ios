//
//  YJDropDownListTableViewCell.h
//  Base
//
//  Created by junzong on 16/8/31.
//  Copyright © 2016年 bodecn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJDropDownListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)yjDropDownListTableViewCellWithTableView:(UITableView *)tableView;

- (void)loadCellDataText:(NSString *)text isSelected:(BOOL)isSelected;

@end
