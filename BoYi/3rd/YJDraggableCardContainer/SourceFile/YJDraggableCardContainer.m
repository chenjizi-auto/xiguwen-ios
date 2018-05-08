//
//  YJDraggableCardContainer.m
//  YSLDraggableCardContainerDemo
//
//  Created by junzong on 16/8/23.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

#import "YJDraggableCardContainer.h"

static const CGFloat kPreloadViewCount = 3.0f;
static const CGFloat kCard_Margin = 10.0f;
static const CGFloat kDragCompleteCoefficient_width_default = 0.8f;

typedef NS_ENUM(NSInteger,ScrollDirection){
    ScrollDirectionCenter,   //滚动位置居中，无滚动
    ScrollDirectionLeft,     //向左滚动
    ScrollDirectionRight     //向右滚动
};


@interface YJDraggableCardContainer ()

@property (nonatomic, assign) CGRect defaultFrame;
@property (nonatomic, assign) CGFloat cardCenterX;
@property (nonatomic, assign) CGFloat cardCenterY;
@property (nonatomic, assign) NSInteger loadedIndex;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray *currentViews;
@property (nonatomic, assign) BOOL isInitialAnimation;
@property (nonatomic, strong) UIView *previousView;
@property (nonatomic, strong) NSMutableArray *previousViews;
@property (nonatomic, assign) float ratio_w;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

//当前滚动方向
@property (nonatomic, assign) ScrollDirection currScrollDirection;
//上一次的scrollView的偏移量
@property (nonatomic, assign) CGFloat onScrollOffSet;
//向一个方向滑动再向另一个方向滑动时是否松开过手指
@property (nonatomic, assign) BOOL isLoosen;

@end

@implementation YJDraggableCardContainer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUp];
    }
    return self;
}


- (void)setUp
{
    _canDraggableDirection = YJDraggableDirectionLeft | YJDraggableDirectionRight;
    _loadedIndex = 0.0f;
    _currentIndex = 0.0f;
    _ratio_w = 0.0f;
    _currScrollDirection = ScrollDirectionCenter;
    _onScrollOffSet = 0.0f;
    _isLoosen = YES;
    _currentViews = [NSMutableArray array];
    _previousViews = [NSMutableArray array];
}

#pragma mark -- Public

-(void)reloadCardContainer
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [_currentViews removeAllObjects];
    [_previousViews removeAllObjects];
    [self setUp];
    [self loadNextView];
    _isInitialAnimation = NO;
    [self viewInitialAnimation];
}

- (void)movePositionWithDirection:(YJDraggableDirection)direction undoHandler:(void (^)())undoHandler
{
    [self cardViewDirectionAnimation:direction undoHandler:undoHandler];
}

- (void)movePositionWithDirection:(YJDraggableDirection)direction
{
    [self cardViewDirectionAnimation:direction undoHandler:nil];
}

- (UIView *)getCurrentView
{
    return [_currentViews firstObject];
}

- (UIView *)getPreviousView
{
    return [_previousViews lastObject];
}


#pragma mark -- Private
- (void)loadNextView
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(cardContainerViewNumberOfViewInIndex:)]) {
        NSInteger index = [self.dataSource cardContainerViewNumberOfViewInIndex:_loadedIndex];
        
        // all cardViews Dragging end
        if (index != 0 && index == _currentIndex) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(cardContainerViewDidCompleteAll:)]) {
                [self.delegate cardContainerViewDidCompleteAll:self];
            }
            return;
        }
        
        // load next cardView
        if (_loadedIndex < index) {
            
            NSInteger preloadViewCont = index <= kPreloadViewCount ? index : kPreloadViewCount;
            
            for (NSInteger i = _currentViews.count; i < preloadViewCont; i++) {
                if (self.dataSource && [self.dataSource respondsToSelector:@selector(cardContainerViewNextViewWithIndex:)]) {
                    UIView *view = [self.dataSource cardContainerViewNextViewWithIndex:_loadedIndex];
                    if (view) {
                        _defaultFrame = view.frame;
                        _cardCenterX = view.center.x;
                        _cardCenterY = view.center.y;
                        
                        [self addSubview:view];
                        [self sendSubviewToBack:view];
                        [_currentViews addObject:view];
                        
                        if (i == 1 && _currentIndex != 0) {
                            view.frame = CGRectMake(_defaultFrame.origin.x + kCard_Margin, _defaultFrame.origin.y - kCard_Margin, _defaultFrame.size.width, _defaultFrame.size.height);
                        }
                        
                        if (i == 2 && _currentIndex != 0) {
                            view.frame = CGRectMake(_defaultFrame.origin.x + (kCard_Margin * 2), _defaultFrame.origin.y - (kCard_Margin * 2), _defaultFrame.size.width, _defaultFrame.size.height);
                        }
                        _loadedIndex++;
                    }
                    
                }
            }
        }
        
        UIView *view = [self getCurrentView];
        if (view) {
            [self addGestureRecognizerView:view];
        }
    }
}

- (void)addGestureRecognizerView:(UIView *)view
{
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [view addGestureRecognizer:_panGesture];
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cardViewTap:)];
    [view addGestureRecognizer:_tapGesture];
}

- (void)removeGestureRecognizerView:(UIView *)view
{
    [view removeGestureRecognizer:_tapGesture];
    [view removeGestureRecognizer:_panGesture];
}

- (void)cardViewDirectionAnimation:(YJDraggableDirection)direction undoHandler:(void (^)())undoHandler
{
    if (!_isInitialAnimation) { return; }
    
    UIView *view = [self getCurrentView];
    if (!view) { return; }
    
    __weak YJDraggableCardContainer *weakself = self;
    if (direction == YJDraggableDirectionDefault) {
        view.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:0.55
                              delay:0.0
             usingSpringWithDamping:0.6
              initialSpringVelocity:0.0
                            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             view.frame = _defaultFrame;
                             _previousView.frame = CGRectMake(-view.frame.size.width, _defaultFrame.origin.y, view.frame.size.width, view.frame.size.height);
                             [weakself cardViewDefaultScale];
                         } completion:^(BOOL finished) {
                         }];
        
        return;
    }
    
    
    //左滑
    if (direction == YJDraggableDirectionLeft) {
        
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(cardContainerViewNumberOfViewInIndex:)]) {
            
            NSInteger index = [self.dataSource cardContainerViewNumberOfViewInIndex:_loadedIndex];
            if (index != 0 && _currentIndex + 1 == index) {
                [weakself cardViewDefaultScale];
                return;
            }
            
        }
        
        if (!undoHandler) {
            [weakself removeGestureRecognizerView:view];
            [_previousViews addObject:view];
            [_currentViews removeObject:view];
            _currentIndex++;
            [self loadNextView];
        }
        [UIView animateWithDuration:0.15
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             view.frame = CGRectMake(-view.frame.size.width, _defaultFrame.origin.y, view.frame.size.width, view.frame.size.height);
                             
                             if (!undoHandler) {
                                 [weakself cardViewDefaultScale];
                             }
                         } completion:^(BOOL finished) {
                             if (!undoHandler) {
                                 _previousView = nil;
                                 _previousView = view;
                             } else  {
                                 if (undoHandler) { undoHandler(); }
                             }
                         }];
        
    }
    
    
    //右滑
    if (direction == YJDraggableDirectionRight) {
        
        UIView *previousView = [self getPreviousView];
        if (!previousView) {
            return;
        }
        if (!undoHandler) {
            [weakself removeGestureRecognizerView:view];
            [_currentViews insertObject:previousView atIndex:0];
            [_previousViews removeLastObject];
            if (_currentViews.count > 3) {
                [_currentViews removeLastObject];
                _loadedIndex--;
            }
            _currentIndex--;
            [weakself addGestureRecognizerView:previousView];
        }
        
        [UIView animateWithDuration:0.15
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             
                             if (!undoHandler) {
                                 [weakself cardViewDefaultScale];
                             }
                         } completion:^(BOOL finished) {
                             if (!undoHandler) {
                                 if (_previousViews.count != 0) {
                                     _previousView = [self getPreviousView];
                                     _previousView.frame = CGRectMake(-view.frame.size.width, _defaultFrame.origin.y, view.frame.size.width, view.frame.size.height);
                                 }
                                 
                             } else  {
                                 if (undoHandler) { undoHandler(); }
                             }
                         }];
    }
}


- (void)cardViewUpDateScale:(BOOL)isDirection
{
    //左滑动画
    if (isDirection == NO) {
        UIView *view = [self getCurrentView];
        
        float ratio_w = fabs((view.center.x - _cardCenterX) / _cardCenterX);
        
        if (_currentViews.count == 2) {
            if (ratio_w <= 1) {
                UIView *view = _currentViews[1];
                view.transform = CGAffineTransformIdentity;
                view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -(ratio_w * kCard_Margin),  (ratio_w * kCard_Margin));
            }
        }
        if (_currentViews.count == 3) {
            if (ratio_w <= 1) {
                {
                    UIView *view = _currentViews[1];
                    view.transform = CGAffineTransformIdentity;
                    view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -(ratio_w * kCard_Margin),  (ratio_w * kCard_Margin));
                }
                {
                    UIView *view = _currentViews[2];
                    view.transform = CGAffineTransformIdentity;
                    view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -(ratio_w * kCard_Margin),  (ratio_w * kCard_Margin));
                }
            }
        }
        //右滑动画
    }else{
        if (_previousViews.count != 0) {
            
            float ratio_w = fabs((_previousView.center.x + (_cardCenterX - _defaultFrame.origin.x)) / (_cardCenterX - _defaultFrame.origin.x));
            
            if (_currentViews.count == 1) {
                if (ratio_w <= 1) {
                    UIView *view = _currentViews[0];
                    view.transform = CGAffineTransformIdentity;
                    view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, ratio_w * kCard_Margin,  -(ratio_w * kCard_Margin));
                }
            }
            
            if (_currentViews.count == 2) {
                if (ratio_w <= 1) {
                    {
                        UIView *view = _currentViews[0];
                        view.transform = CGAffineTransformIdentity;
                        view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, ratio_w * kCard_Margin,  -(ratio_w * kCard_Margin));
                    }
                    {
                        UIView *view = _currentViews[1];
                        view.transform = CGAffineTransformIdentity;
                        view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, ratio_w * kCard_Margin,  -(ratio_w * kCard_Margin));
                    }
                }
            }
            if (_currentViews.count == 3) {
                if (ratio_w <= 1) {
                    {
                        UIView *view = _currentViews[0];
                        view.transform = CGAffineTransformIdentity;
                        view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, ratio_w * kCard_Margin,  -(ratio_w * kCard_Margin));
                    }
                    {
                        UIView *view = _currentViews[1];
                        view.transform = CGAffineTransformIdentity;
                        view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, ratio_w * kCard_Margin,  -(ratio_w * kCard_Margin));
                    }
                    {
                        UIView *view = _currentViews[2];
                        view.hidden = YES;
                    }
                }
            }
        }
    }
    
}


- (void)cardViewDefaultScale
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cardContainderView:updatePositionWithDraggableView:draggableDirection:widthRatio:)]) {
        
        [self.delegate cardContainderView:self updatePositionWithDraggableView:[self getCurrentView]
                       draggableDirection:YJDraggableDirectionDefault
                               widthRatio:0];
    }
    
    for (int i = 0; i < _currentViews.count; i++) {
        UIView *view = _currentViews[i];
        if (i == 0) {
            view.transform = CGAffineTransformIdentity;
            view.frame = _defaultFrame;
            
        }
        if (i == 1) {
            view.transform = CGAffineTransformIdentity;
            view.frame = CGRectMake(_defaultFrame.origin.x + kCard_Margin, _defaultFrame.origin.y - kCard_Margin, _defaultFrame.size.width, _defaultFrame.size.height);
            
        }
        if (i == 2) {
            view.transform = CGAffineTransformIdentity;
            view.frame = CGRectMake(_defaultFrame.origin.x + (kCard_Margin * 2), _defaultFrame.origin.y - (kCard_Margin * 2), _defaultFrame.size.width, _defaultFrame.size.height);
            if (view.hidden == YES) {
                view.hidden = NO;
            }
        }
    }
}

- (void)viewInitialAnimation
{
    for (UIView *view in _currentViews) {
        view.alpha = 0.0;
    }
    
    UIView *view = [self getCurrentView];
    if (!view) { return; }
    __weak YJDraggableCardContainer *weakself = self;
    view.alpha = 1.0;
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.5f,0.5f);
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.05f,1.05f);
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.1
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.95f,0.95f);
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.1
                                                                    delay:0.0
                                                                  options:UIViewAnimationOptionCurveEaseOut
                                                               animations:^{
                                                                   view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0f,1.0f);
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   for (UIView *view in _currentViews) {
                                                                       view.alpha = 1.0;
                                                                   }
                                                                   
                                                                   [UIView animateWithDuration:0.25f
                                                                                         delay:0.01f
                                                                                       options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                                                                                    animations:^{
                                                                                        [weakself cardViewDefaultScale];
                                                                                    } completion:^(BOOL finished) {
                                                                                        weakself.isInitialAnimation = YES;
                                                                                    }];
                                                               }
                                               ];
                                          }
                          ];
                     }
     ];
}

#pragma mark -- Gesture Selector

- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture
{
    if (!_isInitialAnimation) { return; }
    
    CGPoint point = [gesture translationInView:self];
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        
        if (_onScrollOffSet < point.x) {
            if (_isLoosen == YES) {
                _currScrollDirection = ScrollDirectionRight;
                _isLoosen = NO;
            }
        }else{
            if (_isLoosen == YES) {
                _currScrollDirection = ScrollDirectionLeft;
                _isLoosen = NO;
            }
        }
        
        if (point.x <= 0 && _currScrollDirection == ScrollDirectionLeft) {
            CGPoint movedPoint = CGPointMake(gesture.view.center.x + point.x, gesture.view.center.y);
            gesture.view.center = movedPoint;
            _ratio_w = (gesture.view.center.x - _cardCenterX) / _cardCenterX;
            [self cardViewUpDateScale:NO];
            
        }else if (point.x > 0 && _currScrollDirection == ScrollDirectionRight){
            
            if (_currentIndex == 0) {
                return;
            }
            CGPoint movedPoint = CGPointMake(_previousView.center.x + point.x, _previousView.center.y);
            _previousView.center = movedPoint;
            _ratio_w = (_previousView.center.x + (_cardCenterX - _defaultFrame.origin.x)) / (_cardCenterX - _defaultFrame.origin.x);
            [self cardViewUpDateScale:YES];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(cardContainderView:updatePositionWithDraggableView:draggableDirection:widthRatio:)]) {
            if ([self getCurrentView]) {
                
                YJDraggableDirection direction = YJDraggableDirectionDefault;
                
                if (_ratio_w <= 0) {
                    // left
                    if (_canDraggableDirection & YJDraggableDirectionLeft) {
                        direction = YJDraggableDirectionLeft;
                    }
                } else {
                    // right
                    if (_canDraggableDirection & YJDraggableDirectionRight) {
                        direction = YJDraggableDirectionRight;
                    }
                }
                
                
                
                [self.delegate cardContainderView:self updatePositionWithDraggableView:gesture.view
                               draggableDirection:direction
                                       widthRatio:fabs(_ratio_w)];
            }
        }
        
        [gesture setTranslation:CGPointZero inView:self];
    }
    
    if (gesture.state == UIGestureRecognizerStateEnded ||
        gesture.state == UIGestureRecognizerStateCancelled) {
        _isLoosen = YES;
        
        YJDraggableDirection direction = YJDraggableDirectionDefault;
        
        if (_ratio_w > kDragCompleteCoefficient_width_default && (_canDraggableDirection & YJDraggableDirectionRight)) {
            // right
            direction = YJDraggableDirectionRight;
        }
        
        if (_ratio_w < - kDragCompleteCoefficient_width_default && (_canDraggableDirection & YJDraggableDirectionLeft)) {
            // left
            direction = YJDraggableDirectionLeft;
        }
        
        if (direction == YJDraggableDirectionDefault) {
            [self cardViewDirectionAnimation:YJDraggableDirectionDefault undoHandler:nil];
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(cardContainerView:didEndDraggingAtIndex:draggableView:draggableDirection:)]) {
                [self.delegate cardContainerView:self didEndDraggingAtIndex:_currentIndex draggableView:gesture.view draggableDirection:direction];
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(currentSelectAtIndex:)]) {
                [self.delegate currentSelectAtIndex:_currentIndex];
            }
        }
    }
    
    _onScrollOffSet = point.x;
}


- (void)cardViewTap:(UITapGestureRecognizer *)gesture
{
    if (!_currentViews || _currentViews.count == 0) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(cardContainerView:didSelectAtIndex:draggableView:)]) {
        [self.delegate cardContainerView:self didSelectAtIndex:_currentIndex draggableView:gesture.view];
    }
}

@end
