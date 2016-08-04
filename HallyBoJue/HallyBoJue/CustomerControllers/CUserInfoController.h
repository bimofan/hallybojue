//
//  CUserInfoController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/6.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"
#import "CUserModel.h"

@interface CUserInfoController : BaseViewController



@property (nonatomic,strong)  CUserModel *cUserModel;



@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipLabel;

@property (weak, nonatomic) IBOutlet UIView *firstBackView;

@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;

@property (weak, nonatomic) IBOutlet UIView *secondBackView;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIView *thirdBackView;

@property (weak, nonatomic) IBOutlet UILabel *addTimeLabel;


@property (weak, nonatomic) IBOutlet UITableView *carTableView;


@property (weak, nonatomic) IBOutlet UIButton *registCard;

@property (weak, nonatomic) IBOutlet UILabel *vipaddresslabel;
@property (weak, nonatomic) IBOutlet UIButton *RemindButton;

- (IBAction)setRemindAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *updateCarInfo;

- (IBAction)updateCarInfoAction:(id)sender;

- (IBAction)registCardAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *uservipcardButton;

- (IBAction)showuservipcardAction:(id)sender;

@end
