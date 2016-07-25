//
//  FirstLeftCell.m
//  HallyBoJue
//
//  Created by Haikun Zhu on 16/7/3.
//  Copyright © 2016年 Haikun Zhu. All rights reserved.
//

#import "FirstLeftCell.h"
#import "Constants.h"

@implementation FirstLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
     _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = _headImageView.frame.size.height/2;
    _serviceView.clipsToBounds = YES;
    _serviceView.layer.cornerRadius = kCornerRadous;
    
    _catchButton.clipsToBounds = YES;
    _catchButton.layer.cornerRadius = kCornerRadous;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)catchAction:(id)sender {
}
@end
