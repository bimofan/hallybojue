//
//  OneYuyueViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/8.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderModel.h"

@interface OneYuyueViewController : BaseViewController



@property (nonatomic,strong) OrderModel *ordermodel;



@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *realnameLabel;

@property (weak, nonatomic) IBOutlet UILabel *plateLabel;

@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeOneLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeTwoLabel;

@property (weak, nonatomic) IBOutlet UITableView *serviceTable;

@property (weak, nonatomic) IBOutlet UIButton *checkButton;
- (IBAction)checkAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *sendButton;

- (IBAction)sendAction:(id)sender;



@end
