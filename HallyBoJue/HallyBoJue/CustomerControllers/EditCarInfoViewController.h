//
//  EditCarInfoViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/24.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"
#import "CUserModel.h"

@interface EditCarInfoViewController : BaseViewController

@property (nonatomic,strong) CUserModel *cUserModel;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipCarLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipAddressLabel;

@property (weak, nonatomic) IBOutlet UITableView *carSelectTableView;


@property (weak, nonatomic) IBOutlet UITextField *vi_numberTF;

@property (weak, nonatomic) IBOutlet UITextField *engine_numberTF;
@property (weak, nonatomic) IBOutlet UITextField *mileage_TF;
@property (weak, nonatomic) IBOutlet UIButton *saveCarInfoButton;
- (IBAction)saveCarInfoAction:(id)sender;

@end
