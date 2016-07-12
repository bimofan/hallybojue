//
//  ThirdYuYueCell.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/12.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "ThirdYuYueCell.h"
#import "Constants.h"

@implementation ThirdYuYueCell

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
