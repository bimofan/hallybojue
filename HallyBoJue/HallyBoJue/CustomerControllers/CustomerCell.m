//
//  CustomerCell.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/4.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "CustomerCell.h"
#import "Constants.h"


@implementation CustomerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
     _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _addApointButton.clipsToBounds = YES;
    _addApointButton.layer.cornerRadius = kCornerRadous;
    
    _addApointButton.layer.borderColor = kBorderColor.CGColor;
    _addApointButton.layer.borderWidth = 1;
    
    
    _servicelistButton.clipsToBounds = YES;
    _servicelistButton.layer.cornerRadius = kCornerRadous;
    _servicelistButton.layer.borderWidth = 1;
    _servicelistButton.layer.borderColor = kBorderColor.CGColor;
    
    
    _sendMessageButton.clipsToBounds = YES;
    _sendMessageButton.layer.cornerRadius = kCornerRadous;
    _sendMessageButton.layer.borderColor = kBorderColor.CGColor;
    _sendMessageButton.layer.borderWidth = 1;
    
    
    _viplabel.clipsToBounds = YES;
    _viplabel.layer.cornerRadius = kCornerRadous;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
