//
//  FiveYuYueViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/16.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderModel.h"

@interface FiveYuYueViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UITableView *serviceTableView;

@property (nonatomic,strong) OrderModel *orderModel;


@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *plate_numLabel;

@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *vipcard_Label;


@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderSNLabel;
@property (weak, nonatomic) IBOutlet UIButton *changepaytypeButton;

@property (weak, nonatomic) IBOutlet UILabel *paytypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *order_amount_Label;
@property (weak, nonatomic) IBOutlet UILabel *order_old_amount_Label;

- (IBAction)changepaytypeAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *sendWorkerButton;

- (IBAction)sendWorkerAction:(id)sender;



@end
