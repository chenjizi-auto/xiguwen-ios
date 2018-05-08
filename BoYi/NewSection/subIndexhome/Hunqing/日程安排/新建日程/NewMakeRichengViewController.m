//
//  NewMakeRichengViewController.m
//  BoYi
//
//  Created by heng on 2018/1/4.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "NewMakeRichengViewController.h"
#import "CwDatePiker.h"
#import "WHpickDate.h"
#import "UItextViewWithPlaceHloder.h"
@interface NewMakeRichengViewController ()

@property (weak, nonatomic) IBOutlet UItextViewWithPlaceHloder *textvieww;
@property (nonatomic, strong) NSDate *beforeDate;
@property (nonatomic, strong) NSDate *afterDate;

@end

@implementation NewMakeRichengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新建日程";
    [self addPopBackBtn];
    [self addRightBtnWithTitle:@"保存" image:nil];
    if (isIPhoneX) {
        self.height.constant = 84;
    }
	self.textvieww.delegate = self;
	self.textvieww.inputAccessoryView = [self addToolbar];
	self.textvieww.placeholder = @"请输入事项内容";
	
	[self.day setText:[[NSDate date] fs_stringWithFormat:@"yyyy-MM-dd"]];
	
	
	if (self.model) {
		[self.day setText:self.model.riqi];
		[self.star setText:self.model.statime];
		[self.end setText:self.model.endtime];
		[self.textvieww setText:self.model.conn];
		
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"HH:mm"];
		self.beforeDate = [dateFormatter dateFromString:self.model.statime];
		self.afterDate = [dateFormatter dateFromString:self.model.endtime];
	}
    self.textvieww.delegate = self;
    self.textvieww.inputAccessoryView = [self addToolbar];
}
- (void)respondsToRightBtn {
    if (self.textvieww.text.length == 0) {
        [NavigateManager showMessage:@"请填写事项内容"];
        return;
    }
	
	NSComparisonResult result = [self.beforeDate compare:self.afterDate];
	if (result != NSOrderedAscending) {
		[NavigateManager showMessage:@"结束时间不能小于开始时间"];
		return;
	}
	
    
	NSDictionary *dic;
	if (self.isEdit) {
		dic = @{@"id":@(self.model.id),@"conn":self.textvieww.text,@"endtime":self.end.text,@"riqi":self.day.text,@"statime":self.star.text,@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};

	} else {
		dic = @{@"conn":self.textvieww.text,@"endtime":self.end.text,@"riqi":self.day.text,@"statime":self.star.text,@"token":[UserDataNew sharedManager].userInfoModel.token.token,@"userid":@([UserDataNew sharedManager].userInfoModel.token.userid)};
	}
	
	
	[[RequestManager sharedManager] requestUrl:self.isEdit ? URL_editMyRicheng : URL_New_addricheng
                                        method:POST
                                        loding:@""
                                           dic:dic
                                      progress:nil
                                       success:^(NSURLSessionDataTask *task, id response) {
                                           if ([response[@"code"] integerValue] == 0) {
                                               [NavigateManager showMessage:@"添加成功"];
//                                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
											   
                                                   [self popViewConDelay];;
//                                               });
											   
                                           }else{
                                               
                                               [NavigateManager showMessage:response[@"message"]];
                                           }
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       }];
    
}
- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {
        __weak typeof(self) weakSelf = self;
        [CwDatePiker showInView:weakSelf.view issele:YES block:^(NSDate *date) {
            NSString *dateString = [date fs_stringWithFormat:@"yyyy-MM-dd"];
            weakSelf.day.text = dateString;
        }];
    }else if (sender.tag == 1) {
        __weak typeof(self) weakSelf = self;
        [WHpickDate showInView:weakSelf.view block:^(NSDate *date) {
			
			weakSelf.beforeDate = date;
            NSString *dateString = [date fs_stringWithFormat:@"HH:mm"];
            weakSelf.star.text = dateString;

        }];
    }else {
        __weak typeof(self) weakSelf = self;
        [WHpickDate showInView:weakSelf.view block:^(NSDate *date) {
            
            weakSelf.afterDate = date;
            NSString *dateString = [date fs_stringWithFormat:@"HH:mm"];
            weakSelf.end.text = dateString;
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
