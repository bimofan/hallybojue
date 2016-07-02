//
//  FirstLeftCell.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/3.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstLeftCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *serviceViewHeight;
@property (weak, nonatomic) IBOutlet UIView *serviceView;
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel;


@property (weak, nonatomic) IBOutlet UIButton *catchButton;

- (IBAction)catchAction:(id)sender;

@end
