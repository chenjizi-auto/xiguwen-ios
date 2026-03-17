//
//  BoyiShiPingCommentAndSupportSected.m
//  BoYi
//
//  Created by zhoumeineng on 3/21/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "BoyiShiPingCommentAndSupportSected.h"
@interface BoyiShiPingCommentAndSupportSected()

@property (weak, nonatomic) IBOutlet UIButton *CommentBtn;
@property (weak, nonatomic) IBOutlet UIButton *SUpportBtn;

@end
@implementation BoyiShiPingCommentAndSupportSected

- (IBAction)CommentAction:(id)sender {
}
- (IBAction)SupportAction:(id)sender {
}
- (void)setData:(BoyiShiPinDetailModel *)model{
    [self.CommentBtn setTitle:[NSString stringWithFormat:@"评论 %ld",model.commentnum]forState:UIControlStateNormal];
    [self.SUpportBtn setTitle:[NSString stringWithFormat:@"点赞 %ld",model.dianzan]forState:UIControlStateNormal];
}
@end
