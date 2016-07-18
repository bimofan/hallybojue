//
//  AddYuYueViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/16.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"
#import "CUserModel.h"

@interface AddYuYueViewController : BaseViewController


@property (nonatomic,strong) CUserModel *cUserModel;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *levelNameLabel;

@property (weak, nonatomic) IBOutlet UITableView *serviceTableView;

@property (weak, nonatomic) IBOutlet UIButton *summitButton;

@property (weak, nonatomic) IBOutlet UILabel *vipAddressLabel;

- (IBAction)summitAction:(id)sender;

@end
