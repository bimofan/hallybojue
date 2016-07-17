//
//  FollowServiceListCell.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/17.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowServiceListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *keeper_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *servicesLabel;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *servicesLabelHeigh;


@end
