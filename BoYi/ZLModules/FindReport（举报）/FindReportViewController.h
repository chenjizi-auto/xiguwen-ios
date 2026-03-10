//
//  FindReportViewController.h
//  BoYi
//
//  Created by    on 2023/2/20.
//  Copyright © 2023 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FindReportViewController : FatherViewController

@property(nonatomic,assign)NSInteger dyid;

/// 屏蔽不适内容
+ (void)showDiscomfortContentAlertWithNav:(UINavigationController *)nav dyid:(NSInteger)dyid results:(void(^)(BOOL isSuccess))results;

@end

NS_ASSUME_NONNULL_END
