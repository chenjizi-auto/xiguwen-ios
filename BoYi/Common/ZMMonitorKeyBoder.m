//
//  ZMMonitorKeyBoder.m
//  BoYi
//
//  Created by zhoumeineng on 3/23/18.
//  Copyright © 2018 hengwu. All rights reserved.
//

#import "ZMMonitorKeyBoder.h"
#import "ZMKeyBoardFinshView.h"

@interface ZMMonitorKeyBoder()
@property(nonatomic,strong)ZMKeyBoardFinshView * KeyBoardFinshView;
@property(nonatomic,strong) UIView * CurrentTextView;
@end
@implementation ZMMonitorKeyBoder

static  ZMMonitorKeyBoder*  obj = nil;
+(ZMMonitorKeyBoder*)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
          obj = [[ZMMonitorKeyBoder alloc]init];
    });
    return obj;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (instancetype)init
{
    if (!obj) {
        @synchronized(obj){
            self = [super init];
            if (self) {
                [[NSNotificationCenter defaultCenter] addObserver:self
                                                         selector:@selector(keyboardWillShow:)
                                                             name:UIKeyboardWillShowNotification
                                                           object:nil];
                
                [[NSNotificationCenter defaultCenter] addObserver:self
                                                         selector:@selector(keyboardShow:)
                                                             name:UIKeyboardDidShowNotification
                                                           object:nil];
                
                [[NSNotificationCenter defaultCenter] addObserver:self
                                                         selector:@selector(keyboardWillHide:)
                                                             name:UIKeyboardWillHideNotification
                                                           object:nil];
                
                [[NSNotificationCenter defaultCenter] addObserver:self
                                                         selector:@selector(keyboardHide:)
                                                             name:UIKeyboardDidHideNotification
                                                           object:nil];
                
                
                [self interface];
            }
        }
    }
    
    return self;
}
-(void)interface{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextFieldTextDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextViewTextDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];

}
-(void)TextFieldTextDidBeginEditing:(NSNotification*)info{
    if ([info.object isMemberOfClass:[UITextField class]]) {
        self.CurrentTextView  = info.object;
      
    }else{
         self.CurrentTextView  = info.object;
    }
      [self.KeyBoardFinshView setKeyBoardTitles: ((UITextField*)self.CurrentTextView).placeholder];
}
-(void)TextViewTextDidBeginEditing:(NSNotification*)info{
    if ([info.object isMemberOfClass:[UITextView class]]) {
        self.CurrentTextView   = info.object;
    }
}

-(void)keyboardWillShow:(NSNotification*)notf{
    NSDictionary *userInfo = [notf userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    if (height<=226) {
        height+=40;
    }
     [[self keyWindow] addSubview: self.KeyBoardFinshView];
    self.KeyBoardFinshView.frame = CGRectMake(0, ScreenHeight-height, ScreenWidth, 40);

}

-(void)keyboardShow:(NSNotification*)notf{
    //self.Mblock(keyboardShow);
}
-(void)keyboardWillHide:(NSNotification*)notf{
    self.KeyBoardFinshView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 40);
    [self.KeyBoardFinshView removeFromSuperview];
}
-(void)keyboardHide:(NSNotification*)notf{
}

-(void)removeallNotify{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(UIWindow*)keyWindow{
    return [[UIApplication sharedApplication].windows lastObject];
}
- (ZMKeyBoardFinshView *)KeyBoardFinshView{
    if (!_KeyBoardFinshView) {
        _KeyBoardFinshView = [[NSBundle mainBundle] loadNibNamed:@"ZMKeyBoardFinshView" owner:self options:nil].firstObject;
        _KeyBoardFinshView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 40);
        /**
         * 按钮完成
         */
        __weak typeof(self)weakSelf = self;
        _KeyBoardFinshView.block = ^{
            if (weakSelf.CurrentTextView ) {
                if ([weakSelf.CurrentTextView isMemberOfClass:[UITextField class]]) {
                    [((UITextField*)weakSelf.CurrentTextView) endEditing:YES];
                }else if ([weakSelf.CurrentTextView isMemberOfClass:[UITextView class]]) {
                    [((UITextView*)weakSelf.CurrentTextView) endEditing:YES];
                }else {
                    [((UITextField*)weakSelf.CurrentTextView) endEditing:YES];
                }
            }
        };
    }
    return _KeyBoardFinshView;
}



@end
