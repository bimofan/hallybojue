//
//  FiveYuYueCell.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/16.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "FiveYuYueCell.h"
#import "Constants.h"

@implementation FiveYuYueCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    _serviceNameLabel.clipsToBounds = YES;
    _serviceNameLabel.layer.cornerRadius = kCornerRadous;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
