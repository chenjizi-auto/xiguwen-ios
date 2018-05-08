//
//  YJPictureViewController.m
//  YSLDraggableCardContainerDemo
//
//  Created by junzong on 16/8/19.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

#import "YJPictureViewController.h"
#import "YJDraggableCardContainer.h"
#import "CardView.h"


@interface YJPictureViewController () <YJDraggableCardContainerDataSource,YJDraggableCardContainerDelegate>

@property (weak, nonatomic) IBOutlet YJDraggableCardContainer *containerView;
//页数
@property (weak, nonatomic) IBOutlet UILabel *pageNumber;
//标题内容
@property (weak, nonatomic) IBOutlet UILabel *titleContent;
//图片数组
@property (nonatomic, strong) NSMutableArray *datas;
//是否是网络图片
@property (nonatomic, assign) BOOL isNetwork;

@end

@implementation YJPictureViewController

- (instancetype)initWithImageData:(NSMutableArray *)data titleContent:(NSString *)titleContent isNetwork:(BOOL)isNetwork
{
    self = [super init];
    if (self) {
        _datas = [NSMutableArray arrayWithArray:data];
        _titleContent.text = titleContent;
        _isNetwork = isNetwork;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addCustomNavBarTitle:nil backgroundColor:NavBarCOLOR leftBar:nil rigthBar:nil whetherAddBackBar:YES isWhite:NO];
    [self addCustomNavBarTitle:nil leftBar:nil rigthBar:nil whetherAddBackBar:YES];
    self.navView.hidden = YES;
    self.navView.alpha = 0;
    _containerView.backgroundColor = [UIColor clearColor];
    _containerView.dataSource = self;
    _containerView.delegate = self;
    
    [self loadData];
    [_containerView reloadCardContainer];
}

- (void)loadData
{
    _pageNumber.text = [NSString stringWithFormat:@"1/%ld",_datas.count];
}

#pragma mark -- YSLDraggableCardContainer DataSource
- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index
{
//    CardView *view = [[CardView alloc]initWithFrame:CGRectMake(10, 20, ScreenWidth - 40, ScreenHeight - 220)];
    CardView *view = [[CardView alloc]initWithFrame:CGRectMake(10, 40, ScreenWidth - 40, ScreenWidth - 40)];
    view.backgroundColor = [UIColor whiteColor];
    if (_isNetwork) {
        [view.imageView sd_setImageWithActivityAndURL:[NSString stringWithFormat:@"%@",_datas[index]] PlaceHolder:BANNERPLACEHOLDERIMAGE];
    }else{
        view.imageView.image = [UIImage imageNamed:_datas[index]];
    }

    return view;
}

- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index
{
    return _datas.count;
}

#pragma mark -- YSLDraggableCardContainer Delegate
- (void)cardContainerView:(YJDraggableCardContainer *)cardContainerView didEndDraggingAtIndex:(NSInteger)index draggableView:(UIView *)draggableView draggableDirection:(YJDraggableDirection)draggableDirection
{
    if (draggableDirection == YJDraggableDirectionLeft) {
        [cardContainerView movePositionWithDirection:draggableDirection];
    }
    
    if (draggableDirection == YJDraggableDirectionRight) {
        [cardContainerView movePositionWithDirection:draggableDirection];
    }
    
}


- (void)cardContainerView:(YJDraggableCardContainer *)cardContainerView didSelectAtIndex:(NSInteger)index draggableView:(UIView *)draggableView
{
//    NSLog(@"++ index : %ld",(long)index);
    [UIView animateWithDuration:0.2 animations:^{
        if (self.navView.hidden) {
            self.navView.hidden = NO;
            self.navView.alpha = 1;
        }else{
            self.navView.hidden = YES;
            self.navView.alpha = 0;
        }
        
    }];
}

- (void)currentSelectAtIndex:(NSInteger)index
{
    if (index + 1 > _datas.count) {
        _pageNumber.text = [NSString stringWithFormat:@"1/%ld",_datas.count];
    }else{
        _pageNumber.text = [NSString stringWithFormat:@"%ld/%ld",index + 1,_datas.count];
    }
    
}

- (void)backOnViewController
{
    [_containerView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
