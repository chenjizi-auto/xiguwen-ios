//
//  BoYiYinYueViewMoreMode.m
//  BoYi
//
//  Created by zhoumeineng on 3/22/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "BoYiYinYueViewMoreMode.h"
#import "BoyiYinYueTableViewCell.h"
#import "BoyiYinYueModel.h"
@interface BoYiYinYueViewMoreMode()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) RACCommand *Command;

@property (nonatomic, strong) RACSubject *Subject;
@end
@implementation BoYiYinYueViewMoreMode
{
    NSArray<BoyiYinYueModel*> *dataSources;
    UITableView * table;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self);
        //处理正在请求状态
        [[self.Command executing] subscribeNext:^(NSNumber * _Nullable x) {
            @strongify(self);
        }];
        //请求成功
        [self.Command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
            @strongify(self);
            [self.Subject sendNext:x];
        }];
        
    }
    return self;
}

- (RACSubject *)Subject {
    
    if (!_Subject) _Subject = [RACSubject subject];
    
    return _Subject;
}
- (RACCommand *)Command {
    
    if (!_Command) {
        @weakify(self);
        _Command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [[RequestManager sharedManager] RACRequestUrl:[HOMEURL stringByAppendingString:@"appapi/Boyicollege/collegemusiclistall"]
                                                          method:POST
                                                          loding:@"加载中..."
                                                             dic:input];
        }];
    }
    return _Command;
}
-(void)Request:(NSDictionary*)param{
    [self.Command execute:param];
    [self.Subject subscribeNext:^(id  _Nullable x) {
        dataSources = [BoyiYinYueModel mj_objectArrayWithKeyValuesArray:x];
        [table reloadData];
    }];
    NSLog(@"dadsaf");
}
#pragma  ------------------ tableView Delegate dataSource ---------------------
- (void)MesaageDelegate:(UITableView*)objc{
    table = objc;
    table.delegate = self;
    table.dataSource = self;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BoyiYinYueTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"BoyiYinYueTableViewCell" owner:self options:nil].firstObject;
    }
    [cell setCellData:dataSources[indexPath.row]];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSources.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
@end
