//
//  YJDraggableCardContainer.h
//  YSLDraggableCardContainerDemo
//
//  Created by junzong on 16/8/23.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJDraggableCardContainer;

typedef NS_OPTIONS(NSInteger, YJDraggableDirection) {
    YJDraggableDirectionDefault     = 0,
    YJDraggableDirectionLeft        = 1 << 0,
    YJDraggableDirectionRight       = 1 << 1
};

@protocol YJDraggableCardContainerDataSource <NSObject>

- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index;
- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index;

@end

@protocol YJDraggableCardContainerDelegate <NSObject>

- (void)cardContainerView:(YJDraggableCardContainer *)cardContainerView
    didEndDraggingAtIndex:(NSInteger)index
            draggableView:(UIView *)draggableView
       draggableDirection:(YJDraggableDirection)draggableDirection;

@optional
- (void)cardContainerViewDidCompleteAll:(YJDraggableCardContainer *)container;

- (void)cardContainerView:(YJDraggableCardContainer *)cardContainerView
         didSelectAtIndex:(NSInteger)index
            draggableView:(UIView *)draggableView;

- (void)currentSelectAtIndex:(NSInteger)index;

- (void)cardContainderView:(YJDraggableCardContainer *)cardContainderView updatePositionWithDraggableView:(UIView *)draggableView draggableDirection:(YJDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio;

@end




@interface YJDraggableCardContainer : UIView


@property (nonatomic, assign) YJDraggableDirection canDraggableDirection;
@property (nonatomic, weak) id <YJDraggableCardContainerDataSource> dataSource;
@property (nonatomic, weak) id <YJDraggableCardContainerDelegate> delegate;

/**
 *  reloads everything from scratch. redisplays card.
 */
- (void)reloadCardContainer;

- (void)movePositionWithDirection:(YJDraggableDirection)direction;
- (void)movePositionWithDirection:(YJDraggableDirection)direction undoHandler:(void (^)())undoHandler;

- (UIView *)getCurrentView;


@end
