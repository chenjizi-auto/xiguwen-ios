//
//  AnlieNewDetilViewModel.m
//  BoYi
//
//  Created by heng on 2017/12/24.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import "AnlieNewDetilViewModel.h"
#import "AnlieNewDetilTableViewCell.h"
#import "AnlieDetilThreeTableViewCell.h"
#import "PingjiaNewViewTableViewCell.h"
#import "AnlieTwoTableViewCell.h"
#import "AnlieBuThressTableViewCell.h"
#import "AnlieBufourTableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "ZLAnlieNewDetilCell.h"
#import "UIImage+Luban_iOS_Extension_h.h"

@implementation AnlieNewDetilViewModel

// custom code
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        @weakify(self);
        //处理正在请求状态
        [[self.refreshDataCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
        }];
        //请求成功
        [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.refreshUISubject sendNext:x];
        }];
        //处理正在请求状态
        [[self.deleguanzhuCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
            [NavigateManager hiddenLoadingMessage];
        }];
        //处理正在请求状态
        [[self.addguanzhuCommand executing] subscribeNext:^(NSNumber * _Nullable x) {
            
            @strongify(self);
            [NavigateManager hiddenLoadingMessage];
        }];
        [self.addguanzhuCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.addguanUISubject sendNext:x];
        }];
        [self.deleguanzhuCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.deleteguanzhuUISubject sendNext:x];
        }];
    }
    return self;
}

#pragma mark - public
/**
 根据刷新状态，判断数据加载
 
 @param object 请求成功的数据
 @param isHeaderRefersh 是否是下拉刷新
 */
- (void)ConvertingToObject:(id)object isHeaderRefersh:(BOOL)isHeaderRefersh {
    AnlieNewDetilModel *model = [AnlieNewDetilModel mj_objectWithKeyValues:object];
    NSArray *array = model.info.photourl;
    __weak typeof(self)weakSelf = self;
    for (NSInteger index = 0; index < array.count; index++) {
        Photourlanlie *imageModel = array[index];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 300.0)];
        imageView.backgroundColor = [UIColor colorWithRed:(240 + arc4random()%15) / 255.0 green:(240 + arc4random()%15) / 255.0 blue:(240 + arc4random()%15) / 255.0 alpha:1.0];
        imageModel.imageView = imageView;
        __weak typeof(imageModel)weakModel = imageModel;
        [imageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageModel.photourl]] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
            weakModel.imageView.image = image;
            CGFloat scale = image.size.height / image.size.width;
            CGFloat height = UIScreen.mainScreen.bounds.size.width * scale;
            weakModel.imageView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, height);
            if (weakSelf.reload) {
                weakSelf.reload();
            }
        } failure:nil];
    }
    self.model = model;
}


#pragma mark - private
- (RACSubject *)deleteguanzhuUISubject {
    
    if (!_deleteguanzhuUISubject) _deleteguanzhuUISubject = [RACSubject subject];
    
    return _deleteguanzhuUISubject;
}
- (RACSubject *)addguanUISubject {
    
    if (!_addguanUISubject) _addguanUISubject = [RACSubject subject];
    
    return _addguanUISubject;
}
- (RACSubject *)refreshUISubject {
    
    if (!_refreshUISubject) _refreshUISubject = [RACSubject subject];
    
    return _refreshUISubject;
}

- (RACSubject *)selectItemSubject {
    
    if (!_selectItemSubject) _selectItemSubject = [RACSubject subject];
    
    return _selectItemSubject;
}
- (RACSubject *)lookmingxiUISubject {
    
    if (!_lookmingxiUISubject) _lookmingxiUISubject = [RACSubject subject];
    
    return _lookmingxiUISubject;
}
- (RACSubject *)lookshangjiaUISubject {
    
    if (!_lookshangjiaUISubject) _lookshangjiaUISubject = [RACSubject subject];
    
    return _lookshangjiaUISubject;
}

- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:URL_New_anliedetails
                                                          method:POST
                                                          loding:@""
                                                             dic:input];
        }];
    }
    return _refreshDataCommand;
}
- (RACCommand *)deleguanzhuCommand {
    
    if (!_deleguanzhuCommand) {
        @weakify(self);
        _deleguanzhuCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:[HOMEURL stringByAppendingString:@"appapi/Follow/qgzcases"]
                                      loading:@""
                                Authorization:@""
                                         info:input];
        }];
    }
    return _deleguanzhuCommand;
}
- (RACCommand *)addguanzhuCommand {
    
    if (!_addguanzhuCommand) {
        @weakify(self);
        _addguanzhuCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [self requestSignalWithUrl:[HOMEURL stringByAppendingString:@"appapi/Follow/gzcases"]
                                      loading:@""
                                Authorization:@""
                                         info:input];
        }];
    }
    return _addguanzhuCommand;
}
#pragma mark - 网络请求
- (RACSignal *)requestSignalWithUrl:(NSString *)url
                            loading:(NSString *)loading
                      Authorization:(NSString *)Authorization
                               info:(NSDictionary *)info {
    
    RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        NSURLSessionDataTask *task = [[RequestManager sharedManager] requestUrl:url
                                                                         method:POST
                                                                         loding:loading
                                                                            dic:info
                                                                       progress:nil
                                                                        success:^(NSURLSessionDataTask *task, id response) {
                                                                            //
                                                                            [subscriber sendNext:response];
                                                                            [subscriber sendCompleted];
                                                                            
                                                                        } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                            // 如果网络请求出错，则加载数据库中的旧数据
                                                                            
                                                                            [subscriber sendError:[NSError errorWithDomain:error.domain code:error.code userInfo:error.userInfo]];
                                                                            [subscriber sendCompleted];
                                                                        }];
        // 在信号量作废时，取消网络请求
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
    return requestSignal;
}
#pragma mark -  tableView 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.model) {
        return 2;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.model.info.photourl.count + 3;
    }else {
        return self.model.pinglun.count + 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            
            CGFloat cellWidth = ScreenWidth - 32;
            CGSize size = [self.model.info.weddingdescribe sizeWithFont:[UIFont systemFontOfSize:15] Size:CGSizeMake(cellWidth, CGFLOAT_MAX)];
//            NSInteger zhangshu = self.model.info.photourl.count;
            return 440 + size.height + 0 + 15;
            //108 文字高度 240 * zhangshu
        }else if (indexPath.row < self.model.info.photourl.count + 1) {
            Photourlanlie *imageModel = self.model.info.photourl[indexPath.row - 1];
            return imageModel.imageView.height + 8.0;
        }else if (indexPath.row == self.model.info.photourl.count + 1) {
            NSInteger zhangshu = 0;
            if (self.model.team.count > 0 && self.model.team.count < 4) {
                zhangshu = 1;
            }
            if (self.model.team.count > 3 && self.model.team.count < 7) {
                zhangshu = 2;
            }
            if (self.model.team.count > 6 && self.model.team.count < 10) {
                zhangshu = 3;
            }
            
            return 246 + 143 * zhangshu;
        }else {
            
            return 38;
        }
    }else {
        if (indexPath.row == self.model.pinglun.count) {
            NSInteger zhangshu = self.model.gdanli.count / 2 +  self.model.gdanli.count % 2;
            return 51 + 220 * zhangshu + 10;
        }else {
            CGFloat cellWidth = ScreenWidth - 32;
            CGSize size = [self.model.pinglun[indexPath.row].comment sizeWithFont:[UIFont systemFontOfSize:15] Size:CGSizeMake(cellWidth, CGFLOAT_MAX)];
            NSInteger zhangshu;
            if (self.model.pinglun[indexPath.row].commphoto.count == 0) {
                zhangshu = 0;
            }else if (self.model.pinglun[indexPath.row].commphoto.count > 0 && self.model.pinglun[indexPath.row].commphoto.count < 4) {
                zhangshu = 1;
            }else if (self.model.pinglun[indexPath.row].commphoto.count > 3 && self.model.pinglun[indexPath.row].commphoto.count < 7) {
                zhangshu = 2;
            }else {
                zhangshu = 3;
            }
            return 76 + 20 + size.height + 100 * zhangshu;
        }
        
    }
   
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            AnlieNewDetilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnlieNewDetilTableViewCell"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"AnlieNewDetilTableViewCell" owner:nil options:nil].firstObject;
            }
            cell.model = self.model.info;
            @weakify(self);
            [[[cell.lookbtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                
                @strongify(self);
                [self.lookmingxiUISubject sendNext:nil];
            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
        }else if (indexPath.row < self.model.info.photourl.count + 1) {
            ZLAnlieNewDetilCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLAnlieNewDetilCell"];
            if (!cell) {
                cell = [[ZLAnlieNewDetilCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"ZLAnlieNewDetilCell"];
                cell.selectionStyle = NO;
            }
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            Photourlanlie *imageModel = self.model.info.photourl[indexPath.row - 1];
            [cell.contentView addSubview:imageModel.imageView];
            return  cell;
        }else if (indexPath.row == self.model.info.photourl.count + 1) {
            AnlieTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnlieTwoTableViewCell"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"AnlieTwoTableViewCell" owner:nil options:nil].firstObject;
            }
            cell.model = self.model;
            @weakify(self);
            [[[cell.lookBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                
                @strongify(self);
                [self.lookshangjiaUISubject sendNext:nil];
            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
        }else {
            AnlieBufourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnlieBufourTableViewCell"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"AnlieBufourTableViewCell" owner:nil options:nil].firstObject;
            }
            
            cell.title.text = [NSString stringWithFormat:@"用户评价（%ld）",self.model.pinglun.count];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
        }
    }else {
        if (indexPath.row == self.model.pinglun.count) {
            AnlieDetilThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnlieDetilThreeTableViewCell"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"AnlieDetilThreeTableViewCell" owner:nil options:nil].firstObject;
            }
            @weakify(self);
            [cell.self.selectItemSubject subscribeNext:^(id  _Nullable x) {
                @strongify(self);
                [self.selectItemSubject sendNext:x];
            }];
            cell.model = self.model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
        } else {
            AnlieBuThressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnlieBuThressTableViewCell"];
            if (!cell)
            {
                cell = [[NSBundle mainBundle] loadNibNamed:@"AnlieBuThressTableViewCell" owner:nil options:nil].firstObject;
            }
            cell.model = self.model.pinglun[indexPath.row];
            cell.tiaoshu = self.model.pinglun.count;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self.selectItemSubject sendNext:self.dataArray[indexPath.row]];
}
#pragma mark - DZNEmptyDataSetSource Methods



@end
