//
//  FirstRightCell.h
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/3.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstRightCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *carLabel;


@property (weak, nonatomic) IBOutlet UILabel *levelLabel;


@property (weak, nonatomic) IBOutlet UIImageView *keeperHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *keeperName;
@property (weak, nonatomic) IBOutlet UILabel *lastTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *changedButton;

@property (weak, nonatomic) IBOutlet UIButton *addAppointButton;


@property (weak, nonatomic) IBOutlet UILabel *lastServiceLabel;

@property (weak, nonatomic) IBOutlet UIView *keeperView;

@property (weak, nonatomic) IBOutlet UIView *serviceView;



@end
