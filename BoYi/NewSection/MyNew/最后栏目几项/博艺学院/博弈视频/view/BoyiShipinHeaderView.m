//
//  BoyiShipinHeaderView.m
//  BoYi
//
//  Created by heng on 2018/1/23.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "BoyiShipinHeaderView.h"

@interface BoyiShipinHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *head;

@end
@implementation BoyiShipinHeaderView
- (void)headText:(NSIndexPath *)indext{
    self.head.text = indext.section==0?@"推荐":indext.section==1?@"最新":@"最热";
}
- (IBAction)MoreAction:(id)sender {
    self.Mblock(self.head.text);
}

@end
