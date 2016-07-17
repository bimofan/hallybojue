//
//  FollowUserCell.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/17.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "FollowUserCell.h"
#import "Constants.h"

@implementation FollowUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    
    _vipCardLabel.clipsToBounds = YES;
    _vipCardLabel.layer.cornerRadius = kCornerRadous;
    
    _nextserviceNameLabel.clipsToBounds = YES;
    _nextserviceNameLabel.layer.cornerRadius = kCornerRadous;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
