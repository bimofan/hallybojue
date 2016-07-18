//
//  FAQViewController.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/18.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "BaseViewController.h"

@interface FAQViewController : BaseViewController



@property (weak, nonatomic) IBOutlet UITableView *FAQTableView;

@property (weak, nonatomic) IBOutlet UILabel *selectedTitleLabel;


@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIView *leftView;


@end
