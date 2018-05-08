//
//  ShiPinMoreViewModel.h
//  BoYi
//
//  Created by zhoumeineng on 3/20/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ShiPinMoreViewModel : NSObject
@property(nonatomic,strong)RACSubject * Subject;
@property(nonatomic,strong)RACCommand * command;
-(void)MesaageDelegate:(UICollectionView*)objc;
-(void)Request:(NSDictionary*)param;
@property(nonatomic,weak)id object;
@end
