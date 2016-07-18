//
//  ServiceHistoryViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/18.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"

@interface ServiceHistoryViewController : BaseViewController


@property (nonatomic,strong) CUserModel *cUsermodel;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;


@property (weak, nonatomic) IBOutlet UIButton *setRemindButton;

- (IBAction)setRemindAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *vipNameLabel;


@property (weak, nonatomic) IBOutlet UILabel *vipAddressLabel;

@property (weak, nonatomic) IBOutlet UITableView *historyTable;

@end
