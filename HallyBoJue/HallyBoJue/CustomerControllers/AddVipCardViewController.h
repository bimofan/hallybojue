//
//  AddVipCardViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/20.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"
#import "CUserModel.h"

@interface AddVipCardViewController : BaseViewController



@property (nonatomic,strong) CUserModel *cUserModel;



@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *vipLabel;


@property (weak, nonatomic) IBOutlet UIButton *summitButton;

- (IBAction)summitAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *vipTableView;

@end
