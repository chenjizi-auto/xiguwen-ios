//
//  BoyiShiPinNavigatinBar.m
//  BoYi
//
//  Created by zhoumeineng on 3/20/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "BoyiShiPinNavigatinBar.h"
@interface BoyiShiPinNavigatinBar()
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@end
@implementation BoyiShiPinNavigatinBar

- (IBAction)BackAction:(id)sender {
    self.Mblock(BackAction,sender);
}
- (IBAction)downLoadAction:(id)sender {
    self.Mblock(downLoadAction,sender);
}
- (IBAction)ShareAction:(id)sender {
    self.Mblock(ShareAction,sender);
}

- (void)setData:(BoyiShiPinDetailModel *)model
{
    self.titleLable.text = model.name;
}
@end
