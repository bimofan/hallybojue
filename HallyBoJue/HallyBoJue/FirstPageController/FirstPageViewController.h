//
//  FirstPageViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/3.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"

@interface FirstPageViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *leftView;


@property (weak, nonatomic) IBOutlet UITableView *leftTableView;


@property (weak, nonatomic) IBOutlet UIView *rightView;


@property (weak, nonatomic) IBOutlet UISearchBar *rightSearchBar;

@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@end
