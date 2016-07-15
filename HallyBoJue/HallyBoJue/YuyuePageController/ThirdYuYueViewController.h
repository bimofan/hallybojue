//
//  ThirdYuYueViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/12.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderModel.h"

@protocol ThirdViewDelegate <NSObject>

-(void)didDoneService:(OrderModel*)orderModel;


@end

@interface ThirdYuYueViewController : BaseViewController


@property (nonatomic,strong) UIViewController*superViewController;

@property (nonatomic,strong) OrderModel *orderModel;

@property (nonatomic,assign) id <ThirdViewDelegate> delegate;


@property (weak, nonatomic) IBOutlet UIImageView *headImageView;


@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *plateNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;

@property (weak, nonatomic) IBOutlet UITableView *serviceTableView;


@property (weak, nonatomic) IBOutlet UIButton *checkCarButton;

- (IBAction)checkCarAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

- (IBAction)doneAction:(id)sender;


@end
