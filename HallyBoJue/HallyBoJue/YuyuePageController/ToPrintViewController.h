//
//  ToPrintViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/29.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderModel.h"

@interface ToPrintViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *orderidLabel;

@property (nonatomic,strong) UIButton *sender;

@property (nonatomic,strong) NSArray *carcheckArray;
@property (nonatomic,strong) OrderModel *orderModel;

@property (weak, nonatomic) IBOutlet UILabel *keeperLabel;

@property (weak, nonatomic) IBOutlet UILabel *drivernameLabel;

@property (weak, nonatomic) IBOutlet UILabel *carinfoLabel;

@property (weak, nonatomic) IBOutlet UITableView *serviceTableView;


@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *etaLabel;


@end
