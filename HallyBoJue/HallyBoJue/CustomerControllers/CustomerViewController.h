//
//  CustomerViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/4.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"

@interface CustomerViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>



@property (weak, nonatomic) IBOutlet UIButton *addCustomButton;

- (IBAction)addCustomAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *cusSearchBar;

@end
