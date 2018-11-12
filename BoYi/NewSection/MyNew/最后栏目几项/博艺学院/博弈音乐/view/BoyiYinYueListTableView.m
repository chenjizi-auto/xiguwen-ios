//
//  BoyiYinYueListTableView.m
//  BoYi
//
//  Created by zhoumeineng on 3/22/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "BoyiYinYueListTableView.h"
#import "BoyiYinYueTableViewCell.h"
#import "BoyiShipinHeaderView.h"
@interface BoyiYinYueListTableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation BoyiYinYueListTableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BoyiYinYueTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"BoyiYinYueTableViewCell" owner:self options:nil].firstObject;
    }
    [cell setCellData:_dataSources[indexPath.section][indexPath.row]];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSources[section].count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BoyiShipinHeaderView * head = [[NSBundle mainBundle]loadNibNamed:@"BoyiShipinHeaderView" owner:self options:nil].firstObject;
    head.backgroundColor = RGBA(236, 236, 236, 1);
    [head headText:[NSIndexPath indexPathForRow:1 inSection:section]];
    
    head.Mblock = ^(NSString * title) {
        self.Mblock(title);
    };
    return head;
}
-(void)setTablData:(NSArray<NSArray<BoyiYinYueModel*>*>*)dataSources
{
    _dataSources = dataSources;
    [self reloadData];
}
@end
