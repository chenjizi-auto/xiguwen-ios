//
//  ZLElectronicInvitationEditPage.h
//  ProjectModules
//
//  Created by zhaolei on 2018/6/9.
//  Copyright © 2018年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLElectronicInvitationEditPageDelegate<NSObject>

///更改图片
- (void)changeImageWithIndexPath:(NSIndexPath *)indexPath;
///更改文字
- (void)saveTextWithIndexPath:(NSIndexPath *)indexPath LatestText:(NSString *)value;

@end

@interface ZLElectronicInvitationEditPage : UIView

///代理
@property (nonatomic,weak) id <ZLElectronicInvitationEditPageDelegate>delegate;
///当前页码
@property (nonatomic,unsafe_unretained,readonly) NSInteger currentPageIndex;
///页码[里面包含每页数据]
@property (nonatomic,strong) NSArray *unitViews;

/*配置编辑页参数
 
 @param frame 展示区域和位置
 @param pageSize 最大单元的尺寸
 @param space 间距、缩放高度
 @param unitViews 每页数据（例： @[@[每页子视图,每页子视图],@[每页子视图,每页子视图]]）
 */
- (void)setupEditPageWithFrame:(CGRect)frame PageSize:(CGSize)pageSize Space:(CGFloat)space UnitViews:(NSArray *)unitViews;

@end
