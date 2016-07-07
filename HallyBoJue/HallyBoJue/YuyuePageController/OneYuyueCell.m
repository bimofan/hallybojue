//
//  OneYuyueCell.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/8.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "OneYuyueCell.h"
#import "Constants.h"

@implementation OneYuyueCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _service_nameLabel.clipsToBounds = YES;
    _service_nameLabel.layer.cornerRadius = kCornerRadous;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
