//
//  ChoseVipCardViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/20.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"

@protocol  ChoseVipCardDelegate <NSObject>

-(void)didSelectedVipCard:(NSDictionary*)dict;


@end
@interface ChoseVipCardViewController : BaseViewController

@property (nonatomic,assign) id <ChoseVipCardDelegate>delegate;


@property (weak, nonatomic) IBOutlet UILabel *vipNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *vipDescLabel;

@property (weak, nonatomic) IBOutlet UILabel *vipPriceLabel;

@property (weak, nonatomic) IBOutlet UITableView *vipServiceTableView;
@property (weak, nonatomic) IBOutlet UIView *rightView;

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UILabel *expirDayLabel;

@end
