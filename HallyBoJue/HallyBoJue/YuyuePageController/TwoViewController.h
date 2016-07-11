//
//  TwoViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/10.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderModel.h"

@interface TwoViewController : BaseViewController




@property (nonatomic,strong) OrderModel *orderModel;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;


@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *plateNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;




@property (weak, nonatomic) IBOutlet UITextField *timeTextField;

@property (weak, nonatomic) IBOutlet UITableView *workerTableView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (weak, nonatomic) IBOutlet UIButton *startService;

- (IBAction)startServiceAction:(id)sender;

@end
