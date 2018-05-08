//
//  AddIDoneViewController.m
//  BoYi
//
//  Created by heng on 2018/1/12.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "AddIDoneViewController.h"
#import "AddIDTwoViewController.h"
#import "BankCardModel.h"
@interface AddIDoneViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (nonatomic, strong) BankCardModel *model;

@end

@implementation AddIDoneViewController

- (BankCardModel *)model {
	if (!_model) {
		_model = [[BankCardModel alloc] init];
	}
	return _model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加银行卡";
    [self addPopBackBtn];
	
	[self.nextBtn setUserInteractionEnabled:NO];
    self.nameTF.delegate = self;
    self.nameTF.inputAccessoryView = [self addToolbar];
    self.numberTF.delegate = self;
    self.numberTF.inputAccessoryView = [self addToolbar];
}

- (IBAction)next:(UIButton *)sender {
	
	self.model.name = self.nameTF.text;
	self.model.bandnumber = self.numberTF.text;
	
    AddIDTwoViewController *add = [[AddIDTwoViewController alloc] init];
	add.model = self.model;
    [self pushToNextVCWithNextVC:add];
}

//- (void)textFieldDidEndEditing:(UITextField *)textField {
//
//}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if (self.nameTF.text.length > 0 && self.numberTF.text.length > 0) {
		[self.nextBtn setUserInteractionEnabled:YES];
		[self.nextBtn setBackgroundColor:UIColorFromRGB(0xFF7299)];
	} else {
		[self.nextBtn setUserInteractionEnabled:NO];
		[self.nextBtn setBackgroundColor:UIColorFromRGB(0xD9D9D9)];
	}
	return YES;
}



@end
