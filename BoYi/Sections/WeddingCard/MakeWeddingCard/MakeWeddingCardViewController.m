//
//  MakeWeddingCardViewController.m
//  BoYi
//
//  Created by Chen on 2017/9/3.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "MakeWeddingCardViewController.h"
#import "SelectPhotoView.h"
#import "CwDatePiker.h"

@interface MakeWeddingCardViewController ()
@property (weak, nonatomic) IBOutlet UITextField *groom;
@property (weak, nonatomic) IBOutlet UITextField *bride;
@property (weak, nonatomic) IBOutlet UITextField *invitationdate;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *invitationhotel;
@property (weak, nonatomic) IBOutlet UITextField *remark;
@property (weak, nonatomic) IBOutlet SelectPhotoView *selectPhoto;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectPhotoHeight;
//@property (strong,nonatomic) RACCommand *refreshDataCommand;
@end

@implementation MakeWeddingCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = self.model ? @"编辑喜帖" : @"制作喜帖";
    [self addPopBackBtn];
    [self addRightBtnWithTitle:@"保存" image:nil];
    
    [self.selectPhoto showInVc:self];
    __weak typeof(self) weakSelf = self;
    self.selectPhoto.adjustFrameBlock = ^(CGFloat height) {
        weakSelf.selectPhotoHeight.constant = height;
    };
    
    if (self.model) {
        self.groom.text = self.model.groom;
        self.bride.text = self.model.bride;
        self.invitationdate.text = self.model.invitationdate;
        self.address.text = self.model.adress;
        self.remark.text = self.model.remark;
        self.invitationhotel.text = self.model.invitationhotel;
        
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 0; i < 7; i++) {
            if ([self.model valueForKey:[NSString stringWithFormat:@"invitationimg%d",i + 1]]) {
                [imageArray addObject:[self.model valueForKey:[NSString stringWithFormat:@"invitationimg%d",i + 1]]];
            }
        }
        self.selectPhoto.imageArray = imageArray;
    }
}

- (void)respondsToRightBtn {
    if (self.groom.text == 0) {
        [NavigateManager showMessage:@"请输入新郎名字"];
        return;
    }
    if (self.bride.text == 0) {
        [NavigateManager showMessage:@"请输入新娘名字"];
        return;
    }
    if (self.invitationdate.text == 0) {
        [NavigateManager showMessage:@"请输入婚礼时间"];
        return;
    }
//    if (self.remark.text == 0) {
//        [NavigateManager showMessage:@"请输入附加留言"];
//        return;
//    }
    if (self.address.text == 0) {
        [NavigateManager showMessage:@"请输入婚礼地址"];
        return;
    }
    if (self.selectPhoto.imageArray.count == 0) {
        [NavigateManager showMessage:@"请选择照片"];
        return;
    }
    
    @weakify(self);
//    [[[RequestManager sharedManager] RACRequestUrl:self.model ? URL_updateUserInvitation : URL_insertMyInvitation
//                                           method:POST
//                                           loding:nil
//                                              dic:@{@"invitationid":@(self.cardId),
//                                                    @"userid":@([UserData sharedManager].userInfoModel.id)}] subscribeNext:^(id  _Nullable x) {
    
    
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"groom":self.groom.text,
                                                                                   @"bride":self.bride.text,
                                                                                   @"invitationdate":self.invitationdate.text,
                                                                                   @"adress":self.address.text,
                                                                                   @"userid":@([UserData sharedManager].userInfoModel.id),
                                                                                   @"invitationid":@(self.cardId)}];
        
        if (self.invitationhotel.text.length > 0) {
            [dic setObject:self.invitationhotel.text forKey:@"invitationhotel"];
        }
        if (self.remark.text.length > 0) {
            [dic setObject:self.remark.text forKey:@"remark"];
        }
        //如果是编辑，要加入id
    if (self.model) {
        [dic setObject:@(self.model.id) forKey:@"id"];
    }
    
    NSMutableArray *imageArr = [NSMutableArray array];
    if ([self.selectPhoto.imageArray.firstObject isKindOfClass:[UIImage class]]) {
        imageArr = self.selectPhoto.imageArray.mutableCopy;
    } else {
        for (id imageName in self.selectPhoto.imageArray) {
            [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:[NSURL URLWithString:ImageAppendURL(imageName)]
                                                            options:0
                                                                           progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                                                                               
                                                                           } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                                                                              [imageArr addObject:image];
                                                                           }];
        }
    }
    [NavigateManager showLoadingMessage:@"保存中..."];
    [[RequestManager sharedManager] updatePics:imageArr
                                           url:self.model ? URL_updateUserInvitation : URL_insertUserInvitation
                                    parameters:dic
                                      response:^(id response) {
                                          
                                          @strongify(self);
            if (response) {
                if ([response[@"status"] integerValue] == 200) {
                    
                    [NavigateManager showMessage:@"保存成功"];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    
                } else {
                    
                    [NavigateManager showMessage:[[NSString stringWithFormat:@"%@",response[@"msg"]] replaceUnicode]];
                }
                
            } else {
                [NavigateManager showMessage:@"上传失败，请重试"];
                
            }
            
        }];
        
//    }];
    
    
   

    
}
//- (RACCommand *)refreshDataCommand {
//    
//    if (!_refreshDataCommand) {
//        @weakify(self);
//        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//            
//            @strongify(self);
////            return [[RequestManager sharedManager] RACRequestUrl:URL_insertUserInvitation
////                                                          method:POST
////                                                          loding:@"加载中..."
////                                                             dic:input];
//            RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//                
//                NSURLSessionDataTask *task = [[RequestManager sharedManager] updatePics:@[] parameters:input response:^(id response) {
//                    if (response) {
//                        if ([response[@"status"] integerValue] == 200) {
//                            
//                            [subscriber sendNext:response[@"r"]];
//                            
//                        } else {
//                            [subscriber sendError:nil];
//                            [NavigateManager showMessage:[[NSString stringWithFormat:@"%@",response[@"msg"]] replaceUnicode]];
//                        }
//
//                    } else {
//                        [subscriber sendError:nil];
//                        [subscriber sendCompleted];
//
//                    }
//                    
//                }];
//                // 在信号量作废时，取消网络请求
//                return [RACDisposable disposableWithBlock:^{
//                    [task cancel];
//                }];
//                
//            }];
//            return requestSignal;
//        }];
//    }
//    return _refreshDataCommand;
//}


/**
 选择时间日期
 */
- (IBAction)selectTime:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    CwDatePiker *piker = [CwDatePiker showInView:self.view issele:NO block:^(NSDate *date) {
        weakSelf.invitationdate.text = [date fs_stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    }];
    piker.datePiker.datePickerMode = UIDatePickerModeDateAndTime;
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
