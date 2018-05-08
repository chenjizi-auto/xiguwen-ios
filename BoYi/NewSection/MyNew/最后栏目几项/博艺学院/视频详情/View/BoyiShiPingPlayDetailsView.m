//
//  BoyiShiPingPlayDetailsView.m
//  BoYi
//
//  Created by zhoumeineng on 3/21/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "BoyiShiPingPlayDetailsView.h"
@interface BoyiShiPingPlayDetailsView()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *TitleL;
@property (weak, nonatomic) IBOutlet UILabel *ContentL;

@end
@implementation BoyiShiPingPlayDetailsView

- (void)SetData:(BoyiShiPinDetailModel *)model{
    self.ContentL.text = model.describe;
    self.TitleL.text = model.name;
}
@end
