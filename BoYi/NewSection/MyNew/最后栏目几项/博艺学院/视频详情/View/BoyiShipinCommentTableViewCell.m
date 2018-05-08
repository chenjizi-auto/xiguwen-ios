//
//  BoyiShipinCommentTableViewCell.m
//  BoYi
//
//  Created by zhoumeineng on 3/21/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "BoyiShipinCommentTableViewCell.h"
#import "BoyiShipinXiaJiCommentTableViewCell.h"
@interface BoyiShipinCommentTableViewCell()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *NikeNameL;
@property (weak, nonatomic) IBOutlet UILabel *TimeL;
@property (weak, nonatomic) IBOutlet UILabel *CommentL;
@property (weak, nonatomic) IBOutlet UITableView *ComentsTable;

@end

@implementation BoyiShipinCommentTableViewCell
{
    NSArray<BoyiShiPinXiaJiCommentDetailModel*> * XiaJiCommentList;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.ComentsTable.delegate = self;
    self.ComentsTable.dataSource = self;
    self.ComentsTable.scrollEnabled = NO;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.ComentsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.ComentsTable registerNib:[UINib nibWithNibName:@"BoyiShipinXiaJiCommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    // Initialization code
}
- (void)setCellCommentList:(BoyiShiPinCommentDetailModel *)CommentDetailModel
{
    XiaJiCommentList = CommentDetailModel.XiaJiCommentModelList;
    
    [self.headImage sd_setImageWithUrl:CommentDetailModel.head placeHolder:nil];
    self.headImage.layer.cornerRadius = self.headImage.bounds.size.height/2.0;
    self.headImage.layer.masksToBounds = YES;
    self.NikeNameL.text = CommentDetailModel.nickname;
    self.TimeL.text = CommentDetailModel.create_ti;
    self.CommentL.text = CommentDetailModel.comm;
    [self.ComentsTable reloadData];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BoyiShipinXiaJiCommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BoyiShipinXiaJiCommentTableViewCell" owner:self options:nil].firstObject;
    }
 
    [cell setCommentDetail:XiaJiCommentList[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return XiaJiCommentList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return XiaJiCommentList[indexPath.row].CellCommenHeight;
}
@end
