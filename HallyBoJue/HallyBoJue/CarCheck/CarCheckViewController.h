//
//  CarCheckViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/9.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CarCheckViewController : BaseViewController





@property (weak, nonatomic) IBOutlet UITableView *firstTableView;

@property (weak, nonatomic) IBOutlet UITableView *secondTableView;

@property (weak, nonatomic) IBOutlet UIButton *photoButton;

- (IBAction)photoAction:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *problemNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *suggestLabel;

@property (weak, nonatomic) IBOutlet UITextView *suggestTextView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *summit;


@property (weak, nonatomic) IBOutlet UIButton *advisButton;

- (IBAction)adviseAction:(id)sender;


- (IBAction)summitAction:(id)sender;



@end
