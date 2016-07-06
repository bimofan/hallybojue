//
//  CarTableViewCell.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/6.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "CarTableViewCell.h"
#import "Constants.h"

@implementation CarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    _backView.clipsToBounds = YES;
    _backView.layer.cornerRadius = kCornerRadous;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
