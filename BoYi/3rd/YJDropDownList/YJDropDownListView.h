//
//  YJDropDownListView.h
//  Base
//
//  Created by junzong on 16/8/31.
//  Copyright © 2016年 bodecn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJDropDownListView;

@protocol YJDropDownListViewDelegate <NSObject>

@optional

//点击了下拉列表View
- (void)clickDropDownListView:(YJDropDownListView *)dropDownListView;

//选中了下拉列表tableView
- (void)dropDownListView:(YJDropDownListView *)dropDownListView didSelectRowAtIndex:(NSInteger)index;

@end

@interface YJDropDownListView : UIView

@property (nonatomic, assign) id<YJDropDownListViewDelegate> delegate;

//tableView是否隐藏
@property (nonatomic, assign) BOOL isTableHidden;

//用这种方法初始化
- (instancetype)initWithFrame:(CGRect)frame tableViewData:(NSArray *)tableViewData;
/**
 *  下拉列表动画
 *
 */
- (void)dropDownListViewAnimation;

- (void)showInView:(UIView *)superView BaseView:(UIView *)baseView;

#pragma mark - 自定义参数

@property (weak, nonatomic) IBOutlet UIView *dropDownView;
//三角形所在的view
@property (weak, nonatomic) IBOutlet UIView *triangleView;

//文字
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//三角形
@property (weak, nonatomic) IBOutlet UIImageView *triangleImageView;

//tableView行高
@property (nonatomic, assign) CGFloat rowHeight;
//tableView背景颜色
@property (nonatomic, strong) UIColor *tableViewColor;


@end
