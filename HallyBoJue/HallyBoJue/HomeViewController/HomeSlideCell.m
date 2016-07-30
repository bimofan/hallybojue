//
//  HomeSlideCell.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/1.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "HomeSlideCell.h"

@implementation HomeSlideCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _numberLabel.clipsToBounds=  YES;
    _numberLabel.layer.cornerRadius = _numberLabel.frame.size.width/2;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
