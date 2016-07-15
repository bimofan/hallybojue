//
//  FourVIPCell.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/15.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "FourVIPCell.h"
#import "Constants.h"

@implementation FourVIPCell

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
