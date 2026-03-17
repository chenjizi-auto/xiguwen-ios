//
//  ZMKeyBoardFinshView.h
//  BoYi
//
//  Created by zhoumeineng on 3/23/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

typedef void(^KeyBoardFinshViewBlock)();
#import <UIKit/UIKit.h>
@interface ZMKeyBoardFinshView : UIView
@property(nonatomic,strong)KeyBoardFinshViewBlock block;
- (void)setKeyBoardTitles:(NSString*)string;
@end
