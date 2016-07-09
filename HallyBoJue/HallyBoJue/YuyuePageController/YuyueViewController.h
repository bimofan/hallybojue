//
//  YuyueViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/3.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"


@interface YuyueViewController : BaseViewController


@property (nonatomic,strong) UIViewController *superViewController;

@property (weak, nonatomic) IBOutlet UIView *leftView;


@property (weak, nonatomic) IBOutlet UITableView *leftTableView;


@property (weak, nonatomic) IBOutlet UIView *rightView;




@end
