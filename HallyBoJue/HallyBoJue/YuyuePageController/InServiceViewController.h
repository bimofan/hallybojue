//
//  InServiceViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/29.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderModel.h"

@protocol InServiceDelegate <NSObject>

-(void)newDoneService:(OrderModel*)orderModel;


@end
@interface InServiceViewController : BaseViewController


@property (nonatomic,assign) id <InServiceDelegate> delegate;


@property (nonatomic,strong) OrderModel *orderModel;


@property (weak, nonatomic) IBOutlet UIImageView *headImageVie;


@property (weak, nonatomic) IBOutlet UILabel *namLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *plate_number_Label;


@property (weak, nonatomic) IBOutlet UILabel *vipcard_Label;


@property (weak, nonatomic) IBOutlet UILabel *status_Label;


@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;

@property (weak, nonatomic) IBOutlet UITableView *serviceTable;


@property (weak, nonatomic) IBOutlet UIButton *doneService;

@property (weak, nonatomic) IBOutlet UIButton *addServiceButton;


@property (weak, nonatomic) IBOutlet UIButton *printButton;


- (IBAction)printAction:(id)sender;

- (IBAction)addServiceAction:(id)sender;

- (IBAction)doneServiceAction:(id)sender;



@end
