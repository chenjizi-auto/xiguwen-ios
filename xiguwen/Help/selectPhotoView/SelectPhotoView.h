//
//  SelectPhotoView.h
//  ThreeAsk_New
//
//  Created by Yifei Li on 2017/7/3.
//  Copyright © 2017年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectPhotoView : UIView

/**
 图片数量
 */
@property (strong,nonatomic) NSMutableArray *imageArray;

/**
 调整视图的回调
 */
@property (copy,nonatomic) void (^adjustFrameBlock)(CGFloat height) ;

- (void)showInVc:(UIViewController *)vc;

@end
