//
//  ShowWeddingCardViewController.m
//  BoYi
//
//  Created by Chen on 2017/9/3.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import "ShowWeddingCardViewController.h"
#import "MakeWeddingCardViewController.h"

@interface ShowWeddingCardViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong,nonatomic) id response;
@property (weak, nonatomic) IBOutlet UIButton *makeBtn;

@end

@implementation ShowWeddingCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"详情";
    [self addPopBackBtn];
    
    
    if (self.model) {
        self.editBtn.hidden = NO;
        self.deleteBtn.hidden = NO;
//        [self addRightBtnWithTitle:@"分享" image:nil];
        [self.makeBtn setTitle:@"分享" forState:UIControlStateNormal];
    }
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?userid=%d",URL_findInvitaionByUserId,143]]]];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOMEURL,self.url]]]];
    [self loadData];
}

/**
 去制作
 */
- (IBAction)gotoMake:(id)sender {
    if (self.model) {
        //分享
        [self share];
    } else {
        MakeWeddingCardViewController *vc = [[MakeWeddingCardViewController alloc] init];
        vc.cardId = self.cardId;
        [self pushToNextVCWithNextVC:vc];
    }
    
}

/**
 分享
 */
- (void)share {
//    NSArray *images = @[[NSString stringWithFormat:@"%@%@",HOMEURL,self.response[@"url"]]];
    NSString *textToShare = @"爱的邀约，见证幸福时刻~";
    UIImage *imageToShare = [UIImage imageNamed:@"icon"];
    NSURL *urlToShare = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOMEURL,self.response[@"url"]]];
    NSArray *activityItems = @[textToShare, imageToShare, urlToShare];
    UIActivityViewController *activityController=[[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    [self.navigationController presentViewController:activityController animated:YES completion:nil];
}
/**
 编辑
 */
- (IBAction)edit:(id)sender {
    MakeWeddingCardViewController *vc = [[MakeWeddingCardViewController alloc] init];
    vc.cardId = self.cardId;
    vc.model  = self.model;
    [self pushToNextVCWithNextVC:vc];
}
/**
 删除
 */
- (IBAction)delete:(id)sender {
    
    @weakify(self);
    [[[RequestManager sharedManager] RACRequestUrl:URL_deleteUserInvitation
                                           method:GET
                                           loding:@"加载中..."
                                              dic:@{@"id":self.response[@"userInvitationId"]}] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [NavigateManager showMessage:@"删除成功!"];
        [self popViewConDelay];
    }];
}

/**
 请求
 */
- (void)loadData {
    
    @weakify(self);
    
    NSString *url = [NSString stringWithFormat:@"%@?id=%ld",URL_findInvitationById,self.cardId];
    if (self.model) {
        url = [NSString stringWithFormat:@"%@?id=%ld",URL_findInvitaionByUserId,self.model.id];
    }
    
    [[RequestManager sharedManager] GETUrl:url
                                       dic:nil
                                  progress:nil
                                   success:^(NSURLSessionDataTask *task, id response) {
                                       @strongify(self);
                                       
                                       [self loadUrl:response];
                                       
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       DLog(@"失败-------%@",error);
                                       dispatch_async(dispatch_get_main_queue(), ^{

                                           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                           
                                           if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
                                               DLog(@"%@",[NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode]);
                                               NSDictionary *info = httpResponse.allHeaderFields;
                                               [NavigateManager showMessage:[[NSString stringWithFormat:@"%@",info[@"msg"]] replaceUnicode]];
                                           } else {
                                               [NavigateManager showMessage:error.localizedDescription];
                                           }
                                       });
                                       
                                   }];
    
    
//    [[[RequestManager sharedManager] RACRequestUrl:url
//                                            method:GET
//                                            loding:nil
//                                               dic:nil] subscribeNext:^(id  _Nullable x) {
//
//    }];
}


/**
 加载地址
 */
- (void)loadUrl:(id)response {
    
    self.response = response;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOMEURL,response[@"url"]]]]];
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
