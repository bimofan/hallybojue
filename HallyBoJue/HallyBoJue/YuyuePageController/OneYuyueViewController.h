//
//  OneYuyueViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/8.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderModel.h"


@protocol OneYuyueDelegate <NSObject>

-(void)didSelectedCarCheck:(OrderModel*)model;

-(void)startSendWorders:(OrderModel*)model;



@end
@interface OneYuyueViewController : BaseViewController



@property (nonatomic,strong) OrderModel *ordermodel;

@property (nonatomic,assign) id <OneYuyueDelegate>delegate;

@property (nonatomic,strong) UIViewController *superViewController;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *realnameLabel;

@property (weak, nonatomic) IBOutlet UILabel *plateLabel;

@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeOneLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeTwoLabel;


@property (weak, nonatomic) IBOutlet UILabel *vipcard_Label;

@property (weak, nonatomic) IBOutlet UITableView *serviceTable;

@property (weak, nonatomic) IBOutlet UIButton *checkButton;

- (IBAction)checkAction:(id)sender;




@property (weak, nonatomic) IBOutlet UIButton *sendButton;

- (IBAction)sendAction:(id)sender;





@property (weak, nonatomic) IBOutlet UIButton *printSheetButotn;

- (IBAction)printAction:(id)sender;



@property (weak, nonatomic) IBOutlet UIButton *addServiceButton;

- (IBAction)addServiceAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *showvipcardbutton;
- (IBAction)showvipAction:(id)sender;


@end
