//
//  shangchengTwoTableViewCell.m
//  BoYi
//
//  Created by heng on 2017/12/9.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "shangchengTwoTableViewCell.h"

@implementation shangchengTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(ShopcityModel *)model {
    _model = model;
 
    if (model.xiaoguanggaoyi.count > 0) {
        [self.btn1 sd_setImageWithURL:URL(model.xiaoguanggaoyi[0].wapimg) forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"占位图片"]];
    }
    if (model.renmenpinpai.count == 0) {
        self.image1.hidden = YES;
        self.image2.hidden = YES;
        self.image3.hidden = YES;
        self.image4.hidden = YES;
        self.iamge5.hidden = YES;
        self.image6.hidden = YES;
    }else if (model.renmenpinpai.count == 1) {
        self.image1.hidden = NO;
        self.image2.hidden = YES;
        self.image3.hidden = YES;
        self.image4.hidden = YES;
        self.iamge5.hidden = YES;
        self.image6.hidden = YES;
        [self.image1 sd_setImageWithUrl:(model.renmenpinpai[0].wapimg)];
    }else if  (model.renmenpinpai.count == 2) {
        self.image1.hidden = NO;
        self.image2.hidden = NO;
        self.image3.hidden = YES;
        self.image4.hidden = YES;
        self.iamge5.hidden = YES;
        self.image6.hidden = YES;
        [self.image1 sd_setImageWithUrl:(model.renmenpinpai[0].wapimg)];
        [self.image2 sd_setImageWithUrl:(model.renmenpinpai[1].wapimg)];
    }else if  (model.renmenpinpai.count == 3) {
        self.image1.hidden = NO;
        self.image2.hidden = NO;
        self.image3.hidden = NO;
        self.image4.hidden = YES;
        self.iamge5.hidden = YES;
        self.image6.hidden = YES;
        [self.image1 sd_setImageWithUrl:(model.renmenpinpai[0].wapimg)];
        [self.image2 sd_setImageWithUrl:(model.renmenpinpai[1].wapimg)];
        [self.image3 sd_setImageWithUrl:(model.renmenpinpai[2].wapimg)];
    }else if  (model.renmenpinpai.count == 4) {
        self.image1.hidden = NO;
        self.image2.hidden = NO;
        self.image3.hidden = NO;
        self.image4.hidden = NO;
        self.iamge5.hidden = YES;
        self.image6.hidden = YES;
        [self.image1 sd_setImageWithUrl:(model.renmenpinpai[0].wapimg)];
        [self.image2 sd_setImageWithUrl:(model.renmenpinpai[1].wapimg)];
        [self.image3 sd_setImageWithUrl:(model.renmenpinpai[2].wapimg)];
        [self.image4 sd_setImageWithUrl:(model.renmenpinpai[3].wapimg)];
    }else if  (model.renmenpinpai.count == 5) {
        self.image1.hidden = NO;
        self.image2.hidden = NO;
        self.image3.hidden = NO;
        self.image4.hidden = NO;
        self.iamge5.hidden = NO;
        self.image6.hidden = YES;
        [self.image1 sd_setImageWithUrl:(model.renmenpinpai[0].wapimg)];
        [self.image2 sd_setImageWithUrl:(model.renmenpinpai[1].wapimg)];
        [self.image3 sd_setImageWithUrl:(model.renmenpinpai[2].wapimg)];
        [self.image4 sd_setImageWithUrl:(model.renmenpinpai[3].wapimg)];
        [self.iamge5 sd_setImageWithUrl:(model.renmenpinpai[4].wapimg)];
    }else if  (model.renmenpinpai.count == 6) {
        self.image1.hidden = NO;
        self.image2.hidden = NO;
        self.image3.hidden = NO;
        self.image4.hidden = NO;
        self.iamge5.hidden = NO;
        self.image6.hidden = NO;
        [self.image1 sd_setImageWithUrl:(model.renmenpinpai[0].wapimg)];
        [self.image2 sd_setImageWithUrl:(model.renmenpinpai[1].wapimg)];
        [self.image3 sd_setImageWithUrl:(model.renmenpinpai[2].wapimg)];
        [self.image4 sd_setImageWithUrl:(model.renmenpinpai[3].wapimg)];
        [self.iamge5 sd_setImageWithUrl:(model.renmenpinpai[4].wapimg)];
        [self.image6 sd_setImageWithUrl:(model.renmenpinpai[5].wapimg)];
    }else {
        self.image1.hidden = NO;
        self.image2.hidden = NO;
        self.image3.hidden = NO;
        self.image4.hidden = NO;
        self.iamge5.hidden = NO;
        self.image6.hidden = NO;
        [self.image1 sd_setImageWithUrl:(model.renmenpinpai[0].wapimg)];
        [self.image2 sd_setImageWithUrl:(model.renmenpinpai[1].wapimg)];
        [self.image3 sd_setImageWithUrl:(model.renmenpinpai[2].wapimg)];
        [self.image4 sd_setImageWithUrl:(model.renmenpinpai[3].wapimg)];
        [self.iamge5 sd_setImageWithUrl:(model.renmenpinpai[4].wapimg)];
        [self.image6 sd_setImageWithUrl:(model.renmenpinpai[5].wapimg)];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (RACSubject *)gotoNextVc {
    if (!_gotoNextVc) {
        _gotoNextVc = [RACSubject subject];
    }
    return _gotoNextVc;
}

- (IBAction)actionall:(UIButton *)sender {
    [self.gotoNextVc sendNext:@(sender.tag)];
}

@end
