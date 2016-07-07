//
//  ServiceCategoryViewController.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/7.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "ServiceCategoryViewController.h"

@interface ServiceCategoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *categories;

@end

@implementation ServiceCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _categories.count;
    
}







@end
