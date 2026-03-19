//
//  NTESSessionListViewController.m
//  DemoApplication
//
//  Created by chris on 2017/10/16.
//  Copyright © 2017年 chrisRay. All rights reserved.
//

#import "NTESSessionListViewController.h"
#import "CwChatManager.h"
#import "UIScrollView+EmptyDataSet.h"

@interface NTESSessionListViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation NTESSessionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"会话";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSession)];
    self.navigationItem.rightBarButtonItem = item;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.hidden = NO;
    [self.tableView reloadEmptyDataSet];
}

- (void)refresh {
    [super refresh];
    self.tableView.hidden = NO;
    [self.tableView reloadEmptyDataSet];
}


- (void)onSelectedRecent:(NIMRecentSession *)recent
             atIndexPath:(NSIndexPath *)indexPath
{
    [CwChatManager pushSession:recent.session fromViewController:self];
}

- (void)addSession
{
    UIViewController *vc = [CwChatManager contactListViewController];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"暂无消息";
    UIFont *font = [UIFont boldSystemFontOfSize:13.0];
    UIColor *textColor = RGBA(202, 202, 202, 1);

    NSMutableDictionary *attributes = [NSMutableDictionary new];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return IMAGE_NAME(@"无数据 空状态");
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -49.0;
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return self.recentSessions.count == 0;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

@end
