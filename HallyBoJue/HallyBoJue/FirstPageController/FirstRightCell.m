//
//  FirstRightCell.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/3.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "FirstRightCell.h"
#import "Constants.h"

@implementation FirstRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.height/2;
     _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _levelLabel.clipsToBounds = YES;
    _levelLabel.layer.cornerRadius = 6.0;
    _levelLabel.layer.borderWidth = 1.0;
    _levelLabel.layer.borderColor = kLineColor.CGColor;
    
    _keeperView.clipsToBounds = YES;
    _keeperView.layer.cornerRadius = 6.0;
    
    _serviceView.clipsToBounds = YES;
    _serviceView.layer.cornerRadius = 6.0;
    
    _keeperHeadImageView.clipsToBounds = YES;
    _keeperHeadImageView.layer.cornerRadius = _keeperHeadImageView.frame.size.height/2;
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
