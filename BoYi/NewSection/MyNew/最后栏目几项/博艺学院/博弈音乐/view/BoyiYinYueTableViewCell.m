//
//  BoyiYinYueTableViewCell.m
//  BoYi
//
//  Created by heng on 2018/1/23.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import "BoyiYinYueTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
@interface BoyiYinYueTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *TitleL;
@property (weak, nonatomic) IBOutlet UIImageView *HeadImageV;
@property (weak, nonatomic) IBOutlet UIButton *PlayBtn;
@property (weak, nonatomic) IBOutlet UIButton *DownLoad;
@property (weak, nonatomic) IBOutlet UIButton *ShareBtn;
@end
@implementation BoyiYinYueTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)PlayAction:(id)sender {

}
- (IBAction)DownLoadAction:(id)sender {
}

- (IBAction)ShareBtnAction:(id)sender {
}
- (void)setCellData:(BoyiYinYueModel *)model{
    self.TitleL.text = model.name;
   
}
@end
