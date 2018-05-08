//
//  ZMMonitorKeyBoder.h
//  BoYi
//
//  Created by zhoumeineng on 3/23/18.
//  Copyright © 2018 hengwu. All rights reserved.
//
typedef NS_ENUM(NSInteger) {
    keyboardWillShow =1,
    keyboardShow  =2,
    keyboardWillHide=3,
    keyboardHide=4
}KeyBoardState;

typedef NS_ENUM(NSInteger) {
   TextField =1,
   TextView =2,
   SearchBar=3
}EDITTEXTTYPE;
#import <Foundation/Foundation.h>
typedef void(^KeyBoardStateBlock)(KeyBoardState type);
@interface ZMMonitorKeyBoder : NSObject
+(ZMMonitorKeyBoder*)manager;
@property(nonatomic,strong)KeyBoardStateBlock Mblock;

/**
 * 移除监听
 */
-(void)removeallNotify;


@end
