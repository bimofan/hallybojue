//
//  ChangePasswordViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/20.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _changeButton.clipsToBounds= YES;
    _changeButton.layer.cornerRadius = kCornerRadous;
    
    _newpassTF.delegate = self;
    _againPassWordTF.delegate= self;
    _oldPassWordTF.delegate = self;
    
    
}





- (IBAction)changeAction:(id)sender {
    
    if (_oldPassWordTF.text.length == 0) {
        
        [CommonMethods showDefaultErrorString:@"请填写旧密码"];
        return;
        
    }
    
    if (_newpassTF.text.length == 0 || _againPassWordTF.text.length == 0) {
        
        [CommonMethods showDefaultErrorString:@"请填写新密码"];
        return;
        
    }
    
    if (![_newpassTF.text isEqualToString:_againPassWordTF.text]) {
        
        [CommonMethods showDefaultErrorString:@"两次输入的密码不一致"];
        
        return;
    }
    
    int keeper_id = [UserInfo getkeeperid];
    
    NSDictionary *params = @{@"keeper_id":@(keeper_id),@"oldpass":_oldPassWordTF.text,@"newpass":_newpassTF.text};
    
    [[NetWorking shareNetWorking] RequestWithAction:kChangePassWord Params:params itemModel:nil result:^(BOOL isSuccess, id data) {
       
        if (isSuccess) {
            
            [CommonMethods showDefaultErrorString:@"密码修改成功!"];
            
            _oldPassWordTF.text= nil;
            _newpassTF.text = nil;
            _againPassWordTF.text = nil;
            
            
            
            
        }
    }];
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField == _newpassTF  || textField == _againPassWordTF) {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y - 150);
            
            
        }];
        
    }

}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField == _newpassTF || textField == _againPassWordTF) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 150);
            
            
        }];
        
    }

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}
@end
