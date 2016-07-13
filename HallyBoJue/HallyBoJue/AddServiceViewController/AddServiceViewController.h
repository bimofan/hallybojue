//
//  AddServiceViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/13.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderModel.h"

@interface AddServiceViewController : BaseViewController



@property (nonatomic,strong) OrderModel *orderModel;

@property (weak, nonatomic) IBOutlet UITableView *firstTableView;


@property (weak, nonatomic) IBOutlet UITableView *secondTableView;

@property (weak, nonatomic) IBOutlet UITableView *thirdTableView;

@end
