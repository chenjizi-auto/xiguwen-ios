//
//  ZMKeyBoardFinshView.m
//  BoYi
//
//  Created by zhoumeineng on 3/23/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "ZMKeyBoardFinshView.h"
@interface ZMKeyBoardFinshView()
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end
@implementation ZMKeyBoardFinshView

- (IBAction)FinshAction:(id)sender {
    self.block();
}
- (void)setKeyBoardTitles:(NSString*)string{
    self.titleL.text = string;
}
@end
