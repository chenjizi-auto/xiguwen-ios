#import <UIKit/UIKit.h>
@interface KaiTongVIPView : UIView
@property (copy,nonatomic) void(^ block)(NSDictionary *dic);
@property (copy,nonatomic) void(^ paySuccess)(NSString *model);
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) NSDictionary *dicData;
+ (KaiTongVIPView *)showInView:(UIView *)view block:(void(^)(NSDictionary *dic))block;

@end
