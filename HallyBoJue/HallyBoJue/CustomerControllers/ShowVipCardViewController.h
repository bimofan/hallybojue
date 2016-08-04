//
//  ShowVipCardViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/8/4.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"

@interface ShowVipCardViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *vipcardnameLabel;

@property (weak, nonatomic) IBOutlet UILabel *validateLabel;



@property (weak, nonatomic) IBOutlet UITableView *serviceTableView;

@property (weak, nonatomic) IBOutlet UITableView *vipcardTableView;


@property (weak, nonatomic) IBOutlet UILabel *carinfoLabel;

@end
