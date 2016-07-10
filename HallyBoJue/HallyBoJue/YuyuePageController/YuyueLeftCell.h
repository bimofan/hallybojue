//
//  YuyueLeftCell.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/3.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YuyueLeftCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *namecarnumLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *serviceview;
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceStatusLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *serviceLabelHeigh;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *serivceviewheight;



@end
