//
//  LoginViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/2.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *summitbutton;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
- (IBAction)summit:(id)sender;

@end
