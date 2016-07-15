//
//  FourServiceCell.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/15.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "FourServiceCell.h"
#import "Constants.h"


@implementation FourServiceCell

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
