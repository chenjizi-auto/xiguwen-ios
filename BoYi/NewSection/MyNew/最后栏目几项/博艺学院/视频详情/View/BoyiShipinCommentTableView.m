//
//  BoyiShipinCommentTableView.m
//  BoYi
//
//  Created by zhoumeineng on 3/21/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "BoyiShipinCommentTableView.h"
#import "BoyiShipinCommentTableViewCell.h"
@interface BoyiShipinCommentTableView()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation BoyiShipinCommentTableView
{
    NSArray<BoyiShiPinCommentDetailModel*> *commentModelist;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        [self registerNib:[UINib nibWithNibName:@"BoyiShipinCommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return self;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  commentModelist[indexPath.row].CellCommenOnCommenListHeight+commentModelist[indexPath.row].CellCommenAndHeadHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  commentModelist.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BoyiShipinCommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BoyiShipinCommentTableViewCell" owner:self options:nil].firstObject;
    }
    [cell setCellCommentList:commentModelist[indexPath.row]];
    return cell;
}
- (void)SetDataSources:(BoyiShiPinDetailModel *)data
{
    commentModelist = data.commentModelist;
    [self reloadData];
}
@end
