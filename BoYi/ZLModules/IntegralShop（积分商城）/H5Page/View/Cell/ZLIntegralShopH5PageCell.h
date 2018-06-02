//
//  ZLIntegralShopH5PageCell.h
//  ProjectModules
//
//  Created by zhaolei on 2018/5/28.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLIntegralShopH5PageCell : UITableViewCell

///资源地址
@property (nonatomic,strong) NSString *srcPath;

///h5是否可以返回上级
- (BOOL)canGoBack;
///h5返回上级
- (void)goBack;
///Reuse
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath;

@end
