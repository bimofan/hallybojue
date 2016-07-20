//
//  SetRemindViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/19.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"

#import "CUserModel.h"

@interface SetRemindViewController : BaseViewController


@property (nonatomic,strong) CUserModel *cUserModel;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *realnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipnameLabel;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *remindTableView;
@property (weak, nonatomic) IBOutlet UITextField *remindcontentTextField;

@property (weak, nonatomic) IBOutlet UIButton *summitButton;


- (IBAction)summitAction:(id)sender;


@end
