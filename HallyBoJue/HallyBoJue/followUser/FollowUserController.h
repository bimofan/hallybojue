//
//  FollowUserController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/17.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"

@interface FollowUserController : BaseViewController


@property (weak, nonatomic) IBOutlet UIView *leftView;

@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@property (weak, nonatomic) IBOutlet UITableView *userTableView;


@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *vipNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *setButton;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UIButton *setfollowButton;
- (IBAction)setfollowAction:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *vipAddressLabel;

- (IBAction)setAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *historyserviceTable;

@end
