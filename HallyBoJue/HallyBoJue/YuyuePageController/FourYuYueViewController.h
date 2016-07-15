//
//  FourYuYueViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/14.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderModel.h"

@interface FourYuYueViewController : BaseViewController



@property (nonatomic,strong) OrderModel *orderModel;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *realnameLabel;


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (weak, nonatomic) IBOutlet UILabel *plate_numLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;


@property (weak, nonatomic) IBOutlet UITableView *serviceTable;


@property (weak, nonatomic) IBOutlet UIButton *summitButton;
- (IBAction)summitAction:(id)sender;

@end
