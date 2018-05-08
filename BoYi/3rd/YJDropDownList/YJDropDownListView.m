//
//  YJDropDownListView.m
//  Base
//
//  Created by junzong on 16/8/31.
//  Copyright © 2016年 bodecn. All rights reserved.
//

#import "YJDropDownListView.h"
#import "YJDropDownListTableViewController.h"

static CGFloat defaultRowheight = 30;
#define DefaultColor RGBA(6, 85, 90, 0.8)

@interface YJDropDownListView ()<YJDropDownListDelegate>

@property (nonatomic, strong) YJDropDownListTableViewController *tableView;

@property (nonatomic, strong) NSArray *tableViewData;

//根视图
@property (nonatomic, strong) UIView *baseView;;

@end

@implementation YJDropDownListView

- (instancetype)initWithFrame:(CGRect)frame tableViewData:(NSArray *)tableViewData
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"YJDropDownListView" owner:nil options:nil] firstObject];
        self.frame = frame;
        
        _tableViewData = tableViewData;
        if (_tableViewData.count != 0) {
            _titleLabel.text = _tableViewData[0];
        }
        [self loadTableView];
    }
    return self;
}

- (void)loadTableView
{
    _isTableHidden = YES;
    _tableView = [[YJDropDownListTableViewController alloc] initWithStyle:UITableViewStylePlain];
    _tableView.contentArray = _tableViewData;
    _tableView.delegate = self;
    _tableView.view.hidden = YES;
}

- (void)showInView:(UIView *)superView BaseView:(UIView *)baseView {
    //父视图
    [superView addSubview:self];
    [baseView addSubview:_tableView.view];
    [baseView bringSubviewToFront:_tableView.view];
    //判断两个视图是否一样
    _baseView = superView == baseView ? nil : baseView;
    CGRect rect = superView == baseView ? self.frame : [self convertRect:self.frame toView:_baseView];
    _tableView.view.frame = CGRectMake(rect.origin.x, rect.origin.y + rect.size.height, self.width, 0);
}


- (void)dropDownListViewAnimation
{
    if (_tableViewData.count == 0) {
        return;
    }
    CGRect rect;
    if (_baseView) {
        rect = [self convertRect:self.frame toView:_baseView];
    }
    else {
        rect = self.frame;
    }
    
    
    if (_isTableHidden) {
        
        _tableView.view.frame = CGRectMake(rect.origin.x, rect.origin.y + rect.size.height, self.width, 0);
        _tableView.view.hidden = NO;
        
        [UIView animateWithDuration:0.2f animations:^{
            //设置行高
            CGFloat tableRowHeight;
            if (_rowHeight) {
                tableRowHeight = ScreenWidth * (_rowHeight / 320.0);
            }else {
                tableRowHeight = ScreenWidth * (defaultRowheight / 320.0);
            }
            _tableView.rowHeight = tableRowHeight;
            
            //设置tableView背景颜色
            if (_tableViewColor) {
                _tableView.view.backgroundColor = _tableViewColor;
            }else{
                _tableView.view.backgroundColor = DefaultColor;
            }
            
            [_tableView.tableView reloadData];
            
            //判断tableView的高度是否超出了屏幕
            CGFloat tableHeight = (tableRowHeight * _tableViewData.count) > (ScreenHeight - (rect.origin.y + rect.size.height)) ? (ScreenHeight - (rect.origin.y + rect.size.height)) : (tableRowHeight * _tableViewData.count);

            _tableView.view.frame = CGRectMake(rect.origin.x, rect.origin.y + rect.size.height, self.width, tableHeight);
            
            _triangleImageView.transform = CGAffineTransformMakeRotation(-M_PI);
            
        }];
        
    }else{
        
        [UIView animateWithDuration:0.2f animations:^{
            
            _tableView.view.frame = CGRectMake(rect.origin.x, rect.origin.y + rect.size.height, self.frame.size.width, 0);
            
            _triangleImageView.transform = CGAffineTransformMakeRotation(M_PI / 180);
            
        } completion:^(BOOL finished) {
            _tableView.view.hidden = YES;
        }];
    }
    
    _isTableHidden = !_isTableHidden;
      
}

- (void)didSelectRowAtIndex:(NSInteger)index
{
    _titleLabel.text = _tableViewData[index];
    [self dropDownListViewAnimation];
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropDownListView:didSelectRowAtIndex:)]) {
        [self.delegate dropDownListView:self didSelectRowAtIndex:index];
    }
}


#pragma mark - 点击界面弹出或者收回下来列表
- (IBAction)popOrBackDropDownList:(UITapGestureRecognizer *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickDropDownListView:)]) {
        [self.delegate clickDropDownListView:self];
    }
    [self dropDownListViewAnimation];
}


@end
