//
//  YJDropDownListTableViewController.h
//  Base
//
//  Created by junzong on 16/8/31.
//  Copyright © 2016年 bodecn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YJDropDownListDelegate <NSObject>

- (void)didSelectRowAtIndex:(NSInteger)index;

@end

@interface YJDropDownListTableViewController : UITableViewController

@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, strong) NSArray *contentArray;

@property (nonatomic, assign) id<YJDropDownListDelegate> delegate;

@end
