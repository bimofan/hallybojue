//
//  PushHistoryViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/25.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"
#import "CUserModel.h"

@interface PushHistoryViewController : BaseViewController


@property (nonatomic,strong) CUserModel *cUserModel;


@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UITableView *historyTableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipAddressLabel;




@end
