//
//  YJDropDownListTableViewController.m
//  Base
//
//  Created by junzong on 16/8/31.
//  Copyright © 2016年 bodecn. All rights reserved.
//

#import "YJDropDownListTableViewController.h"
#import "YJDropDownListTableViewCell.h"

@interface YJDropDownListTableViewController ()

//当前选中的下标
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation YJDropDownListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _currentIndex = -1;
    //不要分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJDropDownListTableViewCell *cell = [YJDropDownListTableViewCell yjDropDownListTableViewCellWithTableView:tableView];
    
    BOOL isSelected = NO;
    //选择的当前行改变颜色
    if (_currentIndex == indexPath.row) {
        isSelected = YES;
    }
    //未选择默认第一行改变颜色
    if (_currentIndex == -1 && indexPath.row == 0) {
        isSelected = YES;
    }
    
    [cell loadCellDataText:_contentArray[indexPath.row] isSelected:isSelected];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectRowAtIndex:)]) {
        _currentIndex = indexPath.row;
        [self.delegate didSelectRowAtIndex:indexPath.row];
    }
    
}

@end
