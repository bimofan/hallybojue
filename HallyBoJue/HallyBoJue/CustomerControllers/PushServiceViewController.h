//
//  PushServiceViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/21.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"
#import "CUserModel.h"

@interface PushServiceViewController : BaseViewController


@property (nonatomic,strong) CUserModel  *cUserModel;


@property (weak, nonatomic) IBOutlet UITableView *serviceTableView;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *vipCardLabel;

@property (weak, nonatomic) IBOutlet UITextField *noteLabel;

@property (weak, nonatomic) IBOutlet UIButton *summitButton;
- (IBAction)summitAction:(id)sender;




@end
