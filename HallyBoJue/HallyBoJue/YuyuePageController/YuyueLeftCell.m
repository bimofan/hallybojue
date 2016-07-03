//
//  YuyueLeftCell.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/3.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "YuyueLeftCell.h"
#import "Constants.h"

@implementation YuyueLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.height/2;
    
    _serviceview.clipsToBounds = YES;
    _serviceview.layer.cornerRadius = kCornerRadous;
    
    _serviceStatusLabel.clipsToBounds = YES;
    _serviceStatusLabel.layer.cornerRadius = kCornerRadous;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
