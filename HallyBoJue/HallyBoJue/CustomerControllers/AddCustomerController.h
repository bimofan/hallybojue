//
//  AddCustomerController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/5.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"


@protocol AddCustomerDelegate <NSObject>

-(void)didAddCustomer;


@end
@interface AddCustomerController : BaseViewController


@property (nonatomic,assign) id <AddCustomerDelegate> addCustomerDelegate;

@property (weak, nonatomic) IBOutlet UIView *nameBackView;


@property (weak, nonatomic) IBOutlet UIView *mobileBackView;


@property (weak, nonatomic) IBOutlet UITextField *userrealnameTF;

@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UILabel *carbrandLabel;

@property (weak, nonatomic) IBOutlet UISearchBar *carSearchBar;

@property (weak, nonatomic) IBOutlet UITableView *carTableView;

@property (weak, nonatomic) IBOutlet UITextField *carnunTF;


- (IBAction)nextAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *countDownButton;
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
- (IBAction)countDownAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;




@end
