//
//  AddCustomerController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/5.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "AddCustomerController.h"

@interface AddCustomerController ()

@end

@implementation AddCustomerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _nameBackView.clipsToBounds = YES;
    _nameBackView.layer.cornerRadius = kCornerRadous;
    
    _mobileBackView.clipsToBounds = YES;
    _mobileBackView.layer.cornerRadius = kCornerRadous;
    
    _nextButton.clipsToBounds = YES;
    _nextButton.layer.cornerRadius = kCornerRadous;
    
    
    
    
}


-(void)summitData
{
    
    int keeper_id = [UserInfo getkeeperid];
    
    [[NetWorking shareNetWorking] RequestWithAction:kAddCustomer Params:@{@"mobile":_mobileTF.text,@"user_real_name":_userrealnameTF.text,@"keeper_id":@(keeper_id)} itemModel:nil result:^(BOOL isSuccess, id data) {
       
        
        if (isSuccess) {
            
            if ([self.addCustomerDelegate respondsToSelector:@selector(didAddCustomer)]) {
                
                [self.addCustomerDelegate didAddCustomer];
                
            }
        }
        
    }];
}






- (IBAction)nextAction:(id)sender {
    
    if (![CommonMethods checkTel:_mobileTF.text]) {
        
        [CommonMethods showDefaultErrorString:@"请填写正确的手机号码"];
        
        
        return;
    }
    
    if (_userrealnameTF.text.length == 0) {
        
        [CommonMethods showDefaultErrorString:@"请填写客户姓名"];
        
        return;
    }
    
    [self summitData];
    
    
    
}
@end
