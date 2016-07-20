//
//  ChangePasswordViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/20.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangePasswordViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *oldPassWordTF;


@property (weak, nonatomic) IBOutlet UITextField *newpassTF;


@property (weak, nonatomic) IBOutlet UITextField *againPassWordTF;


@property (weak, nonatomic) IBOutlet UIButton *changeButton;

- (IBAction)changeAction:(id)sender;

@end
