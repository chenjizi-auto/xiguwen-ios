#import "IAPManager.h"
#import <StoreKit/StoreKit.h>
                     //用户联系信息相关
@interface IAPManager()<SKProductsRequestDelegate, SKPaymentTransactionObserver>

@end

@implementation IAPManager
+(instancetype)sharedManager{
    static dispatch_once_t onceToken;
    static IAPManager * iAPManager;
    
    dispatch_once(&onceToken, ^{
        iAPManager = [[IAPManager alloc] init];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:iAPManager];
    });
    return iAPManager;
}

/**
 *  @brief     添加IAP观察者
 */

-(void)addTheIAPObserver{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}
/**
 *  @brief     删除IAP观察者
 */
-(void)removeTheIAPOberver{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    
}
/*
 从Apple查询用户点击购买的产品的信息
 获取到信息以后，根据获取的商品详细信息
 */
- (void)getProductInfo:(NSString *)productIdentifier{
    if (![SKPaymentQueue canMakePayments])
    {
        if (_IAPDelegate && [_IAPDelegate respondsToSelector:@selector(IAPFailedWithWrongInfor:)])
        {
            [_IAPDelegate IAPFailedWithWrongInfor:@"程序内不允许付款"];
            UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                message:@"请先开启应用内付费购买功能。"
                                                               delegate:nil cancelButtonTitle:NSLocalizedString(@"关闭",nil) otherButtonTitles:nil];
            
            [alerView show];
            
        }
        return;
    }
    
    if (productIdentifier.length > 0)
    {
        NSArray * product = [[NSArray alloc] initWithObjects:productIdentifier, nil];
        NSSet *set = [NSSet setWithArray:product];
        SKProductsRequest * request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
        request.delegate = self;
        [request start];
    }
    else
    {
        if (_IAPDelegate && [_IAPDelegate respondsToSelector:@selector(IAPFailedWithWrongInfor:)])
        {
            [_IAPDelegate IAPFailedWithWrongInfor:@"产品ID为空"];
        }
    }
}

/*
 查询成功后的回调
 经由getProductInfo函数发起的产品信息查询，成功后返回执行的回调。再更具回调内容发起购买请求
 */
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *myProduct = response.products;
    if (myProduct.count == 0)
    {
        if (_IAPDelegate && [_IAPDelegate respondsToSelector:@selector(IAPFailedWithWrongInfor:)])
        {
            [_IAPDelegate IAPFailedWithWrongInfor:@"无法获得商品信息"];
        }
        return;
    }
    
    //发起购买操作
    SKPayment * payment = [SKPayment paymentWithProduct:myProduct[0]];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
    
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    if (_IAPDelegate && [_IAPDelegate respondsToSelector:@selector(IAPFailedWithWrongInfor:)])
    {
        [_IAPDelegate IAPFailedWithWrongInfor:error.localizedDescription];
    }
}


//购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
                //交易完成
            case SKPaymentTransactionStatePurchased:
                // 购买后告诉交易队列，把这个成功的交易移除掉
                [queue finishTransaction:transaction];
                [self completeTransaction:transaction];
                break;
                //交易失败
            case SKPaymentTransactionStateFailed:
                // 交易失败中也要把这个交易移除掉
                [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
                [_IAPDelegate IAPFailedWithWrongInfor:@"购买失败"];
                break;
                
                //已经购买过该商品
            case SKPaymentTransactionStateRestored:
                // 回复购买中也要把这个交易移除掉
                [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
                break;
                //商品添加进列表
            case SKPaymentTransactionStatePurchasing:
                break;
                
            default:
                break;
        }
    }
    
}

//交易成功，与服务器比对传输货单号
- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    //目前苹果公司提倡的获取购买凭证的方法
    NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
    NSLog(@"receiptUrl %@            receiptData %@",receiptUrl,receiptData);
    //base64位的产品验证码单，base64是服务端和苹果进行校验所必须的，苹果的文档要求凭证经过Base64加密
    NSString * transactionReceiptString = [receiptData base64EncodedStringWithOptions:0];
    //将加密后的transactionReceiptString发送给后台服务端进行校验，在此之前，记得先保存购买凭证

    if (_IAPDelegate && [_IAPDelegate respondsToSelector:@selector(IAPPaySuccessFunctionWithBase64:)]){
        NSLog(@"receiptUrl %d come in ",_IAPDelegate == NULL);
        [_IAPDelegate IAPPaySuccessFunctionWithBase64:transactionReceiptString];
    }
    //完整结束此次在App Store的交易，没有这句代码的调用，下次购买会提示已经购买该商品
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}



@end
